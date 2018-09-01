#include <stdio.h>
#include <stdlib.h>
#include <inttypes.h>
#include "drivers_v2.h"
#include "functions.h"
#include "xil_cache.h"
#include "xil_io.h"
#include "xtime_l.h"

#define Index3D(_nx,_ny,_i,_j,_k) ((_i)+_nx*((_j)+_ny*(_k)))

float *D0;
float *results;

void cpu_stencil(float c0, float c1, float *A0, float *Anext, const int nx, const int ny, const int nz)
{
	uint32_t i, j, k;

		for(i=1;i<nx-1;i++)
		{
			for(j=1;j<ny-1;j++)
			{
				for(k=1;k<nz-1;k++)
				{
					Anext[Index3D (nx, ny, i, j, k)] =
					(A0[Index3D (nx, ny, i, j, k+1)] +
					A0[Index3D (nx, ny, i, j, k-1)] +
					A0[Index3D (nx, ny, i, j+1, k)] +
					A0[Index3D (nx, ny, i, j-1, k)] +
					A0[Index3D (nx, ny, i+1, j, k)] +
					A0[Index3D (nx, ny, i-1, j, k)])*c1
					- A0[Index3D (nx, ny, i, j, k)]*c0;

				}
			}
		}
}



void stencil_ovrl_less_idle(float c0, float c1, float *A0, float *Anext, const int nx, const int ny, const int nz)
{

	uint32_t i, j, e;
	uint32_t k = 1;


	D0 = (float*)malloc(sizeof(float)*80);
	results = (float*)malloc(sizeof(float)*8);


	for(e=0;e<4;e++){
		D0[20*e+0] = c0;
		D0[20*e+2] = c1;
		D0[20*e+17] = c1;
		D0[20*e+18] = c0;
	}

	program_cdma((uint32_t)D0, OVRL_PORT0); // initiate cdma (source, destination)

		for(i=1;i<nx-1;i++)
		{
			j=1;
			for(e=0;e<4;e++){

				 /*D0[20*e+0] = c0;*/						    D0[20*e+11] = A0[Index3D(ny,nx,i,j,k+(2*e)+2)];
				 D0[20*e+1] = A0[Index3D(ny,nx,i,j,k+2*e)];		D0[20*e+12] = A0[Index3D(ny,nx,i,j,k+(2*e))];
				 /*D0[20*e+2] = c1;	*/							D0[20*e+13] = A0[Index3D(ny,nx,i,j+1,k+(2*e)+1)];
				 D0[20*e+3] = A0[Index3D(ny,nx,i-1,j,k+2*e)];	D0[20*e+14] = A0[Index3D(ny,nx,i,j-1,k+(2*e)+1)];
				 D0[20*e+4] = A0[Index3D(ny,nx,i+1,j,k+2*e)];	D0[20*e+15] = A0[Index3D(ny,nx,i+1,j,k+(2*e)+1)];
				 D0[20*e+5] = A0[Index3D(ny,nx,i,j-1,k+2*e)];	D0[20*e+16] = A0[Index3D(ny,nx,i-1,j,k+(2*e)+1)];
				 D0[20*e+6] = A0[Index3D(ny,nx,i,j+1,k+2*e)];	//D0[20*e+17] = c1;
				 D0[20*e+7] = A0[Index3D(ny,nx,i,j,k+(2*e)-1)];	//D0[20*e+18] = c0;
				 D0[20*e+8] = A0[Index3D(ny,nx,i,j,k+(2*e)+1)];	D0[20*e+19] = A0[Index3D(ny,nx,i,j,k+(2*e)+1)];
			}

			for(j=2;j<ny-1;j++)
			{

				Xil_DCacheFlushRange((unsigned int)D0, 320);
				Xil_Out32(CMDA_BTT, 0x0000140); 				// number of bytes to send

				for(e=0;e<4;e++){

					 /*D0[20*e+0] = c0;*/							D0[20*e+11] = A0[Index3D(ny,nx,i,j,k+(2*e)+2)];
					 D0[20*e+1] = A0[Index3D(ny,nx,i,j,k+2*e)];		D0[20*e+12] = A0[Index3D(ny,nx,i,j,k+(2*e))];
					 /*D0[20*e+2] = c1;	*/							D0[20*e+13] = A0[Index3D(ny,nx,i,j+1,k+(2*e)+1)];
					 D0[20*e+3] = A0[Index3D(ny,nx,i-1,j,k+2*e)];	D0[20*e+14] = A0[Index3D(ny,nx,i,j-1,k+(2*e)+1)];
					 D0[20*e+4] = A0[Index3D(ny,nx,i+1,j,k+2*e)];	D0[20*e+15] = A0[Index3D(ny,nx,i+1,j,k+(2*e)+1)];
					 D0[20*e+5] = A0[Index3D(ny,nx,i,j-1,k+2*e)];	D0[20*e+16] = A0[Index3D(ny,nx,i-1,j,k+(2*e)+1)];
					 D0[20*e+6] = A0[Index3D(ny,nx,i,j+1,k+2*e)];	//D0[20*e+17] = c1;
					 D0[20*e+7] = A0[Index3D(ny,nx,i,j,k+(2*e)-1)];	//D0[20*e+18] = c0;
					 D0[20*e+8] = A0[Index3D(ny,nx,i,j,k+(2*e)+1)];	D0[20*e+19] = A0[Index3D(ny,nx,i,j,k+(2*e)+1)];
				}

				kernel_5x5_stencil(D0);

				 for(e=0;e<8;e++){
					 Anext[Index3D (nx, ny, i, j-1, k+e)] = results[e];
				 }
			}
		}
}


void kernel_5x5(float *d){

	Xil_DCacheFlushRange((unsigned int)d, 80);
	Xil_Out32(CMDA_BTT, 0x0000050); 			// number of bytes to send

	while(Xil_In32(OVRL_STATUS) != 0x00000001){

	}

}

void kernel_5x5_stencil(float *d){

	uint32_t i;
	uint32_t res0, res1;


	//Xil_DCacheFlushRange((unsigned int)d, 320);
	//Xil_Out32(CMDA_BTT, 0x0000140); 			// number of bytes to send

	for(i=0;i<4;i++){

		while(Xil_In32(OVRL_STATUS) != 0x00000001){

		}

		res0 = Xil_In32(0x43c3005c);
		res1 = Xil_In32(0x43c30060);
		results[2*i]   = *(float*) &res0;
		results[2*i+1] = *(float*) &res1;

	}


}
