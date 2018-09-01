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

float *D;
float *D2;

void conv_cpu(float *y, float *x, float *h, uint32_t size){

	uint32_t i, j;

	for(i=10;i<size;i++){
		for(j=0;j<10;j++){
			y[i] += x[i-j] * h[j];
		}
	}

}



void conv_ovrl(float *y, float *x, float *h, uint32_t size){

	uint32_t i, j;

	D  = (float*)malloc(sizeof(float)*80);
	D2 = (float*)malloc(sizeof(float)*80);
    program_cdma((uint32_t)D, OVRL_PORT0); // initiate cdma (source, destination)


    for(j=0;j<4;j++){

    	D[j*20+1]  = h[0];
    	D[j*20+3]  = h[1];
    	D[j*20+5]  = h[2];
    	D[j*20+7]  = h[3];
    	D[j*20+9]  = h[4];
    	D[j*20+11] = h[5];
    	D[j*20+13] = h[6];
    	D[j*20+15] = h[7];
    	D[j*20+17] = h[8];
    	D[j*20+19] = h[9];
    }


    i = 10;
    for(j=0;j<4;j++){
    				D[j*20]    = x[i+j];	    //D[j*20+1]  = h[0];
    				D[j*20+2]  = x[i-1+j];		//D[j*20+3]  = h[1];
    				D[j*20+4]  = x[i-2+j];		//D[j*20+5]  = h[2];
    				D[j*20+6]  = x[i-3+j];		//D[j*20+7]  = h[3];
    				D[j*20+8]  = x[i-4+j];		//D[j*20+9]  = h[4];
    				D[j*20+10] = x[i-5+j];		//D[j*20+11] = h[5];
    				D[j*20+12] = x[i-6+j];		//D[j*20+13] = h[6];
    				D[j*20+14] = x[i-7+j];		//D[j*20+15] = h[7];
    				D[j*20+16] = x[i-8+j];		//D[j*20+17] = h[8];
    				D[j*20+18] = x[i-9+j];		//D[j*20+19] = h[9];
    			}


	for(i=14;i<size;i=i+4){


			Xil_DCacheFlushRange((unsigned int)D, 320);
			Xil_Out32(CMDA_BTT, 0x00000140); 			// number of bytes to send

			for(j=0;j<4;j++){
							D[j*20]    = x[i+j];	    //D[j*20+1]  = h[0];
							D[j*20+2]  = x[i-1+j];		//D[j*20+3]  = h[1];
							D[j*20+4]  = x[i-2+j];		//D[j*20+5]  = h[2];
							D[j*20+6]  = x[i-3+j];		//D[j*20+7]  = h[3];
							D[j*20+8]  = x[i-4+j];		//D[j*20+9]  = h[4];
							D[j*20+10] = x[i-5+j];		//D[j*20+11] = h[5];
							D[j*20+12] = x[i-6+j];		//D[j*20+13] = h[6];
							D[j*20+14] = x[i-7+j];		//D[j*20+15] = h[7];
							D[j*20+16] = x[i-8+j];		//D[j*20+17] = h[8];
							D[j*20+18] = x[i-9+j];		//D[j*20+19] = h[9];
			}

			kernel_conv(D, &y[i-4]);


		}
}
