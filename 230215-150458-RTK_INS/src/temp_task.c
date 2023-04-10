/*
Temperature regulator for sensor platform
*/
#include "sensorsAPI.h"
#include "tcp_driver.h"

extern client_s driver_data_client;


void temp_gpio_init(){
    GPIO_InitTypeDef GPIO_InitStruct = {0};

    GPIO_InitStruct.Pin = USER_SPI_MOSI_PIN;
    GPIO_InitStruct.Mode = GPIO_MODE_AF_PP;
    GPIO_InitStruct.Pull = GPIO_NOPULL;
    GPIO_InitStruct.Speed = GPIO_SPEED_FREQ_VERY_HIGH;
    HAL_GPIO_Init(USER_SPI_NSS_PORT, &GPIO_InitStruct);
}

/** ***************************************************************************
 * @name TempTask()
 * @brief Regulating the internal temperature of sensor platform to avoid freezing components and lense moisture on camera
 * @param N/A
 * @retval N/A
 ******************************************************************************/
void TempTask(void const *argument)
{
    temp_gpio_init();

    double board_temp;
    uint8_t temp_data_buf[100] = {0};

    while (true){
        // Infinite regulation loop. Once a second, check board temp and adjust heating
        osSemaphoreWait(g_sem_temp, osWaitForever); // Loop at 1Hz

        // Simple temp regulator
        GetBoardTempData_AsDouble(&board_temp);
        if (board_temp < 25){
            // Activate temp regulator
            // Use LED pins for activation?
        }


        // Send temp over ethernet
        int data_len = sprintf((char*)temp_data_buf,"$TEMP%.2f", board_temp);

        if(driver_data_client.client_state == CLIENT_STATE_INTERACTIVE){
            fifo_push(&driver_data_client.client_tx_fifo, temp_data_buf, data_len);
        }
    }
};