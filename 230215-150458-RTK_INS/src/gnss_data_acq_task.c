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
/** ***************************************************************************
 * @name _handleGpsMessages()
 * @brief Decode RTCM data and store it in g_gnss_raw_data
 * @param uint8_t *RtcmBuff:RTCM data flow
 *        int length:RTCM data lenth
 * @retval N/A
 ******************************************************************************/
static void _handleGpsMessages(uint8_t *RtcmBuff, int length)
{
    int pos = 0;
    gnss_rtcm_t *rtcm = &g_gnss_raw_data.rtcm;
    obs_t *obs = rtcm->obs + stnID;
    rtcm_t *rcv = rtcm->rcv + stnID;
    int8_t ret_val = 0;
    uint32_t crc = 0;

    while (length)
    {
        length--;
        ret_val = input_rtcm3(RtcmBuff[pos++], stnID, rtcm);
        /* relocated from rtcm.c */
        if (stnID == BASE && ret_val == 1) //Base station data reception completed
        {
            station_tcp_clear_stream_timeout();
            LED_RTCM_TOOGLE();
            base_cnt = 0;
        }

        if (rtcm_decode_completion == 1){
            if (stnID == ROVER) 
            {
                //printf("time: %lld, %lf\r\n", rtcm->rcv[ROVER].time.time, rtcm->rcv[ROVER].time.sec);
                // ntrip server push rtcm data
                if (get_station_mode() == MODE_NTRIP_SERVER && base_station_get_run_status() == 1) {
                    if (rtcm->rcv[ROVER].time.sec < 0.1)
                    {
                        if (rtcm->rcv[ROVER].type == 1077 || rtcm->rcv[ROVER].type == 1097 || rtcm->rcv[ROVER].type == 1117
                            || rtcm->rcv[ROVER].type == 1127 || rtcm->rcv[ROVER].type == 1087)
                        {
                            setbitu(rtcm->rcv[ROVER].buff, 36, 12, get_station_id());

                            crc = rtk_crc24q(rtcm->rcv[ROVER].buff, rtcm_decode_length - 3);
                            setbitu(rtcm->rcv[ROVER].buff, (rtcm_decode_length - 3) * 8, 24, crc);

                            station_tcp_send_data(rtcm->rcv[ROVER].buff, rtcm_decode_length);
                            // uart_write_bytes(UART_USER, (const char*)rtcm->rcv[ROVER].buff, rtcm_decode_length, 1);
                            station_tcp_clear_stream_timeout();

                            //printf("rtcm{%lld, %lf} %d\r\n", rtcm->rcv[ROVER].time.time, rtcm->rcv[ROVER].time.sec, rtcm->rcv[ROVER].type);
                        }
                    }
                }

                // else
                // {
                //     //printf("r %d\r\n", rtcm->rcv[ROVER].type);
                // }
            }
            rtcm_decode_completion = 0;
        }

        if (ret_val == 1)
        {
            if (g_pps_flag == 0)
            {
                g_MCU_time.time = obs->time.time;
                g_MCU_time.msec = (obs->time.sec * 1000);
            }

            if (obs->pos[0] == 0.0 || obs->pos[1] == 0.0 || obs->pos[2] == 0.0)
            {
                /* do not output */
            }
            else if (stnID == ROVER)
            {
                g_obs_rcv_time = g_MCU_time;
                static gtime_t timeCpy;
                if ((timeCpy.sec == obs->time.sec && timeCpy.time == obs->time.time) || obs->n < 4)
                {
                    gnss_signal_flag = 0;
                }
                else
                {
                    timeCpy = obs->time;
                    if (obs->n > 10)
                        gnss_signal_flag = 1;
                }
                uint8_t res = osSemaphoreWait(g_sem_rtk_finish, 0);
                if (res == osOK && gnss_signal_flag)
                {
                    g_ptr_gnss_data->rov = *obs;
                    g_ptr_gnss_data->ref = *(rtcm->obs + BASE);
                    g_ptr_gnss_data->nav = rtcm->nav;
                    osSemaphoreRelease(g_sem_rtk_start);
                }
            }
        }
    }
}


uint8_t frame_data[2048];
uint8_t gnss_msg_buffer[250];
static uint8_t crc_rev[2] = {0};
gnss_solution_t *gps_data_from_sta;
extern client_s driver_data_client;

// Define payload
uint8_t* gnss_payloads[] = {(uint8_t*)&g_gnss_sol.gps_week, (uint8_t*)&g_gnss_sol.gps_tow,
                        (uint8_t*)&g_gnss_sol.latitude, (uint8_t*)&g_gnss_sol.longitude, (uint8_t*)&g_gnss_sol.height};
                        //(uint8_t*)&g_gnss_sol.std_lat, (uint8_t*)&g_gnss_sol.std_lon, (uint8_t*)&g_gnss_sol.std_hgt};
uint8_t gnss_payload_sizes[] = {sizeof(g_gnss_sol.gps_week), sizeof(g_gnss_sol.gps_tow),
                            sizeof(g_gnss_sol.latitude), sizeof(g_gnss_sol.longitude), sizeof(g_gnss_sol.height)};
                            //sizeof(g_gnss_sol.std_lat), sizeof(g_gnss_sol.std_lon), sizeof(g_gnss_sol.std_hgt)};

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

                    if (g_gnss_sol.gnss_fix_type == 4 || g_gnss_sol.gnss_fix_type == 5 || g_gnss_sol.gnss_fix_type == 1)
                    {
                        gtime_t gt = gpst2time(g_gnss_sol.gps_week, g_gnss_sol.gps_tow * 0.001);


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
                        
                        if(input_gnss_time[2] - input_gnss_time[1] == 1000 && input_gnss_time[1]-input_gnss_time[0] == 1000)
                            g_MCU_time.time = gt.time;
                        
                    }

                    LED1_Toggle();

                    // -------------------------- HERE IF FILL THE BUFFER FOR ETHERNET TRANSMISSION OF GNSS DATA --------------------
                    // Header                   
                    char header[] = "$GNSS";
                    uint8_t header_size = sizeof(header);
                    memcpy(gnss_msg_buffer, header, header_size);


                    // Fill payload
                    uint8_t buffer_head = header_size;
                    for (int i = 0; i < sizeof(gnss_payload_sizes); i++){
                        memcpy(&gnss_msg_buffer[buffer_head], gnss_payloads[i], gnss_payload_sizes[i]);
                        buffer_head += gnss_payload_sizes[i];
                    }
                    uint8_t total_payload_size = buffer_head - header_size;

                    //int msg_length = sprintf(gnss_msg_buffer, "$GNSS, %f, %f, %u, %lu", g_gnss_sol.latitude, g_gnss_sol.longitude, g_gnss_sol.gps_week, g_gnss_sol.gps_tow);
                    //uint16_t crc = CalculateCRC(&gnss_msg_buffer[header_size], payload_size);
                    //gnss_msg_buffer[header_size + payload_size] = (crc >> 8);
                    //gnss_msg_buffer[header_size + payload_size + 1] = crc;

                    if (driver_data_client.client_state == CLIENT_STATE_INTERACTIVE && g_gnss_sol.gnss_fix_type == 1){
                        client_write_data(&driver_data_client, (const uint8_t*)gnss_msg_buffer, header_size + total_payload_size, 0x01);
                    }
                    //*/

                    if (g_gnss_sol.gnss_fix_type != 0)
                    {
                        g_status.status_bit.gnss_signal_status = 1;
                    }
                    else
                    {
                        g_status.status_bit.gnss_signal_status = 0;
                    }   
                } else {
                    // printf("err %d %lf %lf %lf\r\n", gps_data_from_sta->gps_week, gps_data_from_sta->latitude * RAD_TO_DEG, gps_data_from_sta->longitude * RAD_TO_DEG, gps_data_from_sta->height);
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
        GpsRxLen = uart_read_bytes(UART_GPS, Gpsbuf, GPS_BUFF_SIZE, 0);         

        static uint8_t no_rx = 0;
        if (GpsRxLen)
        {
            parse_gnss_data(Gpsbuf, GpsRxLen);
            no_rx = 0;
        }
        else
        {
            no_rx++;
        }

        if (no_rx >= 250)
        {
            g_status.status_bit.gnss_data_status = 0;
            g_status.status_bit.gnss_signal_status = 0;
            no_rx = 250;
        }
        else
        {
            g_status.status_bit.gnss_data_status = 1;
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

