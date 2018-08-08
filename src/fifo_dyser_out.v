//fifo.v
//
//
//
`include "config_5x5.v"
//`include "fifo_generator_512depth_32bits_sim_netlist.v"

module fifo_dyser_out(
    /* inputs */
    d_in,
    enq,
    deq,
    clk,
    rst,
    /* outputs */
    d_out,
    empty,
    valid,
    busy,
    c_out
    );


parameter                  ID = 0;

input      [`DATA_WIDTH:0] d_in;
input                      enq;
input                      deq;
input                      clk;
input                      rst;

output     [`DATA_WIDTH:0] d_out;
output                     empty;
output                     valid;
output                     busy;
output                     c_out; // specific to the output_bridge-core interface


wire     [8:0] count;
wire     [31:0] dout_in;
wire     full;
wire     empty_in;
wire     almost_full;

assign busy = full & enq & ~deq;
assign almost_full = (count <= 9'b111111110) ? 1 : 0;
assign c_out = almost_full & ~full;
assign valid = (~empty_in | enq) & deq;
assign d_out = (enq & deq & empty_in ? d_in : dout_in); // bypassing
assign empty = empty_in;

fifo_generator_512depth_32bits hard_fifo_large( 
			.clk(clk),
			.srst(rst),
			.din(d_in),
			.wr_en(enq & ~deq),
			.rd_en(deq),
			.dout(dout_in),
			.full(full),
			.empty(empty_in),
			.data_count(count)
			);


endmodule
