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


void kmeans(){

	int i;
    float random;
    int dim = 8;
    float *data;
    float *centroids_a, *centroids_b;
    int *cluster_assignment_a, *cluster_assignment_b;
    int n = 1600000;
    int c = 32;
    XTime tStart, tEnd;

    data = (float*)malloc(n*sizeof(float));
    centroids_a = (float*)malloc(c*sizeof(float));
    centroids_b = (float*)malloc(c*sizeof(float));
    cluster_assignment_a = (int*)malloc(n*sizeof(int));
    cluster_assignment_b = (int*)malloc(n*sizeof(int));

    for(i=0;i<n;i++){
    	data[i] = (float)rand()/(float)(RAND_MAX/66);
    }

    for(i=0;i<c;i++){
    	random = (float)rand()/(float)(RAND_MAX/66);
    	centroids_a[i] = random;
    	centroids_b[i] = random;
    }


	XTime_GetTime(&tStart);
	kmeans_impl(dim, data, n/dim, c/dim, centroids_a, cluster_assignment_a, "cpu");
	XTime_GetTime(&tEnd);
	printf("CPU time was %.9f s.\n",(1.0 * (tEnd - tStart) / (COUNTS_PER_SECOND/1000000))/1000000);

	usleep(50000);
	printf("\n\n\n");

	XTime_GetTime(&tStart);
	kmeans_impl(dim, data, n/dim, c/dim, centroids_b, cluster_assignment_b, "ovrl");
	XTime_GetTime(&tEnd);
	printf("Overlay time was %.9f s.\n",(1.0 * (tEnd - tStart) / (COUNTS_PER_SECOND/1000000))/1000000);


	free(data);
	free(centroids_a);
	free(centroids_b);
	free(cluster_assignment_a);
	free(cluster_assignment_b);

}
