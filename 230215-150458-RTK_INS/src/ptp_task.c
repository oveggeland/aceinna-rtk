/*
Barebones implementation of PTP master node
*/
#include "ptp.h"
#include "ethernetif.h"
#include <math.h>

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
    memcpy_reverse_endian(&msg->timestamp[2], (void *) &EthHandle.Instance->PTPTSHR, 4);
    memcpy_reverse_endian(&msg->timestamp[6], (void *) &EthHandle.Instance->PTPTSLR, 4);
}

void fill_followup_message(struct ptp_followup* msg, uint16_t seq_id, struct pbuf* p_sync){
    // Zero out message
    memset(msg, 0, sizeof(struct ptp_sync));

    // Init header
    init_header((struct ptp_header*) msg, PTP_FOLLOWUP, seq_id);

    // Set time stamp
    //memcpy_reverse_endian(&msg->timestamp[2], (void *) &EthHandle.Instance->PTPTSHR, 4);
    //memcpy_reverse_endian(&msg->timestamp[6], (void *) &EthHandle.Instance->PTPTSLR, 4);
    
    memcpy_reverse_endian(&msg->timestamp[2], &p_sync->p_desc->TimeStampHigh, 4);
    memcpy_reverse_endian(&msg->timestamp[6], &p_sync->p_desc->TimeStampLow, 4);
    
}

void fill_delayresp_message(struct ptp_delayresp* msg, uint16_t seq_id, uint8_t* p_srcId, struct pbuf* p_req){
    // Zero out message
    memset(msg, 0, sizeof(struct ptp_delayresp));

    // Init header
    init_header((struct ptp_header*) msg, PTP_DELAYRESP, seq_id);

    // Set time stamp
    memcpy_reverse_endian(&msg->timestamp[2], &p_req->p_desc->TimeStampHigh, 4);
    memcpy_reverse_endian(&msg->timestamp[6], &p_req->p_desc->TimeStampLow, 4);

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
    fill_delayresp_message(p_resp, seq_id, p_srcId, p);

    // Send over "general msg socket"
    udp_sendto(pcb_general, q_delayresp, &ptp_ip, PTP_GENERAL_PORT);

    // Free space (very important)
    pbuf_free(q_delayresp);
    pbuf_free(p);
    
    if (p->p_desc->ExtendedStatus & ETH_DMAPTPRXDESC_PTPMT_DELAYREQ){
        LED2_Toggle(); // Indicate delay req message has been received
    }
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

    // Set ethernet registers
    ETH_TypeDef* p_eth_reg = EthHandle.Instance;
    p_eth_reg->MACFFR  |= ETH_MACFFR_PAM;            // Allow all multicast messages

    
    // Set up DMA for ethernet Rx and Tx  (Follow status bits at (ETH_DMASR))
    while (p_eth_reg->DMABMR & ETH_DMABMR_SR){ // Wait for software reset to finish
        LED2_Toggle();
        OS_Delay(100);
    }    

    // OSkar test something
    //EthHandle.TxDesc->Status |= ETH_DMATXDESC_TTSE;

    p_eth_reg->PTPTSCR |= (ETH_PTPTSSR_TSSMRME | ETH_PTPTSSR_TSSPTPOEFE | ETH_PTPTSSR_TSPTPPSV2E | ETH_PTPTSSR_TSSARFE);

    p_eth_reg->MACIMR |= ETH_MACIMR_TSTIM;          // 1. Mask the Time stamp trigger interrupt by setting bit 9 in the MACIMR register.
    p_eth_reg->PTPTSCR |= ETH_PTPTSCR_TSE;          // 2. Program Time stamp register bit 0 to enable time stamping.
 
    double clk_frec = (double)HAL_RCC_GetHCLKFreq();
    p_eth_reg->PTPSSIR = (uint32_t) round(0x7FFFFFFF/clk_frec);                        // 3. Program the Subsecond increment register based on the PTP clock frequency.
    p_eth_reg->PTPTSHUR = 0;                       // 7. Program the Time stamp high update and Time stamp low update registers with the appropriate time value
    p_eth_reg->PTPTSLUR = 0;                        // 7. Program the Time stamp high update and Time stamp low update registers with the appropriate time value
    p_eth_reg->PTPTSCR |= ETH_PTPTSCR_TSSTI;        // 8. Set Time stamp control register bit 2 (Time stamp init).

    p_eth_reg->DMAIER |= (ETH_DMAIER_NISE | ETH_DMAIER_RIE | ETH_DMAIER_TIE);
    p_eth_reg->DMAOMR |= (ETH_DMAOMR_SR | ETH_DMAOMR_ST);
    p_eth_reg->DMABMR |= ETH_DMABMR_EDE;
    
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

        // Send followup
        fill_followup_message(ptp_followup_msg, seq_id, q_sync);
        udp_sendto(pcb_general, q_followup, &ptp_ip, PTP_GENERAL_PORT);

        seq_id ++;
    };
};