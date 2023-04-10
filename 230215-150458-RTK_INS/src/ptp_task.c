/*
Barebones implementation of PTP master node
*/
#include "ptp.h"

#define PTP_EVENT_PORT 319
#define PTP_GENERAL_PORT 320
#define IPADDR_PTP    "224.0.1.129"
#define DELAY_RESP_LEN 72
#define ANNOUNCE_INTERVAL 0
#define REF_FREQ 100000000 // Reference frequency of 10MHz (yields 100ns accurate ptp stamps, or 0.1 micro seconds)

void init_header(struct ptp_header* header, enum ptp_type msg_type){
    memset(header, 0, sizeof(struct ptp_header));
    header->version_ptp = 0x02;
    memset_reverse_endian(header->clock_id, 0x020000fffe2d003c, 8);
    memset_reverse_endian(header->source_port_id, 1, 2);

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
        header->control_field = 0x02;
        break;

    case PTP_DELAYRESP:
        header->message_type = 0x09;
        memset_reverse_endian(header->msg_length, 54, 2);
        header->control_field = 0x03;
        break;

    case PTP_ANNOUNCE:
        header->message_type = 0x0b;
        memset_reverse_endian(header->msg_length, 64, 2);
        header->control_field = 0x05;
        header->log_message_interval = 1;

    default:
        break;
    }
}

void fill_sync_message(struct ptp_sync* msg, uint16_t seq_id){
    // Set seq
    memset_reverse_endian(msg->header.seq_id, seq_id, 2);

    // Set time stamp
    memcpy_reverse_endian(&msg->timestamp[2], (uint8_t *) &EthHandle.Instance->PTPTSHR, 4);
    memcpy_reverse_endian(&msg->timestamp[6], (uint8_t *) &EthHandle.Instance->PTPTSLR, 4);
}

void fill_followup_message(struct ptp_followup* msg, uint16_t seq_id, struct pbuf* p_sync){
    // Set seq
    memset_reverse_endian(msg->header.seq_id, seq_id, 2);

    // Set time stamp
    memcpy_reverse_endian(&msg->timestamp[2], (uint8_t*) &p_sync->p_desc->TimeStampHigh, 4);
    memcpy_reverse_endian(&msg->timestamp[6], (uint8_t*) &p_sync->p_desc->TimeStampLow, 4);
    
}

void fill_delayresp_message(struct ptp_delayresp* msg, struct pbuf* p_req){
    struct ptp_header* p_header = (struct ptp_header*) p_req->payload;

    // Set seq
    memcpy(msg->header.seq_id, p_header->seq_id, 2);

    // Set source ID
    memcpy(msg->req_port_id, p_header->clock_id, 10);

    // Set time stamp
    memcpy_reverse_endian(&msg->timestamp[2], (uint8_t*) &p_req->p_desc->TimeStampHigh, 4);
    memcpy_reverse_endian(&msg->timestamp[6], (uint8_t*) &p_req->p_desc->TimeStampLow, 4);
}


void fill_announce_message(struct ptp_announce* msg, uint16_t seq_id){
    // Set seq
    memset_reverse_endian(msg->header.seq_id, (uint64_t) (seq_id / ANNOUNCE_INTERVAL), 2);

    // Set time stamp
    memcpy_reverse_endian(&msg->timestamp[2], (uint8_t *) &EthHandle.Instance->PTPTSHR, 4);
    memcpy_reverse_endian(&msg->timestamp[6], (uint8_t *) &EthHandle.Instance->PTPTSLR, 4);

    if (seq_id == 0){
        // Set random stuff based on what I see on ptpd library packages
        msg->gmPriority1 = 128;
        msg->gmPriority2 = 128;
        msg->gmClockClass = 13;
        msg->gmClockAcc = 0xfe;
        memset_reverse_endian(msg->gmClockVar, 0xffff, 2);
        msg->gmPriority2 = 128;
        msg->timeSource = 0xa0;

        memset_reverse_endian(msg->gmId, 0x020000fffe2d003c, 8);
    }
}

static void delayReqCb(void *arg, struct udp_pcb * pcb, struct pbuf *p, ip_addr_t *addr, u16_t port){
    // Check if delay req message has been received
    if (p->p_desc->ExtendedStatus & ETH_DMAPTPRXDESC_PTPMT_DELAYREQ){
        struct pbuf* q_delayresp = (struct pbuf*) arg;

        // Fill message with all info
        struct ptp_delayresp* ptp_delayresp_msg= (struct ptp_delayresp*) q_delayresp->payload;
        fill_delayresp_message(ptp_delayresp_msg, p);

        // Send response over "general msg socket"
        udp_sendto(pcb_general, q_delayresp, &ptp_ip, PTP_GENERAL_PORT);
    }

    // Free the allocated p buffer (very important)
    pbuf_free(p);
}

void PtpInit(){
    while (gnetif.ip_addr.addr == 0){
        OS_Delay(100);
    }
    // Init IGMP (Not sure what of this is needed actually)
    gnetif.flags |= NETIF_FLAG_IGMP;
    igmp_init();
    igmp_start(&gnetif);

    ptp_ip.addr = ipaddr_addr(IPADDR_PTP); 
    igmp_joingroup(&gnetif.ip_addr, &ptp_ip);

    // Create udp sockets
    pcb_event = udp_new();
    pcb_general = udp_new();

    udp_bind(pcb_event, &gnetif.ip_addr, PTP_EVENT_PORT);
    udp_bind(pcb_general, &gnetif.ip_addr, PTP_GENERAL_PORT);

    // Set ethernet registers
    ETH_TypeDef* p_eth_reg = EthHandle.Instance;
    p_eth_reg->MACFFR  |= ETH_MACFFR_PAM;            // Allow all multicast messages

    // Set registers for DMA time stamping on PTP message reception and transmition
    p_eth_reg->PTPTSCR |= (ETH_PTPTSSR_TSSMRME | ETH_PTPTSSR_TSSPTPOEFE | ETH_PTPTSSR_TSPTPPSV2E | ETH_PTPTSSR_TSSARFE);

    p_eth_reg->MACIMR |= ETH_MACIMR_TSTIM;          // 1. Mask the Time stamp trigger interrupt by setting bit 9 in the MACIMR register.
    p_eth_reg->PTPTSCR |= ETH_PTPTSCR_TSE;          // 2. Program Time stamp register bit 0 to enable time stamping.
 
    p_eth_reg->PTPTSCR |= ETH_PTPTSSR_TSSSR;
    p_eth_reg->PTPSSIR = (uint32_t) 0x3B9ACA00 / REF_FREQ;                        // 3. Program the Subsecond increment register based on the PTP clock frequency.
    /* Setup for fine correction */
    double clk_frec = (double)HAL_RCC_GetHCLKFreq();
    double frec_ratio = clk_frec / REF_FREQ;
    double freq_comp = pow(2, 32) / frec_ratio;
    p_eth_reg->PTPTSAR = (uint32_t) freq_comp;  // 4. If you are using the Fine correction method, program the Time stamp addend register
    p_eth_reg->PTPTSCR |= ETH_PTPTSCR_TSARU;    //  and set Time stamp control register bit 5 (addend register update).

    while(p_eth_reg->PTPTSCR & ETH_PTPTSCR_TSARU); // 5. Poll the Time stamp control register until bit 5 is cleared.

    p_eth_reg->PTPTSCR |= ETH_PTPTSCR_TSFCU; // 6. To select the Fine correction method (if required), program Time stamp control register bit 1.

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
    // Init ptp
    PtpInit();

    // Create buffers for each type of message
    struct pbuf *q_sync = pbuf_alloc(PBUF_RAW, sizeof(struct ptp_sync), PBUF_POOL);
    struct ptp_sync* ptp_sync_msg = (struct ptp_sync*)q_sync->payload;
    init_header(&ptp_sync_msg->header, PTP_SYNC);

    struct pbuf *q_followup = pbuf_alloc(PBUF_RAW, sizeof(struct ptp_followup), PBUF_POOL);
    struct ptp_followup* ptp_followup_msg = (struct ptp_followup*)q_followup->payload;
    init_header(&ptp_followup_msg->header, PTP_FOLLOWUP);

    struct pbuf *q_delayresp = pbuf_alloc(PBUF_RAW, sizeof(struct ptp_delayresp), PBUF_POOL);
    struct ptp_delayresp* ptp_delayresp_msg = (struct ptp_delayresp*)q_delayresp->payload;
    init_header(&ptp_delayresp_msg->header, PTP_DELAYRESP);

    struct pbuf *q_announce = pbuf_alloc(PBUF_RAW, sizeof(struct ptp_announce), PBUF_POOL);
    struct ptp_announce* ptp_announce_msg = (struct ptp_announce*)q_announce->payload;
    init_header(&ptp_announce_msg->header, PTP_ANNOUNCE);

    // Set up UDP callback for delay request messages
    udp_recv(pcb_event, delayReqCb, (void*) q_delayresp);

    // Initialize infinite PTP loop
    uint16_t seq_id = 0;
    
    while (1){
        osSemaphoreWait(g_sem_ptp, osWaitForever); // Loop at 1Hz

        if (ANNOUNCE_INTERVAL != 0 && seq_id % ANNOUNCE_INTERVAL == 0){  // Announce message at predefined interval
            fill_announce_message(ptp_announce_msg, seq_id);
            udp_sendto(pcb_general, q_announce, &ptp_ip, PTP_GENERAL_PORT);
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