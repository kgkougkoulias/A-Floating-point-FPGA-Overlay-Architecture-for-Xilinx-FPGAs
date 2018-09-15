#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "configs.h"
#include "functions.h"
#include "drivers_v2.h"
#include "platform.h"
#include "xil_printf.h"
#include "xil_io.h"
#include "xtime_l.h"
#include "xil_cache.h"

void program_ovrl(char *alg){

	uint32_t pr_sq[49];

	if(strcmp(alg, "mm") == 0){
		memcpy(&pr_sq[0], &mm[0], sizeof(pr_sq));
	}
	else if(strcmp(alg,"kmeans") == 0){
		memcpy(&pr_sq[0], &km[0], sizeof(pr_sq));
	}
	else if(strcmp(alg,"stencil") == 0){
		memcpy(&pr_sq[0], &stenc[0], sizeof(pr_sq));
	}

	// up to 16 burst sizes to a fixes address
	Xil_Out32(CDMA_CONTROL, 0x00000020); 			// set mode, interrupt etc
	Xil_Out32(CDMA_SOURCE, (uint32_t)&pr_sq[0]); 	// source
	Xil_Out32(CDMA_DEST, OVRL_CONF); 				// destination
	Xil_DCacheFlushRange((unsigned int)pr_sq, 196);
	Xil_Out32(CMDA_BTT, 0x00000040); 				// number of bytes to send


	// poll for completion
	while((Xil_In32(CDMA_STATUS) & 0x00000002) != 0x00000002){

	}

	Xil_Out32(CDMA_SOURCE, (uint32_t)&pr_sq[16]); 		// source
	Xil_Out32(CDMA_DEST, OVRL_CONF); 					// destination
	Xil_DCacheFlushRange((unsigned int)pr_sq[16], 196);
	Xil_Out32(CMDA_BTT, 0x00000040); 					// number of bytes to send

	while((Xil_In32(CDMA_STATUS) & 0x00000002) != 0x00000002){

	}

	Xil_Out32(CDMA_SOURCE, (uint32_t)&pr_sq[32]); 		// source
	Xil_Out32(CDMA_DEST, OVRL_CONF); 					// destination
	Xil_DCacheFlushRange((unsigned int)pr_sq[32], 196);
	Xil_Out32(CMDA_BTT, 0x00000040); 					// number of bytes to send

	while((Xil_In32(CDMA_STATUS) & 0x00000002) != 0x00000002){

	}

	Xil_Out32(CDMA_SOURCE, (uint32_t)&pr_sq[48]); 		// source
	Xil_Out32(CDMA_DEST, OVRL_CONF); 			// destination
	Xil_DCacheFlushRange((unsigned int)pr_sq, 4);
	Xil_Out32(CMDA_BTT, 0x00000004); 			// number of bytes to send

	while((Xil_In32(CDMA_STATUS) & 0x00000002) != 0x00000002){

	}

}
