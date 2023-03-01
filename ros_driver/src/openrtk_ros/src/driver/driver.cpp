/*******************************************************
 * @file driver.cpp
 * @author khshen (khshen@aceinna.com)
 * @brief 
 * @date 2021-06-10
 * 
 * @copyright Copyright (c) 2021
 * 
*******************************************************/
#include "driver.h"

// General macros
#define RAD2DEG 180/3.14159265
#define SECONDS_IN_WEEK 604800

// Macros for GNSS messages
#define RECV_BUFFER_SIZE 2000
#define GNSS_HEADER "$GNSS"

// Macros for IMU messages
#define IMU_HEADER "$IMU"

// Network macros
#define     LOCAL_PORT 2204
#define     LOCAL_IP_ADDRESS "192.168.137.69"           //here ,it is your ROS IP ,you should change it
#define     OPENRTK_GET_HOSTIP      "python3 /home/oskar/aceinna-rtk/ros_driver/src/openrtk_ros/netbios.py"

#define HANDSTR "hello pc i'm openrtk_data"
#define HANDBK "log debug on\r\n"

const uint8_t HandStr[] = {"hello pc i'm openrtk_data"};
const uint8_t Handbk[] = {"log debug on\r\n"};

RTKDriver::RTKDriver(ros::NodeHandle nh)
    : m_nh(nh)
{
    cout << "RTKDriver:RTKDriver()" << endl;
    
    /*Eth init*/
    sockstrlen = sizeof(struct sockaddr_in); 
    sock_Cli = -1;

    /*******server Addr Init********/   
    sock_Ser = socket(AF_INET, SOCK_STREAM, 0);  
    int opt = 1;
    setsockopt(sock_Ser, SOL_SOCKET,
                SO_REUSEADDR | SO_REUSEPORT, &opt,
                sizeof(opt));
    memset(&addr_server, 0, sizeof(addr_server));   
    memset(&addr_sensor, 0, sizeof(addr_sensor));
    addr_server.sin_family = AF_INET;    
    addr_server.sin_addr.s_addr = inet_addr(LOCAL_IP_ADDRESS); 
    addr_server.sin_port = htons(LOCAL_PORT); 

    // Define publishers
    m_pub_imu  = m_nh.advertise<sensor_msgs::Imu>("imu_msg", 100);
    m_pub_gnss = m_nh.advertise<sensor_msgs::NavSatFix>("gnss_msg", 100);
}

RTKDriver::~RTKDriver()
{
    cout << "RTKDriver:~RTKDriver()" << endl;
}

void RTKDriver::Start()
{
    // Give host IP info to aceinna rtk
    int retval = system(OPENRTK_GET_HOSTIP);
    if (retval == -1){
        cout << "System call to openrtk failed" << endl;
        ros::shutdown();
    }

    int8_t hostname[20];
    uint8_t cnt = 0;

    /*Start TCP Server Init*/
    while((bind(sock_Ser,(struct sockaddr *)&addr_server,sockstrlen) < 0)           /*try to bind at most 10s*/
        && (cnt < 10))
    {
        cout << "bind server addr error" << endl; 
        usleep(1000); // 1 ms   
        cnt++;
    }

    cnt = 0;
    while((listen(sock_Ser, 30) < 0) && (cnt < 10))
    {
        cout << "listen server  error" << endl;
        usleep(1000); // 1 ms
        cnt++;
    }

    cnt = 0;
    while((sock_Cli < 0) && (cnt < 10))
    {
        sock_Cli = accept(sock_Ser,(struct sockaddr *)&addr_sensor,&sockstrlen);
        if(sock_Cli == -1)
        {
            cout << "call to accept" << endl;
            usleep(1000); // 1 ms
            cnt++;
            continue;
        }
        inet_ntop(AF_INET,&addr_sensor.sin_addr,(char*)hostname,sizeof(hostname));  
        cout << "client name is " << hostname << "port is " << addr_sensor.sin_port << endl;
    }

    /*End TCP Server Init*/

    m_eth_exit.lock();                  /* we just init , you can use it in data prosess thread*/
    m_EthBexit = false;
    m_eth_exit.unlock();

    /* Comment the line above, and uncomment the line below to enable Ethernet */
    m_GetEthDataThread  = std::thread(&RTKDriver::ThreadGetDataEth, this);    

    signal(SIGINT, SigintHandler);
    ros::spin();
}


void RTKDriver::Stop()
{
    cout << "RTKDriver::Stop()" << endl;

    close(sock_Ser);        //close Eth server and client socket
    close(sock_Cli);

    m_eth_exit.lock();
    m_EthBexit = true;
    m_eth_exit.unlock();

    usleep(1000);
}

void RTKDriver::SigintHandler(int sig)
{
    // Capture Ctrl+C.
    ROS_INFO("shutting down!");
	ros::shutdown();
}

void RTKDriver::PublishGNSS(gnss_solution_t* p_gnss){
    sensor_msgs::NavSatFix gnss_msg;

    // Time stamp
    uint32_t secs = p_gnss->gps_week*SECONDS_IN_WEEK + (uint32_t)(p_gnss->gps_tow / 1000);
    uint32_t n_secs = (p_gnss->gps_tow - ((uint32_t)(p_gnss->gps_tow / 1000))*1000)*1e6;
    ros::Time stamp(secs, n_secs); // week to seconds, gps_tow to nanoseconds (for simplicity)

    gnss_msg.header.stamp = stamp;

    // Add coordinates
    gnss_msg.latitude = p_gnss->latitude*RAD2DEG;
    gnss_msg.longitude = p_gnss->longitude*RAD2DEG;
    gnss_msg.altitude = p_gnss->height;

    // Covariance
    gnss_msg.position_covariance_type = sensor_msgs::NavSatFix::COVARIANCE_TYPE_UNKNOWN;

    // Publish
    m_pub_gnss.publish(gnss_msg);
}


/******here we just use socket*****/
void RTKDriver::ThreadGetDataEth(void)
{ 
    uint8_t recvNum = 0;
    uint8_t  recvBuf[RECV_BUFFER_SIZE] = {0};

    gnss_solution_t gnss_data = {0};
    
    uint8_t* gnss_payloads[] = {(uint8_t*)&gnss_data.gps_week, (uint8_t*)&gnss_data.gps_tow,
                                            (uint8_t*)&gnss_data.latitude, (uint8_t*)&gnss_data.longitude, (uint8_t*)&gnss_data.height};
                                            //(uint8_t*)&gnss_data.std_lat, (uint8_t*)&gnss_data.std_lon, (uint8_t*)&gnss_data.std_hgt}; Don't think this is available
    uint8_t gnss_payload_sizes[] = {sizeof(gnss_data.gps_week), sizeof(gnss_data.gps_tow),
                                sizeof(gnss_data.latitude), sizeof(gnss_data.longitude), sizeof(gnss_data.height)};
                                //sizeof(gnss_data.std_lat), sizeof(gnss_data.std_lon), sizeof(gnss_data.std_hgt)}; Don't think this is available
    
    while(1)
    {
        memset(recvBuf, 0, sizeof(recvBuf));
    	recvNum = recvfrom(sock_Cli, recvBuf, sizeof(recvBuf), 0, (struct sockaddr*)&addr_sensor, &sockstrlen); 

        if(recvNum < 0)    
        {    
            cout << "recvfrom error:" <<endl;     
                continue; 
        }   

        if((recvBuf[0] == 0x68) && (recvBuf[1] == 0x65)){
            sendto(sock_Cli, Handbk, sizeof(Handbk), 0, (struct sockaddr*)&addr_sensor, sockstrlen);
            cout << "Hand Back" << endl;
        } 

        else if(strstr((const char*)recvBuf, GNSS_HEADER)){
            // Wiho we have GNSS data coming in :D
            cout << GNSS_HEADER << endl;

            uint16_t gnss_payload_head = sizeof(GNSS_HEADER);
            for (uint32_t i = 0; i < sizeof(gnss_payload_sizes); i++){
                memcpy(gnss_payloads[i], &recvBuf[gnss_payload_head], gnss_payload_sizes[i]);
                gnss_payload_head = gnss_payload_head + gnss_payload_sizes[i];
            }

            PublishGNSS(&gnss_data); 
        }

        else if(strstr((const char*)recvBuf, IMU_HEADER)){
            cout << IMU_HEADER << endl;
        }
		usleep(1000);
    }
}


/*******************************************************************************
* FUNCTION: calcCRC calculates a 2-byte CRC on serial data using 
*           CRC-CCITT 16-bit standard maintained by the ITU 
*           (International Telecommunications Union). 
* ARGUMENTS: ptr is pointer to queue holding area to be CRCed
*            num is offset into buffer where to stop CRC calculation
* RETURNS: 2-byte CRC
*******************************************************************************/
uint16_t RTKDriver::calcCRC(uint8_t *ptr, uint32_t num)
{
    uint16_t crc = 0x1D0F; //non-augmented initial value equivalent to augmented initial value 0xFFFF
    for (uint32_t i = 0; i < num; i++)
    {
        crc ^= ptr[i] << 8;
        for(uint32_t j = 0; j < 8; j++) 
        {
            if(crc & 0x8000)
            {
                crc = (crc << 1) ^ 0x1021;
            }
            else
            {
                crc = crc << 1;
            }
        } 
    }
    return crc;
}

string RTKDriver::Bytestohexstring(uint8_t* bytes,int bytelength)  
{  
  string str("");  
  string str2("0123456789ABCDEF");   
  for (int i = 0; i < bytelength; i++)
  {  
    int b = 0x0f & (bytes[i] >> 4);  
    str.append(1, str2.at(b));            
    b = 0x0f & bytes[i];  
    str.append(1, str2.at(b));  
    str += " ";
  }
  return str;  
}  