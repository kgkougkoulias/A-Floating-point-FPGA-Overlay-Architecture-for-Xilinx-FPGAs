# An-FPGA-Overlay-Architecture-for-Xilinx-FPGAs

This work combines the work of two authors [1][2] by further optimizing an architecture to be used as an FPGA overlay,
but also converts the overlay to a peripheral addressable through a number of AXI4 buses.

As mentioned earlier the Overlay is packaged as a peripheral that can be accessed by two AXI4 intefaces(a lite and a full). A
script is provided that will generate the Xilinx IPs for your particular device (FP units and FIFOs). 

After than you can package the resulting XCI files with the Verilog ones, which will give an 5x5 Overlay that can be programmed to
execute different DFGs.

By packaging you will be enabled to infer more than one instances of the Overlay, so the 5x5 size is not a hard constraint for 
that reason. Also it makes it easier to route global signals(as CLK, RST etc) that would otherwise would have been a problem with
a bigger grid sizes.

Programming has to be done manually at this point meaning
 - You have to draw the DFG on the 5x5 fabric
 - Program each tile by hand with the help of the C program
 - At the end you run the script, which will give the programming sequence

This is a fully functional and reconfigurable design that can be reconfigured in 11us, and was tested on a real FPGA. The
Overlay is not limited to just floating point calculations, it was just used for that purpose during the work. It can be extended 
to include more DSP units that can take care of integer operations.

For more details you can read the Thesis below, although this version is slightly improved as it includes BRAM FIFOs(that greatly
increase available buffering while reducing resource usage) and an FP comparator.

--------------------------------------------------------------------------------------------------------------------------

USAGE:

In order to use the Overlay for your FPGA you need to package it as an IP, using Vivado. To do this
1) Navigate to generate_IPs folder
2) Execute the bash script as ./create_ips_script.sh $PART_CODE (you need to export Vivado executable path first)
3) In the src folder two folders will be created
    - One called xci that contains the out-of-context P&R IPs that can be used to package the overlay as an IP
    - One called sim_ip_files that contains the files that are needed in order to simulate the IPs that are contained in the Overlay
4) In order to package the IP, you have to take the files located in xci, axi and in the src root and package them
with the help of Vivado


[1] Venkatraman Govindaraju ; Chen-Han Ho ; Tony Nowatzki DySER et al: Unifying Functionality and Parallelism Specialization for Energy-Efficient Computing, IEEE Micro, 10 July 2012 

[2] A. K. Jain and al: Adapting the DySER Architecture with DSP Blocks as an Overlay for the Xilinx Zynq, in International Symposium on Highly-Efficient Accelerators and Reconfigurable Technologies(HEART2015), Boston, MA, June 2015.

If you have any problem or you need some help my contact information is:
                     gkougkouliak@yahoo.com
