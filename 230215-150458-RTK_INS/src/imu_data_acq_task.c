/*****************************************************************************
 * @file   imu_data_acq_task.c
 *
 * THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY
 * KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A
 * PARTICULAR PURPOSE.
 *
 * sensor data acquisition task runs at 100Hz, gets the data for each sensor
 * and applies available calibration
 ******************************************************************************/
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
*******************************************************************************/
#include <string.h>

#include "sensorsAPI.h"
#include "calibrationAPI.h"
#include "configurationAPI.h"
#include "commAPI.h"
#include "uart.h"
#include "bsp.h"
#include "timer.h"
#include "user_message.h"
#include "car_data.h"
#include "gnss_data_api.h"
#include "ins_interface_API.h"
#include "tcp_driver.h"
#include "led.h"
#include "platformAPI.h"


typedef struct {
    uint64_t stamp;   // Milliseconds standard time (from 01.01.1970)

    double acc_mps2[3];  
    float rate_rps[3];
} imu_payload_t;

imu_payload_t g_imu_payload;

// Globals for sending data
uint8_t imu_msg_buffer[500] = {0};
extern client_s driver_data_client;


// Helper function for data transmission of IMU data
static void send_imu_data()
{
    // Packet header
    char header[] = "$IMU";
    uint8_t header_size = sizeof(header);
    memcpy(imu_msg_buffer, header, header_size);

    // Fill payload into buffer
    uint8_t buffer_head = header_size;
    
    memcpy(&imu_msg_buffer[buffer_head], &g_imu_payload.stamp, sizeof(g_imu_payload.stamp));
    buffer_head = buffer_head + sizeof(g_imu_payload.stamp);

    memcpy(&imu_msg_buffer[buffer_head], g_imu_payload.acc_mps2, sizeof(g_imu_payload.acc_mps2));
    buffer_head = buffer_head + sizeof(g_imu_payload.acc_mps2);

    memcpy(&imu_msg_buffer[buffer_head], g_imu_payload.rate_rps, sizeof(g_imu_payload.rate_rps));
    buffer_head = buffer_head + sizeof(g_imu_payload.rate_rps);
    
    uint8_t total_payload_size = buffer_head - header_size;


    // Send packet
    if(driver_data_client.client_state == CLIENT_STATE_INTERACTIVE)
    {
        fifo_push(&driver_data_client.client_tx_fifo, imu_msg_buffer, header_size+total_payload_size);
        // client_write_data(&driver_data_client, (const uint8_t*)imu_msg_buffer, header_size+total_payload_size, 0x01);
    }
}


/** ***************************************************************************
 * @name TaskDataAcquisition()
 * @brief Get the sensor data at the specified frequency (based on the
 *        configuration of the accelerometer rate-sensor). Process and provide
 *        information to the user via the UART.
 * @param N/A
 * @retval N/A
 ******************************************************************************/
void TaskDataAcquisition(void const *argument)
{
    int res;

    res = InitSensors();
    InitSensorsData();
    memset(&g_status,0,sizeof(status_t));
    g_status.status_bit.power = 1;
    g_status.status_bit.MCU_status = 1;

    while (1) {

        res = osSemaphoreWait(g_sem_imu_data_acq, 1000);
        if (res != osOK)
        {
            // Wait timeout expired. Something wrong wit the data acq system
            // Process timeout here
        }

        DRDY_OFF();  // No signal please
        
        // Sample data
        SampleSensorsData();
        g_imu_payload.stamp = get_time_of_msec();

        ApplyFactoryCalibration();

        GetAccelData_mPerSecSq(g_imu_payload.acc_mps2);
        GetRateData_radPerSec(g_imu_payload.rate_rps);

        // Send data
        send_imu_data();

        // Notify IMU message
        LED2_Toggle();
    }
}