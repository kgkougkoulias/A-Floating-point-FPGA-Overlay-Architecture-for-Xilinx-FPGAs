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



void mm_v2()
{

    uint32_t i;
    uint32_t buffer;

    XTime tStart, tEnd;
	int A_row = 400;
	int A_col = 800;
	int B_row = 800;
	int B_col = 400;

	float *a, *b;
	float *c_cpu, *c_dyser;

	a = (float*)malloc(sizeof(float)*A_row*A_col);
	b = (float*)malloc(sizeof(float)*B_row*B_col);
	c_cpu   = (float*)malloc(sizeof(float)*A_row*B_col);
	c_dyser = (float*)malloc(sizeof(float)*A_row*B_col);


	for(i=0;i<A_row*A_col;i++){
		buffer = i%33;
		a[i] = (float)buffer/(2.42354+i/10000);
	}

	for(i=0;i<B_row*B_col;i++){
		buffer =  i%15;
		b[i] = (float) buffer/(2.9843+i/10000);
	}

	for(i=0;i<A_row*B_col;i++){
		c_cpu[i] = 0;
		c_dyser[i] = 0;
	}


	printf("\nStarting Computation\n");


	XTime_GetTime(&tStart);
	mm_cpu(A_row, B_col, A_col, 1, a, A_row, b, B_col, 0, c_cpu, A_row);
	XTime_GetTime(&tEnd);
	printf("CPU time was %.9f s.\n",(1.0 * (tEnd - tStart) / (COUNTS_PER_SECOND/1000000))/1000000);

	XTime_GetTime(&tStart);
	dyser_mm_less_idle_64(A_row, B_col, A_col, 1, a, A_row, b, B_col, 0, c_dyser, A_row);
	XTime_GetTime(&tEnd);
	printf("Overlay time was %.9f s.\n",(1.0 * (tEnd - tStart) / (COUNTS_PER_SECOND/1000000))/1000000);


	uint32_t error_num = 0;
	float max_error = 0;
	float error = 0;
	float cum_error = 0;
	float sum_cpu = 0;
	float sum_dys = 0;
	float avg_cpu;
	float avg_ovrl;

	for(i=0;i<A_row*B_col;i++){
		sum_cpu += c_cpu[i];
		sum_dys += c_dyser[i];
	}

	for(i=0;i<A_row*B_col;i++){
		if((fabs(c_dyser[i]-c_cpu[i])/fabs(c_cpu[i])) > 0.008){

				error = fabs(c_dyser[i]-c_cpu[i]);
				error_num++;
				cum_error += error;
				if(max_error < (fabs(c_dyser[i] - c_cpu[i]))){
					max_error = fabs(c_dyser[i] - c_cpu[i]);
				}
		}
	}

	avg_cpu  = sum_cpu/(A_row*B_col);
	avg_ovrl = sum_dys/(A_row*B_col);

	printf("Percentage of errors is %f\n",(float)error_num/(A_row*B_col));
	printf("Max error is %f\n",max_error);
	printf("Average error is %f\n",cum_error/(A_row*B_col));
	printf("Average percentage is %f\n",(fabs(avg_cpu-avg_ovrl)/fabs(avg_cpu)));
	printf("Average cpu value is %f\n",avg_cpu);
	printf("Average overlay value is %f\n",avg_ovrl);


}
