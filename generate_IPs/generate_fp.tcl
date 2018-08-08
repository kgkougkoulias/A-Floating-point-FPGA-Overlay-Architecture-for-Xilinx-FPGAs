set name $::env(name)
set dir $::env(dir)
set part $::env(part)
set op $::env(op)

create_project -in_memory -part $part -force
create_ip -name floating_point -vendor xilinx.com -library ip -version 7.1 -module_name $name -dir $dir/ip_source
set_property -dict [list CONFIG.Operation_Type $op CONFIG.C_Optimization {Speed_Optimized} CONFIG.Flow_Control {NonBlocking} CONFIG.Maximum_Latency {false} CONFIG.C_Latency {4} CONFIG.A_Precision_Type {Single} CONFIG.C_A_Exponent_Width {8} CONFIG.C_A_Fraction_Width {24} CONFIG.Result_Precision_Type {Single} CONFIG.C_Result_Exponent_Width {8} CONFIG.C_Result_Fraction_Width {24} CONFIG.C_Accum_Msb {32} CONFIG.C_Accum_Lsb {-31} CONFIG.C_Accum_Input_Msb {32} CONFIG.C_Mult_Usage {Full_Usage} CONFIG.Has_RESULT_TREADY {false} CONFIG.C_Rate {1}] [get_ips $name]
generate_target {instantiation_template} [get_files $dir/ip_source/$name/$name.xci]
generate_target all [get_files $dir/ip_source/$name/$name.xci]
synth_ip [get_files $dir/ip_source/$name/$name.xci] -force

