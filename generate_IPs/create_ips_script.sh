#!/bin/bash
log(){ local x=$1 n=2 l=-1;if [ "$2" != "" ];then n=$x;x=$2;fi;while((x));do let l+=1 x/=n;done;echo $l; } 

if [[ $# -eq 0 ]] ; then
	echo ""
	echo 'Wrong number of arguments'
	echo 'Usage: ./create_ips PART_CODE (code of the device that is going to be used)'
	echo 'For example for the PYNQ board the part code is xc7z020clg400-1'
	echo ""
	exit 0
fi

if [ ! -d "$dir"/ip_source ]; then
	mkdir ip_source
	mkdir ../src/xci
	mkdir ../src/sim_ip_files
fi

#export part='xc7z020clg400-1'
#export part='xc7z030sbv485-3'

##############################################################
# create FIFOs where results of overlay calculations are saved
##############################################################
export fifo_depth=512
export data_width=32
export name="fifo_generator_"$fifo_depth"depth_"$data_width"bits"
export logd=$(log $fifo_depth)
#export runs='fifo_generator_4096depth_32bits_synth_1'
#export logd=12
export dir=$(pwd)

vivado -mode batch -source generate_fifo_ip.tcl
cp /"$dir"/ip_source/"$name"/"$name"_sim_netlist.v ../src/sim_ip_files/"$name"_sim_netlist.v
cp /"$dir"/ip_source/"$name"/"$name".xci ../src/xci/"$name".xci

#######################################################################
# create FIFOs that are used to buffer data that is coming from the bus 
# and is going to be used for calculating the outputs
#######################################################################
export fifo_depth=64
export data_width=32
export name="fifo_generator_"$fifo_depth"depth_"$data_width"bits"
export logd=$(log $fifo_depth)
export dir=$(pwd)

vivado -mode batch -source generate_fifo_ip.tcl
cp /"$dir"/ip_source/"$name"/"$name"_sim_netlist.v ../src/sim_ip_files/"$name"_sim_netlist.v
cp /"$dir"/ip_source/"$name"/"$name".xci ../src/xci/"$name".xci

##########################################################################
#
# create floating point units that are going to be used on the design
#
##########################################################################

#generate adder/substractor
export name='floating_point_0_4cyc'
export dir=$(pwd)
export op='Add_Subtract'

vivado -mode batch -source generate_fp.tcl
cp /"$dir"/ip_source/"$name"/"$name"_sim_netlist.v ../src/sim_ip_files/"$name"_sim_netlist.v
cp /"$dir"/ip_source/"$name"/"$name".xci ../src/xci/"$name".xci

#generate multiplier
export name='floating_point_mul0_4cyc'
export dir=$(pwd)
export op='Multiply'

vivado -mode batch -source generate_fp.tcl
cp /"$dir"/ip_source/"$name"/"$name"_sim_netlist.v ../src/sim_ip_files/"$name"_sim_netlist.v
cp /"$dir"/ip_source/"$name"/"$name".xci ../src/xci/"$name".xci

#generate comparator
export name='floating_point_lessthanorequal_2cyc'
export dir=$(pwd)

vivado -mode batch -source generate_fp_compare.tcl
cp /"$dir"/ip_source/"$name"/"$name"_sim_netlist.v ../src/sim_ip_files/"$name"_sim_netlist.v
cp /"$dir"/ip_source/"$name"/"$name".xci ../src/xci/"$name".xci


#remove vivado logs
rm *.jou
rm *.log

