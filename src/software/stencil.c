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


void stencil(){

	printf("\n\n\n");

	uint32_t i, size;
	uint32_t nx = 1000;
	uint32_t ny = 1000;
	uint32_t nz = 10;
	XTime tStart, tEnd;

	float *A0, *Anext_cpu, *Anext_dyser;

	size = nx*ny*nz;

	A0 = (float*)malloc(sizeof(float)*size);
	Anext_cpu = (float*)malloc(sizeof(float)*size);
	Anext_dyser = (float*)malloc(sizeof(float)*size);

	for(i=0;i<size;i++){
		A0[i] = (float)rand()/(float)(RAND_MAX/25);
		//A0[i] = 2;
	}

	for(i=0;i<size;i++){
			Anext_cpu[i] = 0;
	}

	for(i=0;i<size;i++){
			Anext_dyser[i] = 0;
	}

	XTime_GetTime(&tStart);
	cpu_stencil(1.4, 1.1, A0, Anext_cpu, nx, ny, nz);
	XTime_GetTime(&tEnd);
	printf("CPU time was %.9f s.\n",(1.0 * (tEnd - tStart) / (COUNTS_PER_SECOND/1000000))/1000000);

	XTime_GetTime(&tStart);
	stencil_ovrl_less_idle(1.4, 1.1, A0, Anext_dyser, nx, ny, nz);
	XTime_GetTime(&tEnd);
	printf("Overlay time was %.9f s.\n",(1.0 * (tEnd - tStart) / (COUNTS_PER_SECOND/1000000))/1000000);


	uint32_t error_num = 0;
	float max_error = 0;
	float error = 0;
	float cum_error = 0;
	float sum_cpu = 0;
	float sum_dys = 0;
	uint32_t er_index = 0;
	float cpu_val = 0;
	float dy_val = 0;

	for(i=0;i<size;i++){
		sum_cpu += Anext_cpu[i];
		sum_dys += Anext_dyser[i];
	}

	for(i=0;i<size;i++){
		if((fabs(Anext_dyser[i]-Anext_cpu[i])/fabs(Anext_cpu[i])) > 0.0001){

				error = fabs(Anext_dyser[i]-Anext_cpu[i]);
				error_num++;
				cum_error += error;
				if(max_error < (fabs(Anext_dyser[i] - Anext_cpu[i]))){
					max_error = fabs(Anext_dyser[i] - Anext_cpu[i]);
					cpu_val = Anext_cpu[i];
					dy_val  = Anext_dyser[i];
					er_index = i;
				}
		}
	}

	printf("Percentage of errors is %f\n",(float)error_num/size);
	printf("Max error is %f\n",max_error);
	printf("Average error is %f\n",cum_error/size);
	printf("Average cpu value is %f\n",sum_cpu/size);
	printf("Average dyser value is %f\n",sum_dys/size);
	printf("Error index is %d\n",er_index);
	printf("Cpu error value is %f\n",cpu_val);
	printf("Overlay error value is %f\n",dy_val);


}
