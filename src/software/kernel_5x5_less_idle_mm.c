#include <stdio.h>
#include <inttypes.h>
#include <string.h>
#include "platform.h"
#include "xil_printf.h"
#include "xil_io.h"
#include "xtime_l.h"
#include "drivers_v2.h"
#include "sleep.h"
#include "xil_cache.h"

float kernel_5x5_less_idle_mm_64(float *d){


	uint32_t i;
	uint32_t res0;
	float c = 0.0f;


	//Xil_DCacheFlushRange((unsigned int)d, 320);
	//Xil_Out32(CMDA_BTT, 0x00000140); 			// number of bytes to send
	//Xil_Out32(CMDA_BTT, 0x00000050); 	    // number of bytes to send


	for(i=0;i<4;i++){

		while(Xil_In32(OVRL_STATUS) != 0x00000001){

		}

		res0 = Xil_In32(0x43c3005c);
		c += *(float*) &res0;

	}


	return c;

}
