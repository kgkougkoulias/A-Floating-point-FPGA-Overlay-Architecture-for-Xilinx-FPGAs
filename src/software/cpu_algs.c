#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <inttypes.h>
#include "drivers_v2.h"
#include "functions.h"

void cpu_algorithms(char *alg){

	if(strcmp(alg,"mm") == 0){
		mm_v2();
	}
	else if(strcmp(alg,"kmeans") == 0){
		kmeans();
	}else if(strcmp(alg,"stencil") == 0){
		stencil();
	}else if(strcmp(alg,"conv") == 0){
		conv();
	}


}
