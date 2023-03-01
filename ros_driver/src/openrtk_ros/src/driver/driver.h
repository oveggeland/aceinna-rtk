/*******************************************************
 * @file driver.h
 * @author khshen (khshen@aceinna.com)
 * @brief 
 * @date 2021-06-10
 * 
 * @copyright Copyright (c) 2021
 * 
*******************************************************/

#pragma once
#include <iostream>
using namespace std;
#include <queue>
#include <mutex>
#include <thread>
#include <signal.h>
#include <ros/ros.h>
#include <sensor_msgs/Imu.h>
#include <sensor_msgs/NavSatFix.h>
#include <tf/transform_broadcaster.h>
#include "serial/serial.h"
#include "rtk.h"
#include "macro.h"
#include "protocol.h"
#include <sys/socket.h>     
#include <netinet/in.h>     
#include <arpa/inet.h>  

// For defining gnss messages
typedef struct  {
    uint16_t gps_week;
    uint32_t gps_tow; // gps Time Of Week, miliseconds
    uint8_t num_sats; // num of satellites in the solution 

    double latitude; // latitude ,  degrees 
    double longitude; // longitude,  degrees 
    double height; // above mean sea level [m]
    double pos_ecef[3];
    float vel_ned[3]; // velocities,  m/s  NED (North East Down) x, y, z
    float heading; // [deg]

    float dops[5];
    float sol_age;

	float std_lat;	//!< latitude standard deviation (m)
	float std_lon;	//!< longitude standard deviation (m)
	float std_hgt;	//!< height standard deviation (m)
    float std_vn;
    float std_ve;
    float std_vd;

    uint8_t rov_n;
} gnss_solution_t;


class RTKDriver
{
public:
    RTKDriver(ros::NodeHandle nh);
    virtual ~RTKDriver();

    void Start();
    void Stop();
    bool Spin();

    void PublishGNSS(gnss_solution_t* p_gnss);

    static void SigintHandler(int sig);
    void ThreadGetDataEth(void);

    uint16_t calcCRC(uint8_t *ptr, uint32_t num);
    string Bytestohexstring(uint8_t* bytes,int bytelength);

private:
    ros::NodeHandle m_nh;
    ros::Publisher m_pub_imu;
    ros::Publisher m_pub_gnss;

    /*******Eth Port******/
    struct sockaddr_in addr_sensor;  
    struct sockaddr_in addr_server; 
    uint32_t sockstrlen;
    int32_t sock_Cli; 
    int32_t sock_Ser; 
    /*******Eth Port******/

    bool m_EthBexit;
    std::mutex m_eth_exit;
    std::thread m_GetEthDataThread;
};

