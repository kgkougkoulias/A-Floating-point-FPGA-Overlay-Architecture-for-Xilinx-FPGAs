//edge_fabric.v
//
//
`include "config_5x5.v"

module edge_fabric(
  /* inputs */
  // data from input bridge
  d_in_i0,
  d_in_i1,
  d_in_i2,
  d_in_i3,
  d_in_i4,
  d_in_i5,
  d_in_i6,
  d_in_i7,
  d_in_i8,
  d_in_i9,
  d_in_i10,
  d_in_i11,
  d_in_i12,
  d_in_i13,
  d_in_i14,
  d_in_i15,
  d_in_i16,
  d_in_i17,
  d_in_i18,
  d_in_i19,
  // data from tile fabric
  d_in_t0,
  d_in_t1,
  d_in_t2,
  d_in_t3,
  d_in_t4,
  d_in_t5,
  d_in_t6,
  d_in_t7,
  d_in_t8,
  d_in_t9,
  // credit from output bridge
  c_in_o0,
  c_in_o1,
  // credit from tile fabric
  c_in_t0,
  c_in_t1,
  c_in_t2,
  c_in_t3,
  c_in_t4,
  c_in_t5,
  c_in_t6,
  c_in_t7,
  c_in_t8,
  c_in_t9,
  c_in_t10,
  c_in_t11,
  c_in_t12,
  c_in_t13,
  c_in_t14,
  c_in_t15,
  c_in_t16,
  c_in_t17,
  c_in_t18,
  c_in_t19,
  c_in_t20,
  c_in_t21,
  c_in_t22,
  c_in_t23,
  c_in_t24,
  c_in_t25,
  c_in_t26,
  c_in_t27,
  c_in_t28,
  // --
  clk,
  rst,
  conf_en,
  /* outputs */
  // data to tile fabric
  d_out_t0,
  d_out_t1,
  d_out_t2,
  d_out_t3,
  d_out_t4,
  d_out_t5,
  d_out_t6,
  d_out_t7,
  d_out_t8,
  d_out_t9,
  d_out_t10,
  d_out_t11,
  d_out_t12,
  d_out_t13,
  d_out_t14,
  d_out_t15,
  d_out_t16,
  d_out_t17,
  d_out_t18,
  d_out_t19,
  d_out_t20,
  d_out_t21,
  d_out_t22,
  d_out_t23,
  d_out_t24,
  d_out_t25,
  d_out_t26,
  d_out_t27,
  d_out_t28,
  // data to core output bridge
  d_out_o0,
  d_out_o1,
  // credit to tile fabric
  c_out_t0,
  c_out_t1,
  c_out_t2,
  c_out_t3,
  c_out_t4,
  c_out_t5,
  c_out_t6,
  c_out_t7,
  c_out_t8,
  c_out_t9,
  // credit to input bridge
  c_out_i0,
  c_out_i1,
  c_out_i2,
  c_out_i3,
  c_out_i4,
  c_out_i5,
  c_out_i6,
  c_out_i7,
  c_out_i8,
  c_out_i9,
  c_out_i10,
  c_out_i11,
  c_out_i12,
  c_out_i13,
  c_out_i14,
  c_out_i15,
  c_out_i16,
  c_out_i17,
  c_out_i18,
  c_out_i19
  );

/* inputs */
input [`PATH_WIDTH:0] d_in_i0;
input [`PATH_WIDTH:0] d_in_i1;
input [`PATH_WIDTH:0] d_in_i2;
input [`PATH_WIDTH:0] d_in_i3;
input [`PATH_WIDTH:0] d_in_i4;
input [`PATH_WIDTH:0] d_in_i5;
input [`PATH_WIDTH:0] d_in_i6;
input [`PATH_WIDTH:0] d_in_i7;
input [`PATH_WIDTH:0] d_in_i8;
input [`PATH_WIDTH:0] d_in_i9;
input [`PATH_WIDTH:0] d_in_i10;
input [`PATH_WIDTH:0] d_in_i11;
input [`PATH_WIDTH:0] d_in_i12;
input [`PATH_WIDTH:0] d_in_i13;
input [`PATH_WIDTH:0] d_in_i14;
input [`PATH_WIDTH:0] d_in_i15;
input [`PATH_WIDTH:0] d_in_i16;
input [`PATH_WIDTH:0] d_in_i17;
input [`PATH_WIDTH:0] d_in_i18;
input [`PATH_WIDTH:0] d_in_i19;
input [`PATH_WIDTH:0] d_in_t0;
input [`PATH_WIDTH:0] d_in_t1;
input [`PATH_WIDTH:0] d_in_t2;
input [`PATH_WIDTH:0] d_in_t3;
input [`PATH_WIDTH:0] d_in_t4;
input [`PATH_WIDTH:0] d_in_t5;
input [`PATH_WIDTH:0] d_in_t6;
input [`PATH_WIDTH:0] d_in_t7;
input [`PATH_WIDTH:0] d_in_t8;
input [`PATH_WIDTH:0] d_in_t9;
input  c_in_o0;
input  c_in_o1;
input  c_in_t0;
input  c_in_t1;
input  c_in_t2;
input  c_in_t3;
input  c_in_t4;
input  c_in_t5;
input  c_in_t6;
input  c_in_t7;
input  c_in_t8;
input  c_in_t9;
input  c_in_t10;
input  c_in_t11;
input  c_in_t12;
input  c_in_t13;
input  c_in_t14;
input  c_in_t15;
input  c_in_t16;
input  c_in_t17;
input  c_in_t18;
input  c_in_t19;
input  c_in_t20;
input  c_in_t21;
input  c_in_t22;
input  c_in_t23;
input  c_in_t24;
input  c_in_t25;
input  c_in_t26;
input  c_in_t27;
input  c_in_t28;
input  clk;
input  rst;
input  conf_en;

/* outputs */
output [`PATH_WIDTH:0] d_out_t0;
output [`PATH_WIDTH:0] d_out_t1;
output [`PATH_WIDTH:0] d_out_t2;
output [`PATH_WIDTH:0] d_out_t3;
output [`PATH_WIDTH:0] d_out_t4;
output [`PATH_WIDTH:0] d_out_t5;
output [`PATH_WIDTH:0] d_out_t6;
output [`PATH_WIDTH:0] d_out_t7;
output [`PATH_WIDTH:0] d_out_t8;
output [`PATH_WIDTH:0] d_out_t9;
output [`PATH_WIDTH:0] d_out_t10;
output [`PATH_WIDTH:0] d_out_t11;
output [`PATH_WIDTH:0] d_out_t12;
output [`PATH_WIDTH:0] d_out_t13;
output [`PATH_WIDTH:0] d_out_t14;
output [`PATH_WIDTH:0] d_out_t15;
output [`PATH_WIDTH:0] d_out_t16;
output [`PATH_WIDTH:0] d_out_t17;
output [`PATH_WIDTH:0] d_out_t18;
output [`PATH_WIDTH:0] d_out_t19;
output [`PATH_WIDTH:0] d_out_t20;
output [`PATH_WIDTH:0] d_out_t21;
output [`PATH_WIDTH:0] d_out_t22;
output [`PATH_WIDTH:0] d_out_t23;
output [`PATH_WIDTH:0] d_out_t24;
output [`PATH_WIDTH:0] d_out_t25;
output [`PATH_WIDTH:0] d_out_t26;
output [`PATH_WIDTH:0] d_out_t27;
output [`PATH_WIDTH:0] d_out_t28;
output [`PATH_WIDTH:0] d_out_o0;
output [`PATH_WIDTH:0] d_out_o1;
output  c_out_t0;
output  c_out_t1;
output  c_out_t2;
output  c_out_t3;
output  c_out_t4;
output  c_out_t5;
output  c_out_t6;
output  c_out_t7;
output  c_out_t8;
output  c_out_t9;
output  c_out_i0;
output  c_out_i1;
output  c_out_i2;
output  c_out_i3;
output  c_out_i4;
output  c_out_i5;
output  c_out_i6;
output  c_out_i7;
output  c_out_i8;
output  c_out_i9;
output  c_out_i10;
output  c_out_i11;
output  c_out_i12;
output  c_out_i13;
output  c_out_i14;
output  c_out_i15;
output  c_out_i16;
output  c_out_i17;
output  c_out_i18;
output  c_out_i19;

////////////////////////////////////////////////
//
//    wires and switches
//
////////////////////////////////////////////////

/* switch 0 wires */
wire [`PATH_WIDTH:0] d_0_1, d_1_0, d_0_9, d_9_0;
wire c_0_1, c_1_0, c_0_9, c_9_0;

switch #(100, 1, 1, 3) s0(
  /* inputs */
  .d_in_NW(d_in_i11),
  .d_in_N({`PATH_BITS{1'b0}}),
  .d_in_E(d_1_0),
  .d_in_S(d_9_0),
  .d_in_W(d_in_i10),
  
  .c_in_NW(1'b0),
  .c_in_N(1'b0),
  .c_in_NE(1'b0),
  .c_in_E(c_1_0),
  .c_in_SE(c_in_t0),
  .c_in_S(c_9_0),
  .c_in_SW(1'b0),
  .c_in_W(1'b0),
  .clk(clk),
  .rst(rst),
  .conf_en(conf_en),
  /* outputs */
  .d_out_NW(),
  .d_out_N(),
  .d_out_NE(),
  .d_out_E(d_0_1),
  .d_out_SE(d_out_t0),
  .d_out_S(d_0_9),
  .d_out_SW(),
  .d_out_W(),
  
  .c_out_NW(c_out_i11),
  .c_out_N(),
  .c_out_E(c_0_1),
  .c_out_S(c_0_9),
  .c_out_W(c_out_i10),
  .fu_conf()
  );

/* switch 1 wires */
wire [`PATH_WIDTH:0] d_1_2, d_2_1;
wire c_1_2, c_2_1;

switch #(101, 1, 1, 3) s1(
  /* inputs */
  .d_in_NW(d_in_i12),
  .d_in_N(d_in_i13),
  .d_in_E(d_2_1),
  .d_in_S(d_in_t0),
  .d_in_W(d_0_1),
  
  .c_in_NW(1'b0),
  .c_in_N(1'b0),
  .c_in_NE(1'b0),
  .c_in_E(c_2_1),
  .c_in_SE(c_in_t3),
  .c_in_S(c_in_t2),
  .c_in_SW(c_in_t1),
  .c_in_W(c_0_1),
  .clk(clk),
  .rst(rst),
  .conf_en(conf_en),
  /* outputs */
  .d_out_NW(),
  .d_out_N(),
  .d_out_NE(),
  .d_out_E(d_1_2),
  .d_out_SE(d_out_t3),
  .d_out_S(d_out_t2),
  .d_out_SW(d_out_t1),
  .d_out_W(d_1_0),
  
  .c_out_NW(c_out_i12),
  .c_out_N(c_out_i13),
  .c_out_E(c_1_2),
  .c_out_S(c_out_t0),
  .c_out_W(c_1_0),
  .fu_conf()
  );

/* switch 2 wires */
wire [`PATH_WIDTH:0] d_2_3, d_3_2;
wire c_2_3, c_3_2;

switch #(102, 1, 1, 3) s2(
  /* inputs */
  .d_in_NW(d_in_i14),
  .d_in_N(d_in_i15),
  .d_in_E(d_3_2),
  .d_in_S(d_in_t1),
  .d_in_W(d_1_2),
  
  .c_in_NW(1'b0),
  .c_in_N(1'b0),
  .c_in_NE(1'b0),
  .c_in_E(c_3_2),
  .c_in_SE(c_in_t6),
  .c_in_S(c_in_t5),
  .c_in_SW(c_in_t4),
  .c_in_W(c_1_2),
  .clk(clk),
  .rst(rst),
  .conf_en(conf_en),
  /* outputs */
  .d_out_NW(),
  .d_out_N(),
  .d_out_NE(),
  .d_out_E(d_2_3),
  .d_out_SE(d_out_t6),
  .d_out_S(d_out_t5),
  .d_out_SW(d_out_t4),
  .d_out_W(d_2_1),
  
  .c_out_NW(c_out_i14),
  .c_out_N(c_out_i15),
  .c_out_E(c_2_3),
  .c_out_S(c_out_t1),
  .c_out_W(c_2_1),
  .fu_conf()
  );

/* switch 3 wires */
wire [`PATH_WIDTH:0] d_3_4, d_4_3;
wire c_3_4, c_4_3;

switch #(103, 1, 1, 3) s3(
  /* inputs */
  .d_in_NW(d_in_i16),
  .d_in_N(d_in_i17),
  .d_in_E(d_4_3),
  .d_in_S(d_in_t2),
  .d_in_W(d_2_3),
  
  .c_in_NW(1'b0),
  .c_in_N(1'b0),
  .c_in_NE(1'b0),
  .c_in_E(c_4_3),
  .c_in_SE(c_in_t9),
  .c_in_S(c_in_t8),
  .c_in_SW(c_in_t7),
  .c_in_W(c_2_3),
  .clk(clk),
  .rst(rst),
  .conf_en(conf_en),
  /* outputs */
  .d_out_NW(),
  .d_out_N(),
  .d_out_NE(),
  .d_out_E(d_3_4),
  .d_out_SE(d_out_t9),
  .d_out_S(d_out_t8),
  .d_out_SW(d_out_t7),
  .d_out_W(d_3_2),
  
  .c_out_NW(c_out_i16),
  .c_out_N(c_out_i17),
  .c_out_E(c_3_4),
  .c_out_S(c_out_t2),
  .c_out_W(c_3_2),
  .fu_conf()
  );

/* switch 4 wires */
wire [`PATH_WIDTH:0] d_4_5, d_5_4;
wire c_4_5, c_5_4;

switch #(104, 1, 1, 3) s4(
  /* inputs */
  .d_in_NW(d_in_i18),
  .d_in_N(d_in_i19),
  .d_in_E(d_5_4),
  .d_in_S(d_in_t3),
  .d_in_W(d_3_4),
  
  .c_in_NW(1'b0),
  .c_in_N(1'b0),
  .c_in_NE(1'b0),
  .c_in_E(c_5_4),
  .c_in_SE(c_in_t12),
  .c_in_S(c_in_t11),
  .c_in_SW(c_in_t10),
  .c_in_W(c_3_4),
  .clk(clk),
  .rst(rst),
  .conf_en(conf_en),
  /* outputs */
  .d_out_NW(),
  .d_out_N(),
  .d_out_NE(),
  .d_out_E(d_4_5),
  .d_out_SE(d_out_t12),
  .d_out_S(d_out_t11),
  .d_out_SW(d_out_t10),
  .d_out_W(d_4_3),
  
  .c_out_NW(c_out_i18),
  .c_out_N(c_out_i19),
  .c_out_E(c_4_5),
  .c_out_S(c_out_t3),
  .c_out_W(c_4_3),
  .fu_conf()
  );

/* switch 5 wires */
wire [`PATH_WIDTH:0] d_5_6, d_6_5;
wire c_5_6, c_6_5;

switch #(105, 1, 2, 3) s5(
  /* inputs */
  .d_in_NW({`PATH_BITS{1'b0}}),
  .d_in_N({`PATH_BITS{1'b0}}),
  .d_in_E(),
  .d_in_S(d_in_t4),
  .d_in_W(d_4_5),
  
  .c_in_NW(1'b0),
  .c_in_N(1'b0),
  .c_in_NE(1'b0),
  .c_in_E(c_in_o1),
  .c_in_SE(c_in_o0),
  .c_in_S(c_in_t14),
  .c_in_SW(c_in_t13),
  .c_in_W(c_4_5),
  .clk(clk),
  .rst(rst),
  .conf_en(conf_en),
  /* outputs */
  .d_out_NW(),
  .d_out_N(),
  .d_out_NE(),
  .d_out_E(d_out_o1),
  .d_out_SE(d_out_o0),
  .d_out_S(d_out_t14),
  .d_out_SW(d_out_t13),
  .d_out_W(d_5_4),
  
  .c_out_NW(),
  .c_out_N(),
  .c_out_E(c_5_6),
  .c_out_S(c_out_t4),
  .c_out_W(c_5_4),
  .fu_conf()
  );

/* switch 9 wires */
wire [`PATH_WIDTH:0] d_9_10, d_10_9;
wire c_9_10, c_10_9;

switch #(109, 1, 2, 1) s9(
  /* inputs */
  .d_in_NW(d_in_i9),
  .d_in_N(d_0_9),
  .d_in_E(d_in_t5),
  .d_in_S(d_10_9),
  .d_in_W(d_in_i8),
  
  .c_in_NW(1'b0),
  .c_in_N(c_0_9),
  .c_in_NE(c_in_t15),
  .c_in_E(c_in_t16),
  .c_in_SE(c_in_t17),
  .c_in_S(c_10_9),
  .c_in_SW(1'b0),
  .c_in_W(1'b0),
  .clk(clk),
  .rst(rst),
  .conf_en(conf_en),
  /* outputs */
  .d_out_NW(),
  .d_out_N(d_9_0),
  .d_out_NE(d_out_t15),
  .d_out_E(d_out_t16),
  .d_out_SE(d_out_t17),
  .d_out_S(d_9_10),
  .d_out_SW(),
  .d_out_W(),
  
  .c_out_NW(c_out_i9),
  .c_out_N(c_9_0),
  .c_out_E(c_out_t5),
  .c_out_S(c_9_10),
  .c_out_W(c_out_i8),
  .fu_conf()
  );

/* switch 10 wires */
wire [`PATH_WIDTH:0] d_10_11, d_11_10;
wire c_10_11, c_11_10;

switch #(110, 1, 1, 0) s10(
  /* inputs */
  .d_in_NW(d_in_i7),
  .d_in_N(d_9_10),
  .d_in_E(d_in_t6),
  .d_in_S(d_11_10),
  .d_in_W(d_in_i6),
  
  .c_in_NW(1'b0),
  .c_in_N(c_9_10),
  .c_in_NE(c_in_t18),
  .c_in_E(c_in_t19),
  .c_in_SE(c_in_t20),
  .c_in_S(c_11_10),
  .c_in_SW(1'b0),
  .c_in_W(1'b0),
  .clk(clk),
  .rst(rst),
  .conf_en(conf_en),
  /* outputs */
  .d_out_NW(),
  .d_out_N(d_10_9),
  .d_out_NE(d_out_t18),
  .d_out_E(d_out_t19),
  .d_out_SE(d_out_t20),
  .d_out_S(d_10_11),
  .d_out_SW(),
  .d_out_W(),
  
  .c_out_NW(c_out_i7),
  .c_out_N(c_10_9),
  .c_out_E(c_out_t6),
  .c_out_S(c_10_11),
  .c_out_W(c_out_i6),
  .fu_conf()
  );

/* switch 11 wires */
wire [`PATH_WIDTH:0] d_11_12, d_12_11;
wire c_11_12, c_12_11;

switch #(111, 1, 2, 1) s11(
  /* inputs */
  .d_in_NW(d_in_i5),
  .d_in_N(d_10_11),
  .d_in_E(d_in_t7),
  .d_in_S(d_12_11),
  .d_in_W(d_in_i4),
  
  .c_in_NW(1'b0),
  .c_in_N(c_10_11),
  .c_in_NE(c_in_t21),
  .c_in_E(c_in_t22),
  .c_in_SE(c_in_t23),
  .c_in_S(c_12_11),
  .c_in_SW(1'b0),
  .c_in_W(1'b0),
  .clk(clk),
  .rst(rst),
  .conf_en(conf_en),
  /* outputs */
  .d_out_NW(),
  .d_out_N(d_11_10),
  .d_out_NE(d_out_t21),
  .d_out_E(d_out_t22),
  .d_out_SE(d_out_t23),
  .d_out_S(d_11_12),
  .d_out_SW(),
  .d_out_W(),
  
  .c_out_NW(c_out_i5),
  .c_out_N(c_11_10),
  .c_out_E(c_out_t7),
  .c_out_S(c_11_12),
  .c_out_W(c_out_i4),
  .fu_conf()
  );

/* switch 12 wires */
wire [`PATH_WIDTH:0] d_12_13, d_13_12;
wire c_12_13, c_13_12;

switch #(112, 1, 1, 0) s12(
  /* inputs */
  .d_in_NW(d_in_i3),
  .d_in_N(d_11_12),
  .d_in_E(d_in_t8),
  .d_in_S(d_13_12),
  .d_in_W(d_in_i2),
  
  .c_in_NW(1'b0),
  .c_in_N(c_11_12),
  .c_in_NE(c_in_t24),
  .c_in_E(c_in_t25),
  .c_in_SE(c_in_t26),
  .c_in_S(c_13_12),
  .c_in_SW(1'b0),
  .c_in_W(1'b0),
  .clk(clk),
  .rst(rst),
  .conf_en(conf_en),
  /* outputs */
  .d_out_NW(),
  .d_out_N(d_12_11),
  .d_out_NE(d_out_t24),
  .d_out_E(d_out_t25),
  .d_out_SE(d_out_t26),
  .d_out_S(d_12_13),
  .d_out_SW(),
  .d_out_W(),
  
  .c_out_NW(c_out_i3),
  .c_out_N(c_12_11),
  .c_out_E(c_out_t8),
  .c_out_S(c_12_13),
  .c_out_W(c_out_i2),
  .fu_conf()
  );

/* switch 13 wires */
wire [`PATH_WIDTH:0] d_13_14, d_14_13;
wire c_13_14, c_14_13;

switch #(113, 1, 3, 1) s13(
  /* inputs */
  .d_in_NW(d_in_i1),
  .d_in_N(d_12_13),
  .d_in_E(d_in_t9),
  .d_in_S(d_14_13),
  .d_in_W(d_in_i0),
  
  .c_in_NW(1'b0),
  .c_in_N(c_12_13),
  .c_in_NE(c_in_t27),
  .c_in_E(c_in_t28),
  .c_in_SE(1'b0),
  .c_in_S(1'b0),
  .c_in_SW(1'b0),
  .c_in_W(1'b0),
  .clk(clk),
  .rst(rst),
  .conf_en(conf_en),
  /* outputs */
  .d_out_NW(),
  .d_out_N(d_13_12),
  .d_out_NE(d_out_t27),
  .d_out_E(d_out_t28),
  .d_out_SE(),
  .d_out_S(),
  .d_out_SW(),
  .d_out_W(),
  
  .c_out_NW(c_out_i1),
  .c_out_N(c_13_12),
  .c_out_E(c_out_t9),
  .c_out_S(),
  .c_out_W(c_out_i0),
  .fu_conf()
  );

endmodule
