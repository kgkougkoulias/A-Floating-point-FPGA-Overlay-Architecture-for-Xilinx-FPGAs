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

float *D;

void dyser_mm_less_idle_64(int m, int n, int k, float alpha, float *A, int lda, float *B, int ldb, float beta, float *C, int ldc)
{
	int mm, nn, i, j;
	float c;




	D = (float*)malloc(sizeof(float)*80);
	program_cdma((uint32_t)D, OVRL_PORT0); // initiate cdma (source, destination)


	for(mm = 0; mm < m; ++mm){

		for(nn = 0; nn < n; ++nn){
		c = 0.0f;


		i = 0;

		for(j=0;j<4;j++){
						D[j*20]    = A[mm + (i+j*10)   * lda];		D[j*20+1]  = B[nn + (i+j*10)   * ldb];
						D[j*20+2]  = A[mm + (i+j*10+1) * lda];		D[j*20+3]  = B[nn + (i+j*10+1) * ldb];
						D[j*20+4]  = A[mm + (i+j*10+2) * lda];		D[j*20+5]  = B[nn + (i+j*10+2) * ldb];
						D[j*20+6]  = A[mm + (i+j*10+3) * lda];		D[j*20+7]  = B[nn + (i+j*10+3) * ldb];
						D[j*20+8]  = A[mm + (i+j*10+4) * lda];		D[j*20+9]  = B[nn + (i+j*10+4) * ldb];
						D[j*20+10] = A[mm + (i+j*10+5) * lda];		D[j*20+11] = B[nn + (i+j*10+5) * ldb];
						D[j*20+12] = A[mm + (i+j*10+6) * lda];		D[j*20+13] = B[nn + (i+j*10+6) * ldb];
						D[j*20+14] = A[mm + (i+j*10+7) * lda];		D[j*20+15] = B[nn + (i+j*10+7) * ldb];
						D[j*20+16] = A[mm + (i+j*10+8) * lda];		D[j*20+17] = B[nn + (i+j*10+8) * ldb];
						D[j*20+18] = A[mm + (i+j*10+9) * lda];		D[j*20+19] = B[nn + (i+j*10+9) * ldb];
						}

		for(i = 40; i < k; i=i+40){

			Xil_DCacheFlushRange((unsigned int)D, 320);
			Xil_Out32(CMDA_BTT, 0x00000140); 				// number of bytes to send

			for(j=0;j<4;j++){

				D[j*20]    = A[mm + (i+j*10)   * lda];		D[j*20+1]  = B[nn + (i+j*10)   * ldb];
				D[j*20+2]  = A[mm + (i+j*10+1) * lda];		D[j*20+3]  = B[nn + (i+j*10+1) * ldb];
				D[j*20+4]  = A[mm + (i+j*10+2) * lda];		D[j*20+5]  = B[nn + (i+j*10+2) * ldb];
				D[j*20+6]  = A[mm + (i+j*10+3) * lda];		D[j*20+7]  = B[nn + (i+j*10+3) * ldb];
				D[j*20+8]  = A[mm + (i+j*10+4) * lda];		D[j*20+9]  = B[nn + (i+j*10+4) * ldb];
				D[j*20+10] = A[mm + (i+j*10+5) * lda];		D[j*20+11] = B[nn + (i+j*10+5) * ldb];
				D[j*20+12] = A[mm + (i+j*10+6) * lda];		D[j*20+13] = B[nn + (i+j*10+6) * ldb];
				D[j*20+14] = A[mm + (i+j*10+7) * lda];		D[j*20+15] = B[nn + (i+j*10+7) * ldb];
				D[j*20+16] = A[mm + (i+j*10+8) * lda];		D[j*20+17] = B[nn + (i+j*10+8) * ldb];
				D[j*20+18] = A[mm + (i+j*10+9) * lda];		D[j*20+19] = B[nn + (i+j*10+9) * ldb];

				}



			c += kernel_5x5_less_idle_mm_64(D);



		}

		C[mm+nn*ldc] = C[mm+nn*ldc] *  beta + alpha * c;
		}
	}




}
