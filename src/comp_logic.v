//comp_logic.v
//
//
`include "config_5x5.v"
`include "floating_point_0_4cyc_sim_netlist.v"
`include "floating_point_mul0_4cyc_sim_netlist.v"
`uselib lib=secureip
`uselib lib=unifast_ver
`uselib lib=unimacro_ver
`uselib lib=unisims_ver
`uselib lib=simprims_ver
`include "glbl.v"

module comp_logic(
    /* inputs */
    d_in_c0,
    d_in_c1,
    clk,
    rst,
    conf,
    /* outputs */
    d_out,
    done
    );


parameter              TYPE = 0;

input    [`PATH_WIDTH:0] d_in_c0;
input    [`PATH_WIDTH:0] d_in_c1;
input              [3:0] conf;
input                    clk;
input                    rst;

output [`PATH_WIDTH-1:0] d_out;
output                   done;

wire  [7:0] op;

/*       ADD/SUB MODULE		*/
// if op == 0 then d_in_c0 + d_in_c1
// if op == 1 then d_in_c0 - d_in_c1
// 4 cycles latency
reg  [2:0] cnt0;	
wire done_add;
wire [`PATH_WIDTH-1:1] d_out_add;

floating_point_0_4cyc fp_add_sub(
                    // inputs
                    .aclk(clk),
                    .s_axis_a_tvalid(1'b1),
                    .s_axis_a_tdata(d_in_c0[`PATH_WIDTH:`META_BITS]),
                    .s_axis_b_tvalid(1'b1),
                    .s_axis_b_tdata(d_in_c1[`PATH_WIDTH:`META_BITS]),
                    .s_axis_operation_tvalid(1'b1),
                    .s_axis_operation_tdata(op),
                    // outputs
                    .m_axis_result_tvalid(),
                    //.m_axis_result_tdata(d_out[`PATH_WIDTH-1:1])
                    .m_axis_result_tdata(d_out_add)
                    );

// new staff for multicycle operations
always @ (posedge clk)
    begin
        cnt0 <= rst? 3'b000 :   					//reset
        (d_in_c0[0] & d_in_c1[0]) ? cnt0 + 1'b1 :	//both ready
        3'b000; 									//not ready
end

assign done_add = (cnt0 == 3'b101) ? 1'b1: 1'b0;
/*    ADD/SUB MODULE           */


/*  MUL MODULE  */
// 4 cycles latency
reg  [2:0] cnt1;
wire done_mul;
wire [`PATH_WIDTH-1:1] d_out_mul;

floating_point_mul0_4cyc fp_mult_sp(
                    // inputs
                    .aclk(clk),
                    .s_axis_a_tvalid(1'b1),
                    .s_axis_a_tdata(d_in_c0[`PATH_WIDTH:`META_BITS]),
                    .s_axis_b_tvalid(1'b1),
                    .s_axis_b_tdata(d_in_c1[`PATH_WIDTH:`META_BITS]),
                    // outputs
                    .m_axis_result_tvalid(),
                    //.m_axis_result_tdata(d_out[`PATH_WIDTH-1:1])
                    .m_axis_result_tdata(d_out_mul)
                    );	

// new staff for multicycle operations
always @ (posedge clk)
    begin
        cnt1 <= rst? 3'b000 :   					//reset
        (d_in_c0[0] & d_in_c1[0]) ? cnt1 + 1'b1 :	//both ready
        3'b000; 									//not ready
    end

assign done_mul = (cnt1 == 3'b101) ? 1'b1: 1'b0;
/*      MUL MODULE              */


/*  COMPARE MODULE     */
// 3 cycles latency
// op == 2'b10 ---> select larger
// op == 2'b01 ---> select smaller
reg [1:0] cnt2;
wire done_comp;
wire [`PATH_WIDTH-1:1] d_out_comp;

select_smaller_larger comp_module(
		/*   inputs    */
		.operand_a(d_in_c0[`PATH_WIDTH:`META_BITS]),
		.operand_b(d_in_c1[`PATH_WIDTH:`META_BITS]),
		.bos(op[1:0]),
		.rst(rst),
		.clk(clk),
		/*   outputs   */
		.result(d_out_comp)
		);

// new staff for multicycle operations
always @ (posedge clk)
    begin
        cnt2 <= rst? 2'b000 :   					//reset
        (d_in_c0[0] & d_in_c1[0]) ? cnt2 + 1'b1 :	//both ready
        2'b00; 									    //not ready
    end

assign done_comp = (cnt2 == 2'b11) ? 1'b1: 1'b0;
/*  COMPARE MODULE     */



// done when the calculation for the selected function is done
assign done = (conf[3:0] == 4'b1000) ? done_mul  :
			  (conf[3:0] == 4'b1100) ? done_comp :
			  (conf[3:0] == 4'b1110) ? done_comp :
								       done_add;

// select the output according to the function specified
assign d_out[`PATH_WIDTH-1:1] = (conf[3:0] == 4'b1000) ? d_out_mul  :
								(conf[3:0] == 4'b1100) ? d_out_comp :
								(conf[3:0] == 4'b1110) ? d_out_comp :
													     d_out_add;

// opcode of the available operations
assign op = (conf[3:0] == 4'b0000 ? 8'h00 : // d_in0 + d_in1
             conf[3:0] == 4'b0100 ? 8'h01 : // d_in0 - d_in1
             conf[3:0] == 4'b1000 ? 8'h00 : // d_in0 * d_in1
			 conf[3:0] == 4'b1100 ? 8'h01 : // min(d_in0, d_in1)
			 conf[3:0] == 4'b1110 ? 8'h02 : // max(d_in0, d_in1)
           /*conf[3:0] == 4'b1100*/ 8'h00   // default -- room for move operations 
                );

assign d_out[0] = d_in_c0[1] & d_in_c1[1];


endmodule
