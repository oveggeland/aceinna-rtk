/** ***************************************************************************
 * @file gnss_data_acq_task.c handle GPS data, make sure the GPS handling function gets
 *  called on a regular basis
 *
 * THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY
 * KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A
 * PARTICULAR PURPOSE.
 *****************************************************************************/
/*******************************************************************************
Copyright 2020 ACEINNA, INC

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
************************************************************************/
#include <string.h>

#include "gnss_data_api.h"
#include "uart.h"
#include "bt_packet.h"
#include "led.h"
#include "crc16.h"
#include "app_version.h"
#include "stdlib.h"
#include "ntrip_server.h"
#include "aceinna_client_api.h"
#include "station_tcp.h"
#include "tcp_driver.h"
#include "ins_interface_API.h"
#define CCMRAM __attribute__((section(".ccmram")))

// PTP STUFF OSKAR:
bool ptp_clk_init = false;
extern void ptp_update_clk(int64_t gps_count, int64_t ptp_count);
extern void ptp_set_clk(uint32_t secs, uint32_t nsecs);

extern volatile mcu_time_base_t g_MCU_time;
static uint16_t GpsRxLen;

extern uint8_t g_pps_flag;
extern uint8_t debug_com_log_on;

CCMRAM gnss_raw_data_t g_gnss_raw_data = {0};
gnss_raw_data_t *g_ptr_gnss_data = &g_gnss_raw_data;
uint8_t gnss_signal_flag = 0;   //1:Satellite signal availability

uint8_t stnID = 0;
volatile mcu_time_base_t g_obs_rcv_time;

char gga_buff[120] = {0};
char gsa_buff[500]  = "GSA\r\n";
char rmc_buff[200]  = "RMC\r\n";
char zda_buff[50] = "ZDA\r\n";
char nema_update_flag = 0;

fifo_type fifo_user_uart;
uint8_t fifo_user_uart_buf[2000];
uint8_t gnss_result_cnt = 0;
static uint8_t base_cnt = 0; 

gnss_solution_t g_gnss_sol = {0};
gnss_solution_t *g_ptr_gnss_sol = &g_gnss_sol;
// char gsv_buff[1000] = "GSV\r\n";

uint8_t frame_data[2048];
uint8_t gnss_msg_buffer[1000];
uint16_t gnss_msg_buffer_head = 0;
static uint8_t crc_rev[2] = {0};
gnss_solution_t *gps_data_from_sta;
extern client_s driver_data_client;

extern ETH_HandleTypeDef EthHandle;  
uint32_t ptp_sec = 0;
uint32_t ptp_nsec = 0;
uint32_t ptp_count = 0;
uint32_t gps_sec = 0;
uint32_t gps_nsec = 0;
uint32_t gps_count = 0;

uint32_t new_ptp_sec = 0;
uint32_t new_ptp_nsec = 0;

const static double gpst0[] = { 1980, 1, 6, 0, 0, 0 }; /* gps time reference */


static int input_gnss_data(unsigned char data)
{
    static uint8_t frame_rev_flag = 0;
    static uint16_t frame_data_len = 0;

    static uint16_t data_rev_index = 0;

    static uint16_t crc_rev_index = 0;
    static uint64_t input_gnss_time[3];
    static uint8_t time_cnt = 0;
    if (frame_rev_flag == 0)
    {
        if (data == 's')
        {
            frame_rev_flag = 1;
            frame_data_len = 0;
            data_rev_index = 0;
            crc_rev_index = 0;
            return 0;
        }
    }
    switch (frame_rev_flag)
    {
    case 1:
        if (data == 't')
        {
            frame_rev_flag = 2;
        }
        else
        {
            frame_rev_flag = 0;
        }
        break;
    case 2:
        if (data == 'a')
        {
            frame_rev_flag = 3;
        }
        else
        {
            frame_rev_flag = 0;
        }
        break;
    case 3:
        frame_data_len = data;
        frame_rev_flag = 4;
        break;
    case 4:
        frame_data_len = ((uint16_t)data << 8) + frame_data_len;
        if(frame_data_len > 1200)
        {
            frame_rev_flag = 0;
            frame_data_len = 0;
            data_rev_index = 0;
            crc_rev[0] = 0;
            crc_rev[1] = 0;
            crc_rev_index = 0;
        }
        else
        {
            frame_rev_flag = 5;
        }
        break;
    case 5:
        frame_data[data_rev_index++] = data;
        if (data_rev_index == frame_data_len - 5 - 2)
        {
            frame_rev_flag = 6;
        }
        break;
    case 6:
        crc_rev[crc_rev_index++] = data;
        if (crc_rev_index == 2)
        {
            uint16_t crc_check = CalculateCRC(frame_data, frame_data_len - 5 - 2);
            //printf("crc_ check = %x,crc_rev[0] = %x,crc_rev[1] = %x\r\n",crc_check,crc_rev[0],crc_rev[1]);
            gps_data_from_sta = (gnss_solution_t *)(frame_data);
            if (crc_check == ((crc_rev[1] << 8) | crc_rev[0]))
            {

                if (gps_data_from_sta->gps_week > 0 && gps_data_from_sta->height >= -1000 &&
                    gps_data_from_sta->latitude * RAD_TO_DEG >= -90.0 && gps_data_from_sta->latitude * RAD_TO_DEG <= 90.0 &&
                    gps_data_from_sta->longitude * RAD_TO_DEG >= -180.0 && gps_data_from_sta->longitude * RAD_TO_DEG <= 180.0) {
                    g_gnss_sol = *gps_data_from_sta;

                    copy_gnss_result(&g_gnss_sol);

                    gtime_t gt = gpst2time(g_gnss_sol.gps_week, g_gnss_sol.gps_tow * 0.001);

                    if (g_gnss_sol.gnss_fix_type == 4 || g_gnss_sol.gnss_fix_type == 5 || g_gnss_sol.gnss_fix_type == 1)
                    {
                        if (time_cnt >=3)
                        {
                            input_gnss_time[0] = input_gnss_time[1];
                            input_gnss_time[1] = input_gnss_time[2];
                            input_gnss_time[2] = g_gnss_sol.gps_tow;
                        }
                        else
                        {
                            input_gnss_time[time_cnt] = g_gnss_sol.gps_tow;
                            time_cnt ++;
                        }
                        
                        if(input_gnss_time[2] - input_gnss_time[1] == 1000 && input_gnss_time[1]-input_gnss_time[0] == 1000){
                            g_MCU_time.time = gt.time;
                            g_MCU_time.msec = 1000 / gt.sec;                        
                        }
                    }

                    LED1_Toggle();

                    // -------------------------- HERE I FILL THE BUFFER FOR ETHERNET TRANSMISSION OF GNSS DATA --------------------
                    // Header                   
                    char header[] = "$GNSS";
                    uint8_t header_size = sizeof(header);
                    memcpy(gnss_msg_buffer, header, header_size);

                    // Payload
                    gnss_msg_buffer_head = header_size;
                    
                    memcpy(&gnss_msg_buffer[gnss_msg_buffer_head], &new_ptp_sec, sizeof(new_ptp_sec));
                    gnss_msg_buffer_head = gnss_msg_buffer_head + sizeof(new_ptp_sec);

                    memcpy(&gnss_msg_buffer[gnss_msg_buffer_head], &new_ptp_nsec, sizeof(new_ptp_nsec));
                    gnss_msg_buffer_head = gnss_msg_buffer_head + sizeof(new_ptp_nsec);

                    memcpy(&gnss_msg_buffer[gnss_msg_buffer_head], &g_gnss_sol.latitude, sizeof(g_gnss_sol.latitude));
                    gnss_msg_buffer_head = gnss_msg_buffer_head + sizeof(g_gnss_sol.latitude);

                    memcpy(&gnss_msg_buffer[gnss_msg_buffer_head], &g_gnss_sol.longitude, sizeof(g_gnss_sol.longitude));
                    gnss_msg_buffer_head = gnss_msg_buffer_head + sizeof(g_gnss_sol.longitude);

                    memcpy(&gnss_msg_buffer[gnss_msg_buffer_head], &g_gnss_sol.height, sizeof(g_gnss_sol.height));
                    gnss_msg_buffer_head = gnss_msg_buffer_head + sizeof(g_gnss_sol.height);
                    

                    // Send packet
                    if(driver_data_client.client_state == CLIENT_STATE_INTERACTIVE)
                    {
                        fifo_push(&driver_data_client.client_tx_fifo, gnss_msg_buffer, gnss_msg_buffer_head);
                    }

                    // Update timer!
                    if (EthHandle.Instance->PTPTSLR | EthHandle.Instance->PTPTSHR){
                        int64_t new_gps_sec = epoch2time(gpst0).time + SECONDS_IN_WEEK * g_gnss_sol.gps_week + (int) 1e-3*g_gnss_sol.gps_tow;
                        int64_t new_gps_nsec = 1e6*(g_gnss_sol.gps_tow - 1000*((int) 1e-3*g_gnss_sol.gps_tow));
                        
                        if (!ptp_clk_init){
                            ptp_set_clk(new_gps_sec, new_gps_nsec);
                            ptp_clk_init = true;

                            new_ptp_sec = EthHandle.Instance->PTPTSHR;
                            new_ptp_nsec = EthHandle.Instance->PTPTSLR;
                        }
                        else{
                            gps_count = 1e9*(new_gps_sec - gps_sec) + new_gps_nsec - gps_nsec;
                            ptp_count = 1e9*(new_ptp_sec - ptp_sec) + new_ptp_nsec - ptp_nsec;
                            ptp_update_clk(gps_count, ptp_count);
                        }

                        gps_sec = new_gps_sec;
                        gps_nsec = new_gps_nsec;

                        ptp_sec = new_ptp_sec;
                        ptp_nsec = new_ptp_nsec;
                    }
                }
            }

            frame_rev_flag = 0;
            frame_data_len = 0;
            data_rev_index = 0;
            crc_rev[0] = 0;
            crc_rev[1] = 0;
            crc_rev_index = 0;
        }
        break;
    }
    return 1;
}



static void parse_gnss_data(uint8_t *RtcmBuff, int length)
{
    int pos = 0;
    while (length)
    {
        length--;
        int ret = input_gnss_data(RtcmBuff[pos++]);
    }
}

/** ***************************************************************************
 * @name GnssDataAcqTask()
 * @brief  Satellite data acquisition task,include base and rover
 *         Get the base data from UART_GPS,and get the base data from UART_BT or
 *         ntrip_rx_fifo.
 * @param  N/A
 * @retval N/A
 ******************************************************************************/
uint8_t Gpsbuf[GPS_BUFF_SIZE];
uint8_t bt_buff[GPS_BUFF_SIZE];
extern uint32_t debug_p1_log_delay;
void GnssDataAcqTask(void const *argument)
{
    int ret = 0;
    memset(g_ptr_gnss_data, 0, sizeof(gnss_raw_data_t));

    while (1)
    {
        update_fifo_in(UART_GPS);
        GpsRxLen = uart_read_bytes(UART_GPS, Gpsbuf, GPS_BUFF_SIZE, 1000);         

        new_ptp_sec = EthHandle.Instance->PTPTSHR;
        new_ptp_nsec = EthHandle.Instance->PTPTSLR;

        static uint8_t no_rx = 0;
        if (GpsRxLen)
        {
            parse_gnss_data(Gpsbuf, GpsRxLen);
            no_rx = 0;
        }

        OS_Delay(10);
    }
}

/** ***************************************************************************
 * @name get_obs_time()
 * @brief  Acquisition of satellite time
 * @param  N/A
 * @retval N/A
 ******************************************************************************/
time_t get_obs_time()
{
    return g_ptr_gnss_data->rtcm.obs[0].time.time;
}

/** ***************************************************************************
 * @name get_gnss_signal_flag()
 * @brief  obtain get_gnss_signal_flag
 * @param  N/A
 * @retval N/A
 ******************************************************************************/
uint8_t get_gnss_signal_flag()
{
    return gnss_signal_flag;
}

