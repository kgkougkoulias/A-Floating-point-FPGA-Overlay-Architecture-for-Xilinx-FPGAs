# An-FPGA-Overlay-Architecture-for-Xilinx-FPGAs

This work combines the work of two authors [1][2] by further optimizing an architecture to be used as an FPGA overlay,
but also converts the overlay to a peripheral addressable by AXI4 buses.

As mentioned earlier the Overlay is packaged as a peripheral that can be accessed by two AXI4 intefaces(a lite and a full). A
script is provided that will generate the Xilinx IPs for your particular device (FP units and FIFOs). 

After than you can package the resulting XCI files with the Verilog ones, which will give an 5x5 Overlay that can be programmed to
execute different DFGs.

By packaging you will be enabled to infer more than one instances of the Overlay, so the 5x5 size is not a constaint for that 
reason. Also it makes it easier to route global signals(as CLK, RST etc) that would otherwise would have been a problem with
a bigger grid size.

Programming has to be done manually at this point meaning
 - You have to draw the DFG on the 5x5 fabric
 - Program each tile by hand with the help of the C program
 - At the end you run the script, which will give the programming sequence

The Overlay is not limited to just floating point calculations, it was just used for that purpose during the work. It can be
extended to include more DSP units that can take care of integer operations.

This is fully functional design that can be reconfigured in 11us, and was test on a real FPGA.

For more details you can read the Thesis below, although this version is slightly improved as it includes BRAM FIFOs(that greatly
include available buffering while reducing resource usage) and an FP comparator. 

[1] Venkatraman Govindaraju ; Chen-Han Ho ; Tony Nowatzki DySER et al: Unifying Functionality and Parallelism Specialization for Energy-Efficient Computing, IEEE Micro, 10 July 2012 
[2] A. K. Jain and al: Adapting the DySER Architecture with DSP Blocks as an Overlay for the Xilinx Zynq, in International Symposium on Highly-Efficient Accelerators and Reconfigurable Technologies(HEART2015), Boston, MA, June 2015.
