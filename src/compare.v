`include "floating_point_lessthanorequal_2cyc_sim_netlist.v"

module select_smaller_larger(
		/*   inputs    */
		operand_a,
		operand_b,
		bos,
		rst,
		clk,
		/*   outputs   */
		result
		);


input [31:0] operand_a;
input [31:0] operand_b;
input [1:0]  bos;
input rst;
input clk;

output [31:0] result;

wire [7:0]  answer;
wire [31:0] larger;
wire [31:0] smaller;


assign larger  = (answer[0])  ? operand_b : operand_a;
assign smaller = (~answer[0]) ? operand_b : operand_a;
assign result  = (bos == 2'b10) ? larger :
		 (bos == 2'b01) ? smaller:
			    32'h0000_0000;


floating_point_lessthanorequal_2cyc comp(
	.aclk(clk),
    	.s_axis_a_tvalid(1'b1),
    	.s_axis_a_tdata(operand_a),
    	.s_axis_b_tvalid(1'b1),
    	.s_axis_b_tdata(operand_b),
    	.m_axis_result_tvalid(),
    	.m_axis_result_tdata(answer)
);


endmodule
