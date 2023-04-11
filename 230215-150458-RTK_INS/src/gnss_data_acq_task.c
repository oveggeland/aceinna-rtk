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

#include "uart.h"
#include "led.h"
#include "crc16.h"
#include "tcp_driver.h"

// PTP STUFF OSKAR:
bool ptp_clk_init = false;
extern void ptp_update_clk(int64_t gps_count, int64_t ptp_count);
extern void ptp_set_clk(uint32_t secs, uint32_t nsecs);

extern ETH_HandleTypeDef EthHandle;  
int64_t ptp_sec = 0;
int64_t ptp_nsec = 0;
int64_t ptp_count = 0;
int64_t gps_sec = 0;
int64_t gps_nsec = 0;
int64_t gps_count = 0;

uint32_t new_ptp_sec = 0;
uint32_t new_ptp_nsec = 0;

// Data globals
gnss_solution_t g_gnss_sol = {0};

uint8_t frame_data[2048];
static uint8_t crc_rev[2] = {0};

// Ethernet stuff
uint8_t gnss_msg_buffer[1000];
uint16_t gnss_msg_buffer_head = 0;
extern client_s driver_data_client;

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

            g_gnss_sol = *(gnss_solution_t *)(frame_data);
            if (crc_check == ((crc_rev[1] << 8) | crc_rev[0]))
            {

                if (g_gnss_sol.gps_week > 0 && g_gnss_sol.height >= -1000 &&
                    g_gnss_sol.latitude * RAD_TO_DEG >= -90.0 && g_gnss_sol.latitude * RAD_TO_DEG <= 90.0 &&
                    g_gnss_sol.longitude * RAD_TO_DEG >= -180.0 && g_gnss_sol.longitude * RAD_TO_DEG <= 180.0) {

                    // Wiho valid GNSS data!
                    LED1_Toggle();

                    // Update timer!
                    if (EthHandle.Instance->PTPTSLR | EthHandle.Instance->PTPTSHR){
                        int64_t new_gps_sec = UTC_OFFSET + UTC_LEAP_SECONDS + SECONDS_IN_WEEK * g_gnss_sol.gps_week + (int) 1e-3*g_gnss_sol.gps_tow;
                        int64_t new_gps_nsec = 1e6*(g_gnss_sol.gps_tow - 1000*((int) 1e-3*g_gnss_sol.gps_tow));
                        
                        if (!ptp_clk_init){
                            ptp_set_clk(new_gps_sec, new_gps_nsec);
                            ptp_clk_init = true;

                            new_ptp_sec = EthHandle.Instance->PTPTSHR;
                            new_ptp_nsec = EthHandle.Instance->PTPTSLR;
                        }
                        else{
                            gps_count = 1e9*(new_gps_sec - gps_sec) + new_gps_nsec - gps_nsec;
                            ptp_count = 1e9*((int64_t) new_ptp_sec - ptp_sec) + (int64_t) new_ptp_nsec - ptp_nsec;
                            ptp_update_clk(gps_count, ptp_count);
                        }

                        gps_sec = new_gps_sec;
                        gps_nsec = new_gps_nsec;

                        ptp_sec = (int64_t) new_ptp_sec;
                        ptp_nsec = (int64_t) new_ptp_nsec;
                    }

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
    while (length--)
    {
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

void GnssDataAcqTask(void const *argument)
{
    while (1)
    {
        update_fifo_in(UART_GPS);
        uint16_t GpsRxLen = uart_read_bytes(UART_GPS, Gpsbuf, GPS_BUFF_SIZE, osWaitForever);         

        new_ptp_sec = EthHandle.Instance->PTPTSHR;
        new_ptp_nsec = EthHandle.Instance->PTPTSLR;

        if (GpsRxLen)
        {
            parse_gnss_data(Gpsbuf, GpsRxLen);
        }

        OS_Delay(10);
    }
}