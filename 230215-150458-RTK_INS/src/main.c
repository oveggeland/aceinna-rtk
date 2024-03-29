
/** ***************************************************************************
 * @file   main.c
 *
 * THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY
 * KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A
 * PARTICULAR PURPOSE.
 *
 *  main is the center of the system universe, it all starts here. And never ends.
 * entry point for system (pins, clocks, interrupts), data and task initialization.
 * contains the main processing loop. - this is a standard implementation
 * which has mainly os functionality in the main loop
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

#define __MAIN
#include "main.h"
#include "configureGPIO.h"
#include "bsp.h"
#include "uart.h"
#include "FreeRTOS.h"
#include "FreeRTOSConfig.h"
#include "calibrationAPI.h"
#include "configurationAPI.h"
#include "user_config.h"
#include "timer.h"
#include "lwipopts.h"
#include "spi.h"
#include "led.h"

osThreadId IMU_DATA_ACQ_TASK;
osThreadId GNSS_DATA_ACQ_TASK;
osThreadId ETHERNET_TASK;
osThreadId PTP_TASK;
osThreadId TEMP_TASK;

osSemaphoreDef(IMU_DATA_ACQ_SEM);
osSemaphoreDef(PTP_SEM);
osSemaphoreDef(TEMP_SEM);


osSemaphoreId g_sem_imu_data_acq;
osSemaphoreId g_sem_ptp;
osSemaphoreId g_sem_temp;

/**
 * Function to enable easier debugging using LEDs to indicate code flow
*/
void debug_led(int led_number){
  while (1){
      switch (led_number)
      {
      case 1:
          LED1_Toggle();
          break;
      case 2:
          LED2_Toggle();
          break;
      case 3:
          LED3_Toggle();
          break;
      
      default:
          break;
      }
      OS_Delay(100);
  }
}


/** ***************************************************************************
 * @name CreateTasks()
 * @brief CreateTasks
 * @param N/A
 * @retval N/A
 * 
 * 
 ******************************************************************************/
void CreateTasks(void)
{
    osThreadId iD;

    g_sem_imu_data_acq = osSemaphoreCreate(osSemaphore(IMU_DATA_ACQ_SEM), 1);
    g_sem_ptp = osSemaphoreCreate(osSemaphore(PTP_SEM), 1);
    g_sem_temp = osSemaphoreCreate(osSemaphore(TEMP_SEM), 1);


    osThreadDef(IMU_DATA_ACQ_TASK, TaskDataAcquisition, osPriorityNormal, 0, TASK_IMU_DATA_ACQ_STACK);
    iD = osThreadCreate(osThread(IMU_DATA_ACQ_TASK), NULL);
    if (iD == NULL)
    {
        while (1){
            debug_led(1);
        };
    }

    osThreadDef(GNSS_DATA_ACQ_TASK, GnssDataAcqTask, osPriorityNormal, 0, TASK_GNSS_DATA_ACQ_STACK);
    iD = osThreadCreate(osThread(GNSS_DATA_ACQ_TASK), NULL);
    if (iD == NULL)
    {
        while (1){
            debug_led(1);
        };
    }

    osThreadDef(ETHERNET_TASK, EthTask, osPriorityNormal, 0, TASK_USERTCP_STACK);
    iD = osThreadCreate(osThread(ETHERNET_TASK), NULL);
    if (iD == NULL)
    {
        while (1){
            debug_led(1);
        };
    }

    osThreadDef(TEMP_TASK, TempTask, osPriorityNormal, 0, 1024);
    iD = osThreadCreate(osThread(TEMP_TASK), NULL);
    if (iD == NULL)
    {
        while (1){
            debug_led(1);
        };
    }
    
    osThreadDef(PTP_TASK, PtpTask, osPriorityNormal, 0, TASK_USERTCP_STACK);
    iD = osThreadCreate(osThread(PTP_TASK), NULL);
    if (iD == NULL)
    {
        while (1){
            debug_led(1);
        };
    }
}


/** ***************************************************************************
 * @name main()
 * @brief mian
 * @param N/A
 * @retval N/A
 ******************************************************************************/
int main(void)
{
    // Initialize processor and board-related signals  
    BoardInit();
    MX_DMA_Init();

    uart_driver_install(UART_GPS,&uart_gps_rx_fifo,&huart_gps,460800);
    fifo_init(&fifo_user_uart, fifo_user_uart_buf, GPS_BUFF_SIZE);

    ResetForEnterBootMode();  // normal or iap mode

    InitFactoryCalibration();
    ApplyFactoryConfiguration();
    userInitConfigureUnit(true);


    CreateTasks();
    MX_TIM_SENSOR_Init();

    /* Infinite loop */
    while ( 1 ) {

        osKernelStart();

        // We should never get here as control is now taken by the scheduler
        for (;;)
            ;
    }
}



/**
  * @brief  This function is executed in case of error occurrence.
  * @param  file: The file name as string.
  * @param  line: The line in file as a number.
  * @retval None
  */
void _Error_Handler(char *file, int line)
{
    /* USER CODE BEGIN Error_Handler_Debug */
    /* User can add his own implementation to report the HAL error return state */
    while(1)
    {
    }
    /* USER CODE END Error_Handler_Debug */
}

void  vApplicationStackOverflowHook( TaskHandle_t xTask, char *pcTaskName )
{
    while(1);
}

void  vApplicationMallocFailedHook( void )
{
    while(1);
}


