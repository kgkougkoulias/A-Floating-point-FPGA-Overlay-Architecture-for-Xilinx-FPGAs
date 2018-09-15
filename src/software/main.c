#include <stdio.h>
#include <stdlib.h>
#include <inttypes.h>
#include <string.h>
#include <math.h>
#include "platform.h"
#include "xil_printf.h"
#include "xil_io.h"
#include "xtime_l.h"
#include "drivers_v2.h"
#include "sleep.h"
#include "xil_cache.h"
#include "functions.h"


int main()
{
    init_platform();

    // select the algorithm to be runned
    char *alg = "stencil";

    Xil_Out32(OVRL_CONTOL, 0x00000000);  		   // Get to idle mode
	Xil_Out32(OVRL_CONTOL, 0x00000001);  		   // Send command to accelerator to get in conf mode

	if(strcmp(alg, "mm") == 0 || strcmp(alg, "conv") == 0){
		program_ovrl("mm");
		Xil_Out32(OVRL_CONTOL, 0x00060006);  	   // Send command to accelerator to get in calc mode
	}											   // and also program the output bridge
	else if(strcmp(alg, "kmeans") == 0){
		program_ovrl("kmeans");
		Xil_Out32(OVRL_CONTOL, 0x000b0006);  		// Send command to accelerator to get in calc mode
	}
	else if(strcmp(alg, "stencil") == 0){
		program_ovrl("stencil");
		Xil_Out32(OVRL_CONTOL, 0x0f04000e);  		// Send command to accelerator to get in calc mode
	}

	cpu_algorithms(alg);

	cleanup_platform();
	return 0;

}
