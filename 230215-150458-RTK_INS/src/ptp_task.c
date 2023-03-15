/*
Barebones implementation of PTP master node
*/
#include "ptp.h"
#include "main.h"
#include "timer.h"

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

void init_header(struct ptp_header* header, enum ptp_type msg_type, uint16_t seq_id){
    memset(header, 0, sizeof(struct ptp_header));
    header->version_ptp = 0x02;
    memset_reverse_endian(header->seq_id, seq_id, 2);

    switch (msg_type)
    {
    case PTP_SYNC:
        header->message_type = 0x00;
        memset_reverse_endian(header->msg_length, 44, 2);
        memset_reverse_endian(header->flags, 0x0200, 2);
        break;

    case PTP_FOLLOWUP:
        header->message_type = 0x08;
        memset_reverse_endian(header->msg_length, 44, 2);
        memset_reverse_endian(header->flags, 0x0200, 2);
        break;

    case PTP_DELAYRESP:
        header->message_type = 0x09;
        memset_reverse_endian(header->msg_length, 54, 2);
        header->control_field = 0x03;
        break;

    default:
        break;
    }
}

void fill_sync_message(struct ptp_sync* msg, uint16_t seq_id){
    // Zero out message
    memset(msg, 0, sizeof(struct ptp_sync));

    // Init header
    init_header((struct ptp_header*) msg, PTP_SYNC, seq_id);

    // Set time stamp
    uint64_t msecs = get_time_of_msec();
    set_timestamp(msg->timestamp, &msecs);
}

void fill_followup_message(struct ptp_followup* msg, uint16_t seq_id){
    // Zero out message
    memset(msg, 0, sizeof(struct ptp_sync));

    // Init header
    init_header((struct ptp_header*) msg, PTP_FOLLOWUP, seq_id);

    // Set time stamp
    set_timestamp(msg->timestamp, (uint64_t*) &g_origin_stamp);
}

void fill_delayresp_message(struct ptp_delayresp* msg, uint64_t* recv_stamp, uint8_t* p_srcId, uint16_t seq_id){
    // Zero out message
    memset(msg, 0, sizeof(struct ptp_delayresp));

    // Init header
    init_header((struct ptp_header*) msg, PTP_DELAYRESP, seq_id);

    // Set time stamp
    set_timestamp(msg->timestamp, recv_stamp);

    // Set source ID
    memcpy(msg->req_port_id, p_srcId, 10);
}


static void delayReqCb(void *arg, struct udp_pcb * pcb, struct pbuf *p, ip_addr_t *addr, u16_t port){
    // Save time stamp
    uint64_t recv_time = (uint64_t) get_time_of_msec();

    // Find source ID
    struct ptp_header* p_header = (struct ptp_header*) p->payload; 
    uint8_t* p_srcId = p_header->clock_id;

    // Find seq ID
    uint16_t seq_id;
    memcpy_reverse_endian((uint8_t*) &seq_id, p_header->seq_id, 2);

    // Alloc response buffer (This could be done in init function, if we use a semaphore)
    struct pbuf* q_delayresp = pbuf_alloc(PBUF_RAW, sizeof(struct ptp_delayresp), PBUF_POOL);
    struct ptp_delayresp* p_resp= (struct ptp_delayresp*) q_delayresp->payload;

    // Fill message with all info
    fill_delayresp_message(p_resp, &recv_time, p_srcId, seq_id);

    // Send over "general msg socket"
    udp_sendto(pcb_general, q_delayresp, &ptp_ip, PTP_GENERAL_PORT);

    // Free space (very important)
    pbuf_free(q_delayresp);
    pbuf_free(p);
    
    // Indicate delay response reception (debug)
    LED1_Toggle();
}


void PtpInit(){
    // Set IP
    ptp_ip.addr = ipaddr_addr(IPADDR_PTP); 

    // Init IGMP (Not sure if this is needed actually)
    gnetif.flags |= NETIF_FLAG_IGMP;
    igmp_init();
    igmp_start(&gnetif);
    igmp_joingroup(IP_ADDR_ANY,(struct ip_addr *)(&ptp_ip));

    // Create udp sockets
    pcb_event = udp_new();
    pcb_general = udp_new();

    udp_bind(pcb_event, &gnetif.ip_addr, PTP_EVENT_PORT);
    udp_bind(pcb_general, &gnetif.ip_addr, PTP_GENERAL_PORT);
    udp_recv(pcb_event, delayReqCb, NULL);

    // Set MAC to receive all multicast
    uint32_t* p_mac_ffr = (uint32_t*) (ETH_MAC_BASE + 0x04);
    *p_mac_ffr |= ETH_MACFFR_PAM;
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

    // Init ptp
    PtpInit();

    // Create buffer and fill it with standard header
    struct pbuf *q_sync;
    struct pbuf *q_followup;

    q_sync = pbuf_alloc(PBUF_RAW, sizeof(struct ptp_sync), PBUF_POOL);
    struct ptp_sync* ptp_sync_msg = (struct ptp_sync*)q_sync->payload;

    q_followup = pbuf_alloc(PBUF_RAW, sizeof(struct ptp_followup), PBUF_POOL);
    struct ptp_followup* ptp_followup_msg = (struct ptp_followup*)q_followup->payload;

    // Initialize infinite PTP loop
    uint16_t seq_id = 0;
    osStatus res;
    while (1){
        res = osSemaphoreWait(g_sem_ptp, 1500);
        if (res != osOK)
        {
            continue;
        }
        // Send Sync signal
        fill_sync_message(ptp_sync_msg, seq_id);
        udp_sendto(pcb_event, q_sync, &ptp_ip, PTP_EVENT_PORT);
        g_origin_stamp = get_time_of_msec(); // TODO: Fix this mess

        // Send followup
        fill_followup_message(ptp_followup_msg, seq_id);
        udp_sendto(pcb_general, q_followup, &ptp_ip, PTP_GENERAL_PORT);

        seq_id ++;
    };
};