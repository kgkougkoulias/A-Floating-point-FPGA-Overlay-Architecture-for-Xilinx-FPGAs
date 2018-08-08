set fifo_depth $::env(fifo_depth)
set data_width $::env(data_width)
set logd $::env(logd)
set name $::env(name)
set dir $::env(dir)
set part $::env(part)

create_project -in_memory -part $part -force
create_ip -name fifo_generator -vendor xilinx.com -library ip -version 13.1 -module_name $name -dir $dir/ip_source
set_property -dict [list CONFIG.Input_Data_Width $data_width CONFIG.Input_Depth $fifo_depth CONFIG.Data_Count {true} CONFIG.Output_Data_Width $data_width CONFIG.Output_Depth $fifo_depth CONFIG.Data_Count_Width $logd CONFIG.Write_Data_Count_Width $logd CONFIG.Read_Data_Count_Width $logd] [get_ips $name]
generate_target {instantiation_template} [get_files $dir/ip_source/$name/$name.xci]
generate_target all [get_files $dir/ip_source/$name/$name.xci]
synth_ip [get_files $dir/ip_source/$name/$name.xci] -force

