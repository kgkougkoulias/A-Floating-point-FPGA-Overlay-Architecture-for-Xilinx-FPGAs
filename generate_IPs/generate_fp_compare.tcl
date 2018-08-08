set name $::env(name)
set dir $::env(dir)
set part $::env(part)
set op $::env(op)

create_project -in_memory -part $part -force
create_ip -name floating_point -vendor xilinx.com -library ip -version 7.1 -module_name $name -dir $dir/ip_source
set_property -dict [list CONFIG.Operation_Type {Compare} CONFIG.C_Compare_Operation {Less_Than_Or_Equal} CONFIG.Flow_Control {NonBlocking} CONFIG.Maximum_Latency {false} CONFIG.Has_A_TLAST {false} CONFIG.A_Precision_Type {Single} CONFIG.C_A_Exponent_Width {8} CONFIG.C_A_Fraction_Width {24} CONFIG.Result_Precision_Type {Custom} CONFIG.C_Result_Exponent_Width {1} CONFIG.C_Result_Fraction_Width {0} CONFIG.C_Accum_Msb {32} CONFIG.C_Accum_Lsb {-31} CONFIG.C_Accum_Input_Msb {32} CONFIG.C_Mult_Usage {No_Usage} CONFIG.Has_RESULT_TREADY {false} CONFIG.C_Latency {2} CONFIG.C_Rate {1} CONFIG.RESULT_TLAST_Behv {Null}] [get_ips $name]
generate_target {instantiation_template} [get_files $dir/ip_source/$name/$name.xci]
generate_target all [get_files $dir/ip_source/$name/$name.xci]
synth_ip [get_files $dir/ip_source/$name/$name.xci] -force



