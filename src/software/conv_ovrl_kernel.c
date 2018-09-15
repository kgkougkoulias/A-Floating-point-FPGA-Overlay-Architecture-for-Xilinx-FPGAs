#include <stdio.h>
#include <stdlib.h>
#include <inttypes.h>
#include <string.h>
#include "platform.h"
#include "xil_printf.h"
#include "xil_io.h"
#include "xtime_l.h"
#include "drivers_v2.h"
#include "sleep.h"
#include "xil_cache.h"
#include "functions.h"

void kernel_conv(float *d, float *res){

	uint32_t i;
	uint32_t res0;
	//Xil_DCacheFlushRange((unsigned int)d, 320);
	//Xil_Out32(CMDA_BTT, 0x00000140); 			// number of bytes to send

	for(i=0;i<4;i++){

		while(Xil_In32(OVRL_STATUS) != 0x00000001){

		}
		res0 = Xil_In32(0x43c3005c);
		res[i] = *(float*) &res0;
	}
}
