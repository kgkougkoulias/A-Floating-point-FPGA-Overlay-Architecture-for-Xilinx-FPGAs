#include <stdio.h>
#include <inttypes.h>
#include "functions.h"
#include "sleep.h"

void mm_cpu(int m, int n, int k, float alpha, float *A, int lda, float *B, int ldb, float beta, float *C, int ldc)
{
	int mm, nn, i;
	float c, a, b;

	for(mm=0;mm<m;++mm){
		for(nn=0;nn<n;++nn){
		c = 0.0f;

		for(i=0;i<k;i++){
			a = A[mm + i * lda];
			b = B[nn + i * ldb];
			c += a * b;
		}

		C[mm+nn*ldc] = C[mm+nn*ldc] *  beta + alpha * c;
		}
	}
}
