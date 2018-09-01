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


void conv()
{

    uint32_t i;

    XTime tStart, tEnd;
	int size = 10000000;

	printf("\n\n\n");

	float *h, *x;
	float *y_cpu, *y_dyser;

	x = (float*)malloc(sizeof(float)*size);
	h = (float*)malloc(sizeof(float)*10);
	y_cpu   = (float*)malloc(sizeof(float)*size);
	y_dyser = (float*)malloc(sizeof(float)*size);

	for(i=0;i<size;i++){
		x[i] = (float)rand()/(float)(RAND_MAX/66);
	}

	for(i=0;i<10;i++){
		h[i] = (float)rand()/(float)(RAND_MAX/66);
	}

	for(i=0;i<size;i++){
		y_cpu[i] = 0;
		y_dyser[i] = 0;
	}

	XTime_GetTime(&tStart);
	conv_cpu(y_cpu, x, h, size);
	XTime_GetTime(&tEnd);
	printf("CPU time was %.9f s.\n",(1.0 * (tEnd - tStart) / (COUNTS_PER_SECOND/1000000))/1000000);

	XTime_GetTime(&tStart);
	conv_ovrl(y_dyser, x, h, size);
	XTime_GetTime(&tEnd);
	printf("Overlay time was %.9f s.\n",(1.0 * (tEnd - tStart) / (COUNTS_PER_SECOND/1000000))/1000000);


	uint32_t error_num = 0;
	float max_error = 0;
	float error = 0;
	float cum_error = 0;
	float sum_cpu = 0;
	float sum_dys = 0;

	for(i=0;i<size;i++){
		sum_cpu += y_cpu[i];
		sum_dys += y_dyser[i];
	}

	for(i=0;i<size;i++){
		if((fabs(y_dyser[i]-y_cpu[i])/fabs(y_cpu[i])) > 0.0001){

				error = fabs(y_dyser[i]-y_cpu[i]);
				error_num++;
				cum_error += error;
				if(max_error < (fabs(y_dyser[i] - y_cpu[i]))){
					max_error = fabs(y_dyser[i] - y_cpu[i]);
				}
		}
	}

	printf("Error percentage is %f\n",(float)error_num/size);
	printf("Max error is %f\n",max_error);
	printf("Average error is %f\n",cum_error/size);
	printf("Average cpu value is %f\n",sum_cpu/size);
	printf("Average dyser value is %f\n",sum_dys/size);

}
