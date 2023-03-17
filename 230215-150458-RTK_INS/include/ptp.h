#ifndef PTP_H
#define PTP_H

#include <string.h>

#include "cmsis_os.h"
#include "osapi.h"
#include "FreeRTOS.h"
#include "aceinna_client_api.h"
#include "tcp_driver.h"
#include "calibrationAPI.h"

#include "lwip/opt.h"
#include "lwip/udp.h"
#include "lwip/netif.h"
#include "lwip/ip_addr.h"
#include "lwip/igmp.h"

#include "lwip/opt.h"
#include "lwip/dhcp.h"
#include "lwip/netif.h"
#include "lwip/tcpip.h"
#include "lwip/sockets.h"

#include "stm32f4xx_hal.h"
#include "led.h"
#include "calibrationAPI.h"
#include "tcp_driver.h"
#include "main.h"
#include "timer.h"

ip_addr_t ptp_ip;

struct udp_pcb *pcb_event;
struct udp_pcb *pcb_general;


enum ptp_type{
    PTP_SYNC = 0,
    PTP_FOLLOWUP = 1,
    PTP_DELAYRESP = 2,
    PTP_DELAYREQ = 3,
    PTP_ANNOUNCE = 4,
};

struct ptp_header
{
  uint8_t message_type;
  uint8_t version_ptp;
  uint8_t msg_length[2];
  uint8_t domain_number; 
  uint8_t reserved1;
  uint8_t flags[2];
  uint8_t correction_field[8];
  uint8_t reserved2[4];
  uint8_t clock_id[8];
  uint8_t source_port_id[2];
  uint8_t seq_id[2];
  uint8_t control_field;
  uint8_t log_message_interval;
};

struct ptp_sync
{
    struct ptp_header header;
    uint8_t timestamp[10];
};

time_t g_origin_stamp = 0;
struct ptp_followup
{
    struct ptp_header header;
    uint8_t timestamp[10];
};

struct ptp_delayreq
{
    struct ptp_header header;
    uint8_t timestamp[10];
};

struct ptp_delayresp
{
    struct ptp_header header;
    uint8_t timestamp[10];
    uint8_t req_port_id[10];
};

struct ptp_announce
{
    struct ptp_header header;
    uint8_t timestamp[10];
    uint8_t utc_offset[2];
    uint8_t reserved;
    uint8_t gmPriority1;
    uint8_t gmClockClass;
    uint8_t gmClockAcc;
    uint8_t gmClockVar[2];
    uint8_t gmPriority2;
    uint8_t gmId[8];
    uint8_t stepsRemoved[2];
    uint8_t timeSource;
};

/* Using reversed endian, copy 'size' bytes from 'src' to 'dest'*/
void memcpy_reverse_endian(uint8_t* dest, uint8_t* src, size_t size){
    for (int i = 0; i < size; i++){
        dest[i] = src[size - 1 - i];
    }
}

/*Sets the memory pointed at by 'dest', to the value of 'value', which is of a given size 'size'. Reverse the default endian of the computer.*/
void memset_reverse_endian(uint8_t* dest, uint64_t value, size_t size){
    uint8_t* value_pointer = (uint8_t*) &value;
    for (int i = 0; i < size; i++){
        dest[i] = value_pointer[size - 1 - i];
    }
}


#endif