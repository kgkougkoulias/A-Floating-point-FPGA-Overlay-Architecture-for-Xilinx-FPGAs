#include <stdio.h>
#include <inttypes.h>
#include <string.h>
#include "platform.h"
#include "xil_printf.h"
#include "xil_io.h"
#include "xtime_l.h"
#include "drivers_v2.h"
#include "sleep.h"
#include "xil_cache.h"

void program_cdma(uint32_t source, uint32_t destination){

    Xil_Out32(CDMA_CONTROL, 0x00000004); 	// reset
    Xil_Out32(CDMA_CONTROL, 0x00000000); 	// set interrupt etc
    Xil_Out32(CDMA_SOURCE, source);  		// source
    Xil_Out32(CDMA_DEST, destination);		// destination

}
