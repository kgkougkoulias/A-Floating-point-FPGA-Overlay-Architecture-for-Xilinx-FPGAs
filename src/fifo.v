//fifo.v
//
//
//
`include "config_5x5.v"
//`include "fifo_generator_64depth_32bits_sim_netlist.v"

module fifo(
    /* inputs */
    d_in,
    enq,
    deq,
    clk,
    rst,
    /* outputs */
    d_out,
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
output                     valid;
output                     busy;
output                     c_out; // specific to the output_bridge-core interface


wire   [5:0]	count;
wire   [31:0]   dout_in;
wire   full;
wire   empty;
wire   almost_full;

assign busy = full & enq & ~deq;
assign almost_full = (count <= 6'b111110) ? 1 : 0;
assign c_out = almost_full & ~full;
assign valid = (~empty | enq) & deq; 				
assign d_out = (enq & deq & empty ? d_in : dout_in); // bypassing

fifo_generator_64depth_32bits hard_fifo( 
			.clk(clk),
			.srst(rst),
			.din(d_in),
			.wr_en(enq & ~deq),
			.rd_en(deq),
			.dout(dout_in),
			.full(full),
			.empty(empty),
			.data_count(count)
			);


endmodule
