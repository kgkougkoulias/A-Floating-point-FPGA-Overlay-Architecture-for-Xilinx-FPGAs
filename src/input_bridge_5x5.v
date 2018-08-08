//input_bridge.v
//
//
`include "config_5x5.v"

module input_bridge(
  /* inputs */
  d_in0,
  port0,
  wr_en0,
  // credit from core
  c_in_0,
  c_in_1,
  c_in_2,
  c_in_3,
  c_in_4,
  c_in_5,
  c_in_6,
  c_in_7,
  c_in_8,
  c_in_9,
  c_in_10,
  c_in_11,
  c_in_12,
  c_in_13,
  c_in_14,
  c_in_15,
  c_in_16,
  c_in_17,
  c_in_18,
  c_in_19,
  // --
  clk,
  rst,
  conf_en,
  /* outputs */
  // data to core
  d_out_0,
  d_out_1,
  d_out_2,
  d_out_3,
  d_out_4,
  d_out_5,
  d_out_6,
  d_out_7,
  d_out_8,
  d_out_9,
  d_out_10,
  d_out_11,
  d_out_12,
  d_out_13,
  d_out_14,
  d_out_15,
  d_out_16,
  d_out_17,
  d_out_18,
  d_out_19,
  busy0
  );

/* inputs */
input [`DATA_WIDTH:0] d_in0;
input [4:0] port0;
input  wr_en0;
input  c_in_0;
input  c_in_1;
input  c_in_2;
input  c_in_3;
input  c_in_4;
input  c_in_5;
input  c_in_6;
input  c_in_7;
input  c_in_8;
input  c_in_9;
input  c_in_10;
input  c_in_11;
input  c_in_12;
input  c_in_13;
input  c_in_14;
input  c_in_15;
input  c_in_16;
input  c_in_17;
input  c_in_18;
input  c_in_19;
input  clk;
input  rst;
input  conf_en;

/* outputs */
output [`PATH_WIDTH:0] d_out_0;
output [`PATH_WIDTH:0] d_out_1;
output [`PATH_WIDTH:0] d_out_2;
output [`PATH_WIDTH:0] d_out_3;
output [`PATH_WIDTH:0] d_out_4;
output [`PATH_WIDTH:0] d_out_5;
output [`PATH_WIDTH:0] d_out_6;
output [`PATH_WIDTH:0] d_out_7;
output [`PATH_WIDTH:0] d_out_8;
output [`PATH_WIDTH:0] d_out_9;
output [`PATH_WIDTH:0] d_out_10;
output [`PATH_WIDTH:0] d_out_11;
output [`PATH_WIDTH:0] d_out_12;
output [`PATH_WIDTH:0] d_out_13;
output [`PATH_WIDTH:0] d_out_14;
output [`PATH_WIDTH:0] d_out_15;
output [`PATH_WIDTH:0] d_out_16;
output [`PATH_WIDTH:0] d_out_17;
output [`PATH_WIDTH:0] d_out_18;
output [`PATH_WIDTH:0] d_out_19;
output  busy0;


////////////////////////////////////////////////
//
//    wires
//
////////////////////////////////////////////////

wire [19:0] write0;
wire [19:0] busy;

assign write0[0] = (port0 == 5'd0) & wr_en0;
assign write0[1] = (port0 == 5'd1) & wr_en0;
assign write0[2] = (port0 == 5'd2) & wr_en0;
assign write0[3] = (port0 == 5'd3) & wr_en0;
assign write0[4] = (port0 == 5'd4) & wr_en0;
assign write0[5] = (port0 == 5'd5) & wr_en0;
assign write0[6] = (port0 == 5'd6) & wr_en0;
assign write0[7] = (port0 == 5'd7) & wr_en0;
assign write0[8] = (port0 == 5'd8) & wr_en0;
assign write0[9] = (port0 == 5'd9) & wr_en0;
assign write0[10] = (port0 == 5'd10) & wr_en0;
assign write0[11] = (port0 == 5'd11) & wr_en0;
assign write0[12] = (port0 == 5'd12) & wr_en0;
assign write0[13] = (port0 == 5'd13) & wr_en0;
assign write0[14] = (port0 == 5'd14) & wr_en0;
assign write0[15] = (port0 == 5'd15) & wr_en0;
assign write0[16] = (port0 == 5'd16) & wr_en0;
assign write0[17] = (port0 == 5'd17) & wr_en0;
assign write0[18] = (port0 == 5'd18) & wr_en0;
assign write0[19] = (port0 == 5'd19) & wr_en0;

assign busy0 = | (busy & write0);

reg [19:0] read_en;

always @(posedge clk)
begin
  if (rst == 1'b1)
    read_en <= ~(19'b0);
  else begin
    read_en[0] <= (c_in_0 ? 1'b1 : (d_out_0[0] ? 1'b0 : read_en[0]));
    read_en[1] <= (c_in_1 ? 1'b1 : (d_out_1[0] ? 1'b0 : read_en[1]));
    read_en[2] <= (c_in_2 ? 1'b1 : (d_out_2[0] ? 1'b0 : read_en[2]));
    read_en[3] <= (c_in_3 ? 1'b1 : (d_out_3[0] ? 1'b0 : read_en[3]));
    read_en[4] <= (c_in_4 ? 1'b1 : (d_out_4[0] ? 1'b0 : read_en[4]));
    read_en[5] <= (c_in_5 ? 1'b1 : (d_out_5[0] ? 1'b0 : read_en[5]));
    read_en[6] <= (c_in_6 ? 1'b1 : (d_out_6[0] ? 1'b0 : read_en[6]));
    read_en[7] <= (c_in_7 ? 1'b1 : (d_out_7[0] ? 1'b0 : read_en[7]));
    read_en[8] <= (c_in_8 ? 1'b1 : (d_out_8[0] ? 1'b0 : read_en[8]));
    read_en[9] <= (c_in_9 ? 1'b1 : (d_out_9[0] ? 1'b0 : read_en[9]));
    read_en[10] <= (c_in_10 ? 1'b1 : (d_out_10[0] ? 1'b0 : read_en[10]));
    read_en[11] <= (c_in_11 ? 1'b1 : (d_out_11[0] ? 1'b0 : read_en[11]));
    read_en[12] <= (c_in_12 ? 1'b1 : (d_out_12[0] ? 1'b0 : read_en[12]));
    read_en[13] <= (c_in_13 ? 1'b1 : (d_out_13[0] ? 1'b0 : read_en[13]));
    read_en[14] <= (c_in_14 ? 1'b1 : (d_out_14[0] ? 1'b0 : read_en[14]));
    read_en[15] <= (c_in_15 ? 1'b1 : (d_out_15[0] ? 1'b0 : read_en[15]));
    read_en[16] <= (c_in_16 ? 1'b1 : (d_out_16[0] ? 1'b0 : read_en[16]));
    read_en[17] <= (c_in_17 ? 1'b1 : (d_out_17[0] ? 1'b0 : read_en[17]));
    read_en[18] <= (c_in_18 ? 1'b1 : (d_out_18[0] ? 1'b0 : read_en[18]));
    read_en[19] <= (c_in_19 ? 1'b1 : (d_out_19[0] ? 1'b0 : read_en[19]));
  end
end



////////////////////////////////////////////////
//
//    FIFO
//
////////////////////////////////////////////////

assign d_out_0[1] = 1'b1;
fifo #(0) f0(
  /* inputs */
  .d_in(d_in0),
  .enq(write0[0]),
  .deq(~conf_en & read_en[0]),
  .clk(clk),
  .rst(rst),
  /* outputs */
  .d_out(d_out_0[`PATH_WIDTH:`META_BITS]),
  .valid(d_out_0[0]),
  .busy(busy[0]),
  .c_out() // NC
  );

assign d_out_1[1] = 1'b1;
fifo #(1) f1(
  /* inputs */
  .d_in(d_in0),
  .enq(write0[1]),
  .deq(~conf_en & read_en[1]),
  .clk(clk),
  .rst(rst),
  /* outputs */
  .d_out(d_out_1[`PATH_WIDTH:`META_BITS]),
  .valid(d_out_1[0]),
  .busy(busy[1]),
  .c_out() // NC
  );

assign d_out_2[1] = 1'b1;
fifo #(2) f2(
  /* inputs */
  .d_in(d_in0),
  .enq(write0[2]),
  .deq(~conf_en & read_en[2]),
  .clk(clk),
  .rst(rst),
  /* outputs */
  .d_out(d_out_2[`PATH_WIDTH:`META_BITS]),
  .valid(d_out_2[0]),
  .busy(busy[2]),
  .c_out() // NC
  );

assign d_out_3[1] = 1'b1;
fifo #(3) f3(
  /* inputs */
  .d_in(d_in0),
  .enq(write0[3]),
  .deq(~conf_en & read_en[3]),
  .clk(clk),
  .rst(rst),
  /* outputs */
  .d_out(d_out_3[`PATH_WIDTH:`META_BITS]),
  .valid(d_out_3[0]),
  .busy(busy[3]),
  .c_out() // NC
  );

assign d_out_4[1] = 1'b1;
fifo #(4) f4(
  /* inputs */
  .d_in(d_in0),
  .enq(write0[4]),
  .deq(~conf_en & read_en[4]),
  .clk(clk),
  .rst(rst),
  /* outputs */
  .d_out(d_out_4[`PATH_WIDTH:`META_BITS]),
  .valid(d_out_4[0]),
  .busy(busy[4]),
  .c_out() // NC
  );

assign d_out_5[1] = 1'b1;
fifo #(5) f5(
  /* inputs */
  .d_in(d_in0),
  .enq(write0[5]),
  .deq(~conf_en & read_en[5]),
  .clk(clk),
  .rst(rst),
  /* outputs */
  .d_out(d_out_5[`PATH_WIDTH:`META_BITS]),
  .valid(d_out_5[0]),
  .busy(busy[5]),
  .c_out() // NC
  );

assign d_out_6[1] = 1'b1;
fifo #(6) f6(
  /* inputs */
  .d_in(d_in0),
  .enq(write0[6]),
  .deq(~conf_en & read_en[6]),
  .clk(clk),
  .rst(rst),
  /* outputs */
  .d_out(d_out_6[`PATH_WIDTH:`META_BITS]),
  .valid(d_out_6[0]),
  .busy(busy[6]),
  .c_out() // NC
  );

assign d_out_7[1] = 1'b1;
fifo #(7) f7(
  /* inputs */
  .d_in(d_in0),
  .enq(write0[7]),
  .deq(~conf_en & read_en[7]),
  .clk(clk),
  .rst(rst),
  /* outputs */
  .d_out(d_out_7[`PATH_WIDTH:`META_BITS]),
  .valid(d_out_7[0]),
  .busy(busy[7]),
  .c_out() // NC
  );

assign d_out_8[1] = 1'b1;
fifo #(8) f8(
  /* inputs */
  .d_in(d_in0),
  .enq(write0[8]),
  .deq(~conf_en & read_en[8]),
  .clk(clk),
  .rst(rst),
  /* outputs */
  .d_out(d_out_8[`PATH_WIDTH:`META_BITS]),
  .valid(d_out_8[0]),
  .busy(busy[8]),
  .c_out() // NC
  );

assign d_out_9[1] = 1'b1;
fifo #(9) f9(
  /* inputs */
  .d_in(d_in0),
  .enq(write0[9]),
  .deq(~conf_en & read_en[9]),
  .clk(clk),
  .rst(rst),
  /* outputs */
  .d_out(d_out_9[`PATH_WIDTH:`META_BITS]),
  .valid(d_out_9[0]),
  .busy(busy[9]),
  .c_out() // NC
  );

assign d_out_10[1] = 1'b1;
fifo #(10) f10(
  /* inputs */
  .d_in(d_in0),
  .enq(write0[10]),
  .deq(~conf_en & read_en[10]),
  .clk(clk),
  .rst(rst),
  /* outputs */
  .d_out(d_out_10[`PATH_WIDTH:`META_BITS]),
  .valid(d_out_10[0]),
  .busy(busy[10]),
  .c_out() // NC
  );

assign d_out_11[1] = 1'b1;
fifo #(11) f11(
  /* inputs */
  .d_in(d_in0),
  .enq(write0[11]),
  .deq(~conf_en & read_en[11]),
  .clk(clk),
  .rst(rst),
  /* outputs */
  .d_out(d_out_11[`PATH_WIDTH:`META_BITS]),
  .valid(d_out_11[0]),
  .busy(busy[11]),
  .c_out() // NC
  );

assign d_out_12[1] = 1'b1;
fifo #(12) f12(
  /* inputs */
  .d_in(d_in0),
  .enq(write0[12]),
  .deq(~conf_en & read_en[12]),
  .clk(clk),
  .rst(rst),
  /* outputs */
  .d_out(d_out_12[`PATH_WIDTH:`META_BITS]),
  .valid(d_out_12[0]),
  .busy(busy[12]),
  .c_out() // NC
  );

assign d_out_13[1] = 1'b1;
fifo #(13) f13(
  /* inputs */
  .d_in(d_in0),
  .enq(write0[13]),
  .deq(~conf_en & read_en[13]),
  .clk(clk),
  .rst(rst),
  /* outputs */
  .d_out(d_out_13[`PATH_WIDTH:`META_BITS]),
  .valid(d_out_13[0]),
  .busy(busy[13]),
  .c_out() // NC
  );

assign d_out_14[1] = 1'b1;
fifo #(14) f14(
  /* inputs */
  .d_in(d_in0),
  .enq(write0[14]),
  .deq(~conf_en & read_en[14]),
  .clk(clk),
  .rst(rst),
  /* outputs */
  .d_out(d_out_14[`PATH_WIDTH:`META_BITS]),
  .valid(d_out_14[0]),
  .busy(busy[14]),
  .c_out() // NC
  );

assign d_out_15[1] = 1'b1;
fifo #(15) f15(
  /* inputs */
  .d_in(d_in0),
  .enq(write0[15]),
  .deq(~conf_en & read_en[15]),
  .clk(clk),
  .rst(rst),
  /* outputs */
  .d_out(d_out_15[`PATH_WIDTH:`META_BITS]),
  .valid(d_out_15[0]),
  .busy(busy[15]),
  .c_out() // NC
  );

assign d_out_16[1] = 1'b1;
fifo #(16) f16(
  /* inputs */
  .d_in(d_in0),
  .enq(write0[16]),
  .deq(~conf_en & read_en[16]),
  .clk(clk),
  .rst(rst),
  /* outputs */
  .d_out(d_out_16[`PATH_WIDTH:`META_BITS]),
  .valid(d_out_16[0]),
  .busy(busy[16]),
  .c_out() // NC
  );

assign d_out_17[1] = 1'b1;
fifo #(17) f17(
  /* inputs */
  .d_in(d_in0),
  .enq(write0[17]),
  .deq(~conf_en & read_en[17]),
  .clk(clk),
  .rst(rst),
  /* outputs */
  .d_out(d_out_17[`PATH_WIDTH:`META_BITS]),
  .valid(d_out_17[0]),
  .busy(busy[17]),
  .c_out() // NC
  );

assign d_out_18[1] = 1'b1;
fifo #(18) f18(
  /* inputs */
  .d_in(d_in0),
  .enq(write0[18]),
  .deq(~conf_en & read_en[18]),
  .clk(clk),
  .rst(rst),
  /* outputs */
  .d_out(d_out_18[`PATH_WIDTH:`META_BITS]),
  .valid(d_out_18[0]),
  .busy(busy[18]),
  .c_out() // NC
  );

assign d_out_19[1] = 1'b1;
fifo #(19) f19(
  /* inputs */
  .d_in(d_in0),
  .enq(write0[19]),
  .deq(~conf_en & read_en[19]),
  .clk(clk),
  .rst(rst),
  /* outputs */
  .d_out(d_out_19[`PATH_WIDTH:`META_BITS]),
  .valid(d_out_19[0]),
  .busy(busy[19]),
  .c_out() // NC
  );

endmodule
