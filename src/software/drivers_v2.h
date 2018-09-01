#define CDMA_CONTOL 0x7E200000
#define CDMA_STATUS 0x7E200004
#define OVRL_CONTOL 0x43C30050
#define OVRL_STATUS 0x43c30054
#define FIFO1_ADDR  0x43c30050
#define FIFO2_ADDR  0x43c3005a
#define OVRL_CONF   0x76000200
#define OVRL_PORT0  0x76000000
#define CDMA_SOURCE 0x7E200018
#define CDMN_DEST   0x7E200020
#define CDMN_BTT    0x7E200020

void kernel_5x5(float *d0);
void kernel_5x5_less_idle(float *d0, float *res);
float kernel_5x5_less_idle_small(float *d0);
void kernel_5x5_less_idle_64(float *d0, float *res);
float kernel_5x5_less_idle_mm(float *d0);
float kernel_5x5_less_idle_mm_64(float *d0);
void kernel_conv(float *d, float *res);
void kernel_5x5_stencil(float *d);
void program_ovrl(char *alg);
void program_cdma(uint32_t source, uint32_t destination);
