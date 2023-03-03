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

typedef struct  {
    uint64_t stamp;  // Milliseconds standard time (from 01.01.1970)

    double latitude; // latitude ,  degrees 
    double longitude; // longitude,  degrees 
    double height; // above mean sea level [m]
} gnss_payload_t;


typedef struct {
    uint64_t stamp;   // Milliseconds standard time (from 01.01.1970)

    double acc_mps2[3];  
    float rate_rps[3];
} imu_payload_t;


class RTKDriver
{
public:
    RTKDriver(ros::NodeHandle nh);
    virtual ~RTKDriver();

    void Start();
    void Stop();
    bool Spin();

    void PublishGNSS();
    void PublishIMU();

    static void SigintHandler(int sig);
    void ThreadGetDataEth(void);

    uint16_t calcCRC(uint8_t *ptr, uint32_t num);
    string Bytestohexstring(uint8_t* bytes,int bytelength);

private:
    ros::NodeHandle m_nh;
    ros::Publisher m_pub_imu;
    ros::Publisher m_pub_gnss;

    sensor_msgs::Imu m_imu_msg;
    sensor_msgs::NavSatFix m_gnss_msg;

    imu_payload_t m_imu_payload;
    gnss_payload_t m_gnss_payload;

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

