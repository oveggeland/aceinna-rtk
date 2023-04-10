/*
Temperature regulator for sensor platform
*/
#include <string.h>

#include "sensorsAPI.h"
#include "tcp_driver.h"
#include "ethernetif.h"

extern client_s driver_data_client;

typedef struct {
    uint32_t secs;
    uint32_t nsecs;

    double temperature;
} temp_payload_t;


/** ***************************************************************************
 * @name TempTask()
 * @brief Regulating the internal temperature of sensor platform to avoid freezing components and lense moisture on camera
 * @param N/A
 * @retval N/A
 ******************************************************************************/
void TempTask(void const *argument)
{
    temp_payload_t temp_payload;
    uint8_t temp_data_buf[50] = {0};

    // Init buffer
    char header[] = "$TEMP";
    uint8_t header_size = sizeof(header);
    memcpy(temp_data_buf, header, header_size);

    while (true){
        // Infinite regulation loop. Once a second, check board temp and adjust heating
        osSemaphoreWait(g_sem_temp, osWaitForever); // Loop at 1Hz

        temp_payload.secs = EthHandle.Instance->PTPTSHR;
        temp_payload.nsecs = EthHandle.Instance->PTPTSLR;

        // Simple temp regulator
        GetBoardTempData_AsDouble(&temp_payload.temperature);
        if (temp_payload.temperature < 25){
            // Activate temp regulator
            // Use LED pins for activation?
        }

        // Send temp data over ethernet
        uint8_t buffer_head = header_size;

        memcpy(&temp_data_buf[buffer_head], &temp_payload.secs, sizeof(temp_payload.secs));
        buffer_head = buffer_head + sizeof(temp_payload.secs);

        memcpy(&temp_data_buf[buffer_head], &temp_payload.nsecs, sizeof(temp_payload.nsecs));
        buffer_head = buffer_head + sizeof(temp_payload.nsecs);

        memcpy(&temp_data_buf[buffer_head], &temp_payload.temperature, sizeof(temp_payload.temperature));
        buffer_head = buffer_head + sizeof(temp_payload.temperature);

        if(driver_data_client.client_state == CLIENT_STATE_INTERACTIVE){
            fifo_push(&driver_data_client.client_tx_fifo, temp_data_buf, buffer_head);
        }
    }
};