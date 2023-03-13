/*****************************************************************************
 * @file   eth_task.c
 *
 * THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY
 * KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A
 * PARTICULAR PURPOSE.
 *
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

#include "calibrationAPI.h"
#include "tcp_driver.h"

#define PTP_EVENT_PORT 319
#define PTP_GENERAL_PORT 320
#define IPADDR_PTP    "224.0.1.129"
#define DELAY_RESP_LEN 72

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

/* Helper function. This operation is performed by all messages*/
void set_timestamp(uint8_t* dest, uint64_t* msec){
    uint64_t secs = (uint64_t) (*msec / 1000);
    memcpy_reverse_endian(dest, (uint8_t*) &secs, 6);

    uint32_t nsecs = (*msec - 1000*secs)*1000000;
    memcpy_reverse_endian(&dest[6], (uint8_t*) &nsecs, 6);
}

enum ptp_type{
    PTP_SYNC = 0,
    PTP_FOLLOWUP = 1,
    PTP_DELAYRESP = 2,
};

uint16_t g_seq_id = 0;
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
    uint8_t header[sizeof(struct ptp_header)];
    uint8_t timestamp[10];
};

time_t g_origin_stamp = 0;
struct ptp_followup
{
    uint8_t header[sizeof(struct ptp_header)];
    uint8_t timestamp[10];
};

struct ptp_delayreq
{
    uint8_t header[sizeof(struct ptp_header)];
    uint8_t timestamp[10];
};

struct ptp_delayresp
{
    uint8_t header[sizeof(struct ptp_header)];
    uint8_t timestamp[10];
    uint8_t req_port_id[10];
};

void init_header(struct ptp_header* header, enum ptp_type msg_type){
    memset(header, 0, sizeof(struct ptp_header));
    header->version_ptp = 2;
    memset_reverse_endian(header->flags, 0x0200, 2);
    memset_reverse_endian(header->source_port_id, 1, 2);
    memset_reverse_endian(header->seq_id, g_seq_id, 2);

    switch (msg_type)
    {
    case PTP_SYNC:
        header->message_type = 0;
        memset_reverse_endian(header->msg_length, 44, 2);
        break;

    case PTP_FOLLOWUP:
        header->message_type = 8;
        memset_reverse_endian(header->msg_length, 44, 2);
        break;

    case PTP_DELAYRESP:
        header->message_type = 9;
        memset_reverse_endian(header->msg_length, 54, 2);
        break;

    default:
        break;
    }
}

void fill_sync_message(struct ptp_sync* msg){
    // Zero out message
    memset(msg, 0, sizeof(struct ptp_sync));

    // Init header
    init_header((struct ptp_header*) msg, PTP_SYNC);

    // Set time stamp
    uint64_t msecs = get_time_of_msec();
    set_timestamp(msg->timestamp, &msecs);
}

void fill_followup_message(struct ptp_followup* msg){
    // Zero out message
    memset(msg, 0, sizeof(struct ptp_sync));

    // Init header
    init_header((struct ptp_header*) msg, PTP_FOLLOWUP);

    // Set time stamp
    set_timestamp(msg->timestamp, (uint64_t*) &g_origin_stamp);
}



static void delayReqCb(void *arg, struct udp_pcb * pcb, struct pbuf *p, ip_addr_t *addr, u16_t port){
    while (1){
        LED1_Toggle();
        LED2_Toggle();
        LED3_Toggle();
        OS_Delay(200);
    }
}

void PtpListener(void const *argument){
    int fd = socket(AF_INET, SOCK_DGRAM, 0);
    if (fd < 0) {
        LED2_On();
    }

    // allow multiple sockets to use the same PORT number
    //
    int yes = 1;
    if (
        setsockopt(
            fd, SOL_SOCKET, SO_REUSEADDR, (char*) &yes, sizeof(yes)
        ) < 0
    ){
        LED2_On();
    }

    // set up destination address
    //
    struct sockaddr_in addr;
    memset(&addr, 0, sizeof(addr));
    addr.sin_family = AF_INET;
    addr.sin_addr.s_addr = INADDR_ANY; // differs from sender
    addr.sin_port = htons(PTP_EVENT_PORT);

    // bind to receive address
    //
    if (bind(fd, (struct sockaddr*) &addr, sizeof(addr)) < 0) {
        LED2_On();
    }

    // Set loopback
    int loop = 1;
    int err = setsockopt(fd, IPPROTO_IP, IP_MULTICAST_LOOP, &loop, sizeof(loop));
    if (err < 0) {
        LED2_On();
    }

    // use setsockopt() to request that the kernel join a multicast group
    //
    struct ip_mreq mreq;
    mreq.imr_multiaddr.s_addr = inet_addr(IPADDR_PTP);
    mreq.imr_interface.s_addr = inet_addr("192.168.1.110");
    if (
        setsockopt(
            fd, IPPROTO_IP, IP_ADD_MEMBERSHIP, (char*) &mreq, sizeof(mreq)
        ) < 0
    ){
        LED2_On();
        // debug_led(3);
    }

    // now just enter a read-print loop
    //
    int n;
    char msgbuf[250];
    while (1) {
        LED1_Toggle();
        n = recv(fd, msgbuf, 250, 0);
        if (n < 0) {
            LED2_Toggle();
        }
    }
}


/** ***************************************************************************
 * @name PtpTask()
 * @brief Acting as a master clock, synchronizing other sensors to the aceinna GPS based clock
 * @param N/A
 * @retval N/A
 ******************************************************************************/
void PtpTask(void const *argument)
{
	// Init ethernet
    ethernet_init();

    // Define IP's
    ip_addr_t ptp_ip;
    ptp_ip.addr = ipaddr_addr(IPADDR_PTP); 

    gnetif.flags |= NETIF_FLAG_IGMP;
    
    igmp_init();
    igmp_start(&gnetif);
    int iret = igmp_joingroup(IP_ADDR_ANY,(struct ip_addr *)(&ptp_ip));
    if (iret != ERR_OK){
        LED2_On();
    }

    
    osThreadDef(PTP_LISTENER, PtpListener, osPriorityAboveNormal, 0, TASK_USERTCP_STACK);
    osThreadId iD = osThreadCreate(osThread(PTP_LISTENER), NULL);
    if (iD == NULL)
    {
        while (1){
            LED1_Toggle();
        }
    }

    struct udp_pcb *pcb;
    pcb = udp_new();
    pcb->so_options |= SOF_BROADCAST;

    udp_bind(pcb, &gnetif.ip_addr, PTP_EVENT_PORT);
    //udp_recv(pcb, delayReqCb, pcb);

    // Create buffer and fill it with standard header
    struct pbuf *q_sync;
    struct pbuf *q_followup;

    q_sync = pbuf_alloc(PBUF_RAW, sizeof(struct ptp_sync), PBUF_POOL);
    struct ptp_sync* ptp_sync_msg = (struct ptp_sync*)q_sync->payload;

    q_followup = pbuf_alloc(PBUF_RAW, sizeof(struct ptp_followup), PBUF_POOL);
    struct ptp_followup* ptp_followup_msg = (struct ptp_followup*)q_followup->payload;

    udp_sendto(pcb,q_sync,&ptp_ip,PTP_EVENT_PORT);

    while (1){
        // Send Sync signal
        fill_sync_message(ptp_sync_msg);
        udp_sendto(pcb, q_sync, &ptp_ip, PTP_EVENT_PORT);
        g_origin_stamp = get_time_of_msec() + 1;

        fill_followup_message(ptp_followup_msg);
        udp_sendto(pcb, q_followup, &ptp_ip, PTP_GENERAL_PORT);

        g_seq_id ++;
        LED2_Toggle();
        OS_Delay(1000);
    };
};