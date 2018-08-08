//output_bridge.v
//
//
`include "config_5x5.v"

module output_bridge_dual_port(
  /* inputs */
  port0,
  port1,
  rd_en0,
  rd_en1,
  // data from core
  d_in_0,
  d_in_1,
  d_in_2,
  d_in_3,
  d_in_4,
  d_in_5,
  d_in_6,
  d_in_7,
  d_in_8,
  d_in_9,
  d_in_10,
  d_in_11,
  d_in_12,
  d_in_13,
  d_in_14,
  d_in_15,
  d_in_16,
  d_in_17,
  d_in_18,
  d_in_19,
  // --
  clk,
  rst,
  conf_en,
  /* outputs */
  // credit to core
  c_out_0,
  c_out_1,
  c_out_2,
  c_out_3,
  c_out_4,
  c_out_5,
  c_out_6,
  c_out_7,
  c_out_8,
  c_out_9,
  c_out_10,
  c_out_11,
  c_out_12,
  c_out_13,
  c_out_14,
  c_out_15,
  c_out_16,
  c_out_17,
  c_out_18,
  c_out_19,
  d_out0,
  d_out1,
  done0,
  done1
  );

/* inputs */
input [4:0] port0;
input [4:0] port1;
input  rd_en0;
input  rd_en1;
input [`PATH_WIDTH:0] d_in_0;
input [`PATH_WIDTH:0] d_in_1;
input [`PATH_WIDTH:0] d_in_2;
input [`PATH_WIDTH:0] d_in_3;
input [`PATH_WIDTH:0] d_in_4;
input [`PATH_WIDTH:0] d_in_5;
input [`PATH_WIDTH:0] d_in_6;
input [`PATH_WIDTH:0] d_in_7;
input [`PATH_WIDTH:0] d_in_8;
input [`PATH_WIDTH:0] d_in_9;
input [`PATH_WIDTH:0] d_in_10;
input [`PATH_WIDTH:0] d_in_11;
input [`PATH_WIDTH:0] d_in_12;
input [`PATH_WIDTH:0] d_in_13;
input [`PATH_WIDTH:0] d_in_14;
input [`PATH_WIDTH:0] d_in_15;
input [`PATH_WIDTH:0] d_in_16;
input [`PATH_WIDTH:0] d_in_17;
input [`PATH_WIDTH:0] d_in_18;
input [`PATH_WIDTH:0] d_in_19;
input  clk;
input  rst;
input  conf_en;

/* outputs */
output  c_out_0;
output  c_out_1;
output  c_out_2;
output  c_out_3;
output  c_out_4;
output  c_out_5;
output  c_out_6;
output  c_out_7;
output  c_out_8;
output  c_out_9;
output  c_out_10;
output  c_out_11;
output  c_out_12;
output  c_out_13;
output  c_out_14;
output  c_out_15;
output  c_out_16;
output  c_out_17;
output  c_out_18;
output  c_out_19;
output [`DATA_WIDTH:0] d_out0;
output [`DATA_WIDTH:0] d_out1;
output  done0;
output  done1;


////////////////////////////////////////////////
//
//    wires
//
////////////////////////////////////////////////

wire [`DATA_WIDTH+1:0] fifo_out_0;
wire [`DATA_WIDTH+1:0] fifo_out_1;
wire [`DATA_WIDTH+1:0] fifo_out_2;
wire [`DATA_WIDTH+1:0] fifo_out_3;
wire [`DATA_WIDTH+1:0] fifo_out_4;
wire [`DATA_WIDTH+1:0] fifo_out_5;
wire [`DATA_WIDTH+1:0] fifo_out_6;
wire [`DATA_WIDTH+1:0] fifo_out_7;
wire [`DATA_WIDTH+1:0] fifo_out_8;
wire [`DATA_WIDTH+1:0] fifo_out_9;
wire [`DATA_WIDTH+1:0] fifo_out_10;
wire [`DATA_WIDTH+1:0] fifo_out_11;
wire [`DATA_WIDTH+1:0] fifo_out_12;
wire [`DATA_WIDTH+1:0] fifo_out_13;
wire [`DATA_WIDTH+1:0] fifo_out_14;
wire [`DATA_WIDTH+1:0] fifo_out_15;
wire [`DATA_WIDTH+1:0] fifo_out_16;
wire [`DATA_WIDTH+1:0] fifo_out_17;
wire [`DATA_WIDTH+1:0] fifo_out_18;
wire [`DATA_WIDTH+1:0] fifo_out_19;
wire [31:0] read0;
wire [31:0] read1;

assign read0[0] = (port0 == 5'd0) & rd_en0;
assign read0[1] = (port0 == 5'd1) & rd_en0;
assign read0[2] = (port0 == 5'd2) & rd_en0;
assign read0[3] = (port0 == 5'd3) & rd_en0;
assign read0[4] = (port0 == 5'd4) & rd_en0;
assign read0[5] = (port0 == 5'd5) & rd_en0;
assign read0[6] = (port0 == 5'd6) & rd_en0;
assign read0[7] = (port0 == 5'd7) & rd_en0;
assign read0[8] = (port0 == 5'd8) & rd_en0;
assign read0[9] = (port0 == 5'd9) & rd_en0;
assign read0[10] = (port0 == 5'd10) & rd_en0;
assign read0[11] = (port0 == 5'd11) & rd_en0;
assign read0[12] = (port0 == 5'd12) & rd_en0;
assign read0[13] = (port0 == 5'd13) & rd_en0;
assign read0[14] = (port0 == 5'd14) & rd_en0;
assign read0[15] = (port0 == 5'd15) & rd_en0;
assign read0[16] = (port0 == 5'd16) & rd_en0;
assign read0[17] = (port0 == 5'd17) & rd_en0;
assign read0[18] = (port0 == 5'd18) & rd_en0;
assign read0[19] = (port0 == 5'd19) & rd_en0;

assign read1[0] = (port1 == 5'd0) & rd_en1;
assign read1[1] = (port1 == 5'd1) & rd_en1;
assign read1[2] = (port1 == 5'd2) & rd_en1;
assign read1[3] = (port1 == 5'd3) & rd_en1;
assign read1[4] = (port1 == 5'd4) & rd_en1;
assign read1[5] = (port1 == 5'd5) & rd_en1;
assign read1[6] = (port1 == 5'd6) & rd_en1;
assign read1[7] = (port1 == 5'd7) & rd_en1;
assign read1[8] = (port1 == 5'd8) & rd_en1;
assign read1[9] = (port1 == 5'd9) & rd_en1;
assign read1[10] = (port1 == 5'd10) & rd_en1;
assign read1[11] = (port1 == 5'd11) & rd_en1;
assign read1[12] = (port1 == 5'd12) & rd_en1;
assign read1[13] = (port1 == 5'd13) & rd_en1;
assign read1[14] = (port1 == 5'd14) & rd_en1;
assign read1[15] = (port1 == 5'd15) & rd_en1;
assign read1[16] = (port1 == 5'd16) & rd_en1;
assign read1[17] = (port1 == 5'd17) & rd_en1;
assign read1[18] = (port1 == 5'd18) & rd_en1;
assign read1[19] = (port1 == 5'd19) & rd_en1;

assign d_out0 =  (port0 == 5'd0) ? fifo_out_0[`DATA_WIDTH+1:1] :
                 (port0 == 5'd1) ? fifo_out_1[`DATA_WIDTH+1:1] :
                 (port0 == 5'd2) ? fifo_out_2[`DATA_WIDTH+1:1] :
                 (port0 == 5'd3) ? fifo_out_3[`DATA_WIDTH+1:1] :
                 (port0 == 5'd4) ? fifo_out_4[`DATA_WIDTH+1:1] :
                 (port0 == 5'd5) ? fifo_out_5[`DATA_WIDTH+1:1] :
                 (port0 == 5'd6) ? fifo_out_6[`DATA_WIDTH+1:1] :
                 (port0 == 5'd7) ? fifo_out_7[`DATA_WIDTH+1:1] :
                 (port0 == 5'd8) ? fifo_out_8[`DATA_WIDTH+1:1] :
                 (port0 == 5'd9) ? fifo_out_9[`DATA_WIDTH+1:1] :
                 (port0 == 5'd10) ? fifo_out_10[`DATA_WIDTH+1:1] :
                 (port0 == 5'd11) ? fifo_out_11[`DATA_WIDTH+1:1] :
                 (port0 == 5'd12) ? fifo_out_12[`DATA_WIDTH+1:1] :
                 (port0 == 5'd13) ? fifo_out_13[`DATA_WIDTH+1:1] :
                 (port0 == 5'd14) ? fifo_out_14[`DATA_WIDTH+1:1] :
                 (port0 == 5'd15) ? fifo_out_15[`DATA_WIDTH+1:1] :
                 (port0 == 5'd16) ? fifo_out_16[`DATA_WIDTH+1:1] :
                 (port0 == 5'd17) ? fifo_out_17[`DATA_WIDTH+1:1] :
                 (port0 == 5'd18) ? fifo_out_18[`DATA_WIDTH+1:1] :
               /*(port0 == 5'd19)*/ fifo_out_19[`DATA_WIDTH+1:1];

assign d_out1 =  (port1 == 5'd0) ? fifo_out_0[`DATA_WIDTH+1:1] :
                 (port1 == 5'd1) ? fifo_out_1[`DATA_WIDTH+1:1] :
                 (port1 == 5'd2) ? fifo_out_2[`DATA_WIDTH+1:1] :
                 (port1 == 5'd3) ? fifo_out_3[`DATA_WIDTH+1:1] :
                 (port1 == 5'd4) ? fifo_out_4[`DATA_WIDTH+1:1] :
                 (port1 == 5'd5) ? fifo_out_5[`DATA_WIDTH+1:1] :
                 (port1 == 5'd6) ? fifo_out_6[`DATA_WIDTH+1:1] :
                 (port1 == 5'd7) ? fifo_out_7[`DATA_WIDTH+1:1] :
                 (port1 == 5'd8) ? fifo_out_8[`DATA_WIDTH+1:1] :
                 (port1 == 5'd9) ? fifo_out_9[`DATA_WIDTH+1:1] :
                 (port1 == 5'd10) ? fifo_out_10[`DATA_WIDTH+1:1] :
                 (port1 == 5'd11) ? fifo_out_11[`DATA_WIDTH+1:1] :
                 (port1 == 5'd12) ? fifo_out_12[`DATA_WIDTH+1:1] :
                 (port1 == 5'd13) ? fifo_out_13[`DATA_WIDTH+1:1] :
                 (port1 == 5'd14) ? fifo_out_14[`DATA_WIDTH+1:1] :
                 (port1 == 5'd15) ? fifo_out_15[`DATA_WIDTH+1:1] :
                 (port1 == 5'd16) ? fifo_out_16[`DATA_WIDTH+1:1] :
                 (port1 == 5'd17) ? fifo_out_17[`DATA_WIDTH+1:1] :
                 (port1 == 5'd18) ? fifo_out_18[`DATA_WIDTH+1:1] :
               /*(port1 == 5'd19)*/ fifo_out_19[`DATA_WIDTH+1:1];

assign done0 = (fifo_out_0[0] & read0[0]) |
               (fifo_out_1[0] & read0[1]) |
               (fifo_out_2[0] & read0[2]) |
               (fifo_out_3[0] & read0[3]) |
               (fifo_out_4[0] & read0[4]) |
               (fifo_out_5[0] & read0[5]) |
               (fifo_out_6[0] & read0[6]) |
               (fifo_out_7[0] & read0[7]) |
               (fifo_out_8[0] & read0[8]) |
               (fifo_out_9[0] & read0[9]) |
               (fifo_out_10[0] & read0[10]) |
               (fifo_out_11[0] & read0[11]) |
               (fifo_out_12[0] & read0[12]) |
               (fifo_out_13[0] & read0[13]) |
               (fifo_out_14[0] & read0[14]) |
               (fifo_out_15[0] & read0[15]) |
               (fifo_out_16[0] & read0[16]) |
               (fifo_out_17[0] & read0[17]) |
               (fifo_out_18[0] & read0[18]) |
               (fifo_out_19[0] & read0[19]);

assign done1 = (fifo_out_0[0] & read1[0]) |
               (fifo_out_1[0] & read1[1]) |
               (fifo_out_2[0] & read1[2]) |
               (fifo_out_3[0] & read1[3]) |
               (fifo_out_4[0] & read1[4]) |
               (fifo_out_5[0] & read1[5]) |
               (fifo_out_6[0] & read1[6]) |
               (fifo_out_7[0] & read1[7]) |
               (fifo_out_8[0] & read1[8]) |
               (fifo_out_9[0] & read1[9]) |
               (fifo_out_10[0] & read1[10]) |
               (fifo_out_11[0] & read1[11]) |
               (fifo_out_12[0] & read1[12]) |
               (fifo_out_13[0] & read1[13]) |
               (fifo_out_14[0] & read1[14]) |
               (fifo_out_15[0] & read1[15]) |
               (fifo_out_16[0] & read1[16]) |
               (fifo_out_17[0] & read1[17]) |
               (fifo_out_18[0] & read1[18]) |
               (fifo_out_19[0] & read1[19]);



////////////////////////////////////////////////
//
//    FIFO
//
////////////////////////////////////////////////

fifo #(0) f0(
  /* inputs */
  .d_in(d_in_0[`PATH_WIDTH:`META_BITS]),
  .enq(~conf_en & d_in_0[0]),
  .deq(read0[0] | read1[0]),
  .clk(clk),
  .rst(rst),
  /* outputs */
  .d_out(fifo_out_0[`DATA_WIDTH+1:1]),
  .valid(fifo_out_0[0]),
  .busy(), // NC
  .c_out(c_out_0)
  );

fifo #(1) f1(
  /* inputs */
  .d_in(d_in_1[`PATH_WIDTH:`META_BITS]),
  .enq(~conf_en & d_in_1[0]),
  .deq(read0[1] | read1[1]),
  .clk(clk),
  .rst(rst),
  /* outputs */
  .d_out(fifo_out_1[`DATA_WIDTH+1:1]),
  .valid(fifo_out_1[0]),
  .busy(), // NC
  .c_out(c_out_1)
  );

fifo #(2) f2(
  /* inputs */
  .d_in(d_in_2[`PATH_WIDTH:`META_BITS]),
  .enq(~conf_en & d_in_2[0]),
  .deq(read0[2] | read1[2]),
  .clk(clk),
  .rst(rst),
  /* outputs */
  .d_out(fifo_out_2[`DATA_WIDTH+1:1]),
  .valid(fifo_out_2[0]),
  .busy(), // NC
  .c_out(c_out_2)
  );

fifo #(3) f3(
  /* inputs */
  .d_in(d_in_3[`PATH_WIDTH:`META_BITS]),
  .enq(~conf_en & d_in_3[0]),
  .deq(read0[3] | read1[3]),
  .clk(clk),
  .rst(rst),
  /* outputs */
  .d_out(fifo_out_3[`DATA_WIDTH+1:1]),
  .valid(fifo_out_3[0]),
  .busy(), // NC
  .c_out(c_out_3)
  );

fifo #(4) f4(
  /* inputs */
  .d_in(d_in_4[`PATH_WIDTH:`META_BITS]),
  .enq(~conf_en & d_in_4[0]),
  .deq(read0[4] | read1[4]),
  .clk(clk),
  .rst(rst),
  /* outputs */
  .d_out(fifo_out_4[`DATA_WIDTH+1:1]),
  .valid(fifo_out_4[0]),
  .busy(), // NC
  .c_out(c_out_4)
  );

fifo #(5) f5(
  /* inputs */
  .d_in(d_in_5[`PATH_WIDTH:`META_BITS]),
  .enq(~conf_en & d_in_5[0]),
  .deq(read0[5] | read1[5]),
  .clk(clk),
  .rst(rst),
  /* outputs */
  .d_out(fifo_out_5[`DATA_WIDTH+1:1]),
  .valid(fifo_out_5[0]),
  .busy(), // NC
  .c_out(c_out_5)
  );

fifo #(6) f6(
  /* inputs */
  .d_in(d_in_6[`PATH_WIDTH:`META_BITS]),
  .enq(~conf_en & d_in_6[0]),
  .deq(read0[6] | read1[6]),
  .clk(clk),
  .rst(rst),
  /* outputs */
  .d_out(fifo_out_6[`DATA_WIDTH+1:1]),
  .valid(fifo_out_6[0]),
  .busy(), // NC
  .c_out(c_out_6)
  );

fifo #(7) f7(
  /* inputs */
  .d_in(d_in_7[`PATH_WIDTH:`META_BITS]),
  .enq(~conf_en & d_in_7[0]),
  .deq(read0[7] | read1[7]),
  .clk(clk),
  .rst(rst),
  /* outputs */
  .d_out(fifo_out_7[`DATA_WIDTH+1:1]),
  .valid(fifo_out_7[0]),
  .busy(), // NC
  .c_out(c_out_7)
  );

fifo #(8) f8(
  /* inputs */
  .d_in(d_in_8[`PATH_WIDTH:`META_BITS]),
  .enq(~conf_en & d_in_8[0]),
  .deq(read0[8] | read1[8]),
  .clk(clk),
  .rst(rst),
  /* outputs */
  .d_out(fifo_out_8[`DATA_WIDTH+1:1]),
  .valid(fifo_out_8[0]),
  .busy(), // NC
  .c_out(c_out_8)
  );

fifo #(9) f9(
  /* inputs */
  .d_in(d_in_9[`PATH_WIDTH:`META_BITS]),
  .enq(~conf_en & d_in_9[0]),
  .deq(read0[9] | read1[9]),
  .clk(clk),
  .rst(rst),
  /* outputs */
  .d_out(fifo_out_9[`DATA_WIDTH+1:1]),
  .valid(fifo_out_9[0]),
  .busy(), // NC
  .c_out(c_out_9)
  );

fifo #(10) f10(
  /* inputs */
  .d_in(d_in_10[`PATH_WIDTH:`META_BITS]),
  .enq(~conf_en & d_in_10[0]),
  .deq(read0[10] | read1[10]),
  .clk(clk),
  .rst(rst),
  /* outputs */
  .d_out(fifo_out_10[`DATA_WIDTH+1:1]),
  .valid(fifo_out_10[0]),
  .busy(), // NC
  .c_out(c_out_10)
  );

fifo #(11) f11(
  /* inputs */
  .d_in(d_in_11[`PATH_WIDTH:`META_BITS]),
  .enq(~conf_en & d_in_11[0]),
  .deq(read0[11] | read1[11]),
  .clk(clk),
  .rst(rst),
  /* outputs */
  .d_out(fifo_out_11[`DATA_WIDTH+1:1]),
  .valid(fifo_out_11[0]),
  .busy(), // NC
  .c_out(c_out_11)
  );

fifo #(12) f12(
  /* inputs */
  .d_in(d_in_12[`PATH_WIDTH:`META_BITS]),
  .enq(~conf_en & d_in_12[0]),
  .deq(read0[12] | read1[12]),
  .clk(clk),
  .rst(rst),
  /* outputs */
  .d_out(fifo_out_12[`DATA_WIDTH+1:1]),
  .valid(fifo_out_12[0]),
  .busy(), // NC
  .c_out(c_out_12)
  );

fifo #(13) f13(
  /* inputs */
  .d_in(d_in_13[`PATH_WIDTH:`META_BITS]),
  .enq(~conf_en & d_in_13[0]),
  .deq(read0[13] | read1[13]),
  .clk(clk),
  .rst(rst),
  /* outputs */
  .d_out(fifo_out_13[`DATA_WIDTH+1:1]),
  .valid(fifo_out_13[0]),
  .busy(), // NC
  .c_out(c_out_13)
  );

fifo #(14) f14(
  /* inputs */
  .d_in(d_in_14[`PATH_WIDTH:`META_BITS]),
  .enq(~conf_en & d_in_14[0]),
  .deq(read0[14] | read1[14]),
  .clk(clk),
  .rst(rst),
  /* outputs */
  .d_out(fifo_out_14[`DATA_WIDTH+1:1]),
  .valid(fifo_out_14[0]),
  .busy(), // NC
  .c_out(c_out_14)
  );

fifo #(15) f15(
  /* inputs */
  .d_in(d_in_15[`PATH_WIDTH:`META_BITS]),
  .enq(~conf_en & d_in_15[0]),
  .deq(read0[15] | read1[15]),
  .clk(clk),
  .rst(rst),
  /* outputs */
  .d_out(fifo_out_15[`DATA_WIDTH+1:1]),
  .valid(fifo_out_15[0]),
  .busy(), // NC
  .c_out(c_out_15)
  );

fifo #(16) f16(
  /* inputs */
  .d_in(d_in_16[`PATH_WIDTH:`META_BITS]),
  .enq(~conf_en & d_in_16[0]),
  .deq(read0[16] | read1[16]),
  .clk(clk),
  .rst(rst),
  /* outputs */
  .d_out(fifo_out_16[`DATA_WIDTH+1:1]),
  .valid(fifo_out_16[0]),
  .busy(), // NC
  .c_out(c_out_16)
  );

fifo #(17) f17(
  /* inputs */
  .d_in(d_in_17[`PATH_WIDTH:`META_BITS]),
  .enq(~conf_en & d_in_17[0]),
  .deq(read0[17] | read1[17]),
  .clk(clk),
  .rst(rst),
  /* outputs */
  .d_out(fifo_out_17[`DATA_WIDTH+1:1]),
  .valid(fifo_out_17[0]),
  .busy(), // NC
  .c_out(c_out_17)
  );

fifo #(18) f18(
  /* inputs */
  .d_in(d_in_18[`PATH_WIDTH:`META_BITS]),
  .enq(~conf_en & d_in_18[0]),
  .deq(read0[18] | read1[18]),
  .clk(clk),
  .rst(rst),
  /* outputs */
  .d_out(fifo_out_18[`DATA_WIDTH+1:1]),
  .valid(fifo_out_18[0]),
  .busy(), // NC
  .c_out(c_out_18)
  );

fifo #(19) f19(
  /* inputs */
  .d_in(d_in_19[`PATH_WIDTH:`META_BITS]),
  .enq(~conf_en & d_in_19[0]),
  .deq(read0[19] | read1[19]),
  .clk(clk),
  .rst(rst),
  /* outputs */
  .d_out(fifo_out_19[`DATA_WIDTH+1:1]),
  .valid(fifo_out_19[0]),
  .busy(), // NC
  .c_out(c_out_19)
  );

endmodule
