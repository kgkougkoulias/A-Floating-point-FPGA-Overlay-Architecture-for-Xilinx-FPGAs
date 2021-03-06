//tile_fabric.v
//
//
`include "config_5x5.v"

module tile_fabric(
  /* inputs */
  // data from edge fabric
  d_in_e0,
  d_in_e1,
  d_in_e2,
  d_in_e3,
  d_in_e4,
  d_in_e5,
  d_in_e6,
  d_in_e7,
  d_in_e8,
  d_in_e9,
  d_in_e10,
  d_in_e11,
  d_in_e12,
  d_in_e13,
  d_in_e14,
  d_in_e15,
  d_in_e16,
  d_in_e17,
  d_in_e18,
  d_in_e19,
  d_in_e20,
  d_in_e21,
  d_in_e22,
  d_in_e23,
  d_in_e24,
  d_in_e25,
  d_in_e26,
  d_in_e27,
  d_in_e28,
  // credit from output bridge
  c_in_o0,
  c_in_o1,
  c_in_o2,
  c_in_o3,
  c_in_o4,
  c_in_o5,
  c_in_o6,
  c_in_o7,
  c_in_o8,
  c_in_o9,
  c_in_o10,
  c_in_o11,
  c_in_o12,
  c_in_o13,
  c_in_o14,
  c_in_o15,
  c_in_o16,
  c_in_o17,
  // credit from edge fabric
  c_in_e0,
  c_in_e1,
  c_in_e2,
  c_in_e3,
  c_in_e4,
  c_in_e5,
  c_in_e6,
  c_in_e7,
  c_in_e8,
  c_in_e9,
  // --
  clk,
  rst,
  conf_en,
  /* outputs */
  // data to edge fabric
  d_out_e0,
  d_out_e1,
  d_out_e2,
  d_out_e3,
  d_out_e4,
  d_out_e5,
  d_out_e6,
  d_out_e7,
  d_out_e8,
  d_out_e9,
  // data to core output bridge
  d_out_o0,
  d_out_o1,
  d_out_o2,
  d_out_o3,
  d_out_o4,
  d_out_o5,
  d_out_o6,
  d_out_o7,
  d_out_o8,
  d_out_o9,
  d_out_o10,
  d_out_o11,
  d_out_o12,
  d_out_o13,
  d_out_o14,
  d_out_o15,
  d_out_o16,
  d_out_o17,
  // credit to edge fabric
  c_out_e0,
  c_out_e1,
  c_out_e2,
  c_out_e3,
  c_out_e4,
  c_out_e5,
  c_out_e6,
  c_out_e7,
  c_out_e8,
  c_out_e9,
  c_out_e10,
  c_out_e11,
  c_out_e12,
  c_out_e13,
  c_out_e14,
  c_out_e15,
  c_out_e16,
  c_out_e17,
  c_out_e18,
  c_out_e19,
  c_out_e20,
  c_out_e21,
  c_out_e22,
  c_out_e23,
  c_out_e24,
  c_out_e25,
  c_out_e26,
  c_out_e27,
  c_out_e28
  );

/* inputs */
input [`PATH_WIDTH:0] d_in_e0;
input [`PATH_WIDTH:0] d_in_e1;
input [`PATH_WIDTH:0] d_in_e2;
input [`PATH_WIDTH:0] d_in_e3;
input [`PATH_WIDTH:0] d_in_e4;
input [`PATH_WIDTH:0] d_in_e5;
input [`PATH_WIDTH:0] d_in_e6;
input [`PATH_WIDTH:0] d_in_e7;
input [`PATH_WIDTH:0] d_in_e8;
input [`PATH_WIDTH:0] d_in_e9;
input [`PATH_WIDTH:0] d_in_e10;
input [`PATH_WIDTH:0] d_in_e11;
input [`PATH_WIDTH:0] d_in_e12;
input [`PATH_WIDTH:0] d_in_e13;
input [`PATH_WIDTH:0] d_in_e14;
input [`PATH_WIDTH:0] d_in_e15;
input [`PATH_WIDTH:0] d_in_e16;
input [`PATH_WIDTH:0] d_in_e17;
input [`PATH_WIDTH:0] d_in_e18;
input [`PATH_WIDTH:0] d_in_e19;
input [`PATH_WIDTH:0] d_in_e20;
input [`PATH_WIDTH:0] d_in_e21;
input [`PATH_WIDTH:0] d_in_e22;
input [`PATH_WIDTH:0] d_in_e23;
input [`PATH_WIDTH:0] d_in_e24;
input [`PATH_WIDTH:0] d_in_e25;
input [`PATH_WIDTH:0] d_in_e26;
input [`PATH_WIDTH:0] d_in_e27;
input [`PATH_WIDTH:0] d_in_e28;
input  c_in_o0;
input  c_in_o1;
input  c_in_o2;
input  c_in_o3;
input  c_in_o4;
input  c_in_o5;
input  c_in_o6;
input  c_in_o7;
input  c_in_o8;
input  c_in_o9;
input  c_in_o10;
input  c_in_o11;
input  c_in_o12;
input  c_in_o13;
input  c_in_o14;
input  c_in_o15;
input  c_in_o16;
input  c_in_o17;
input  c_in_e0;
input  c_in_e1;
input  c_in_e2;
input  c_in_e3;
input  c_in_e4;
input  c_in_e5;
input  c_in_e6;
input  c_in_e7;
input  c_in_e8;
input  c_in_e9;
input  clk;
input  rst;
input  conf_en;

/* outputs */
output [`PATH_WIDTH:0] d_out_e0;
output [`PATH_WIDTH:0] d_out_e1;
output [`PATH_WIDTH:0] d_out_e2;
output [`PATH_WIDTH:0] d_out_e3;
output [`PATH_WIDTH:0] d_out_e4;
output [`PATH_WIDTH:0] d_out_e5;
output [`PATH_WIDTH:0] d_out_e6;
output [`PATH_WIDTH:0] d_out_e7;
output [`PATH_WIDTH:0] d_out_e8;
output [`PATH_WIDTH:0] d_out_e9;
output [`PATH_WIDTH:0] d_out_o0;
output [`PATH_WIDTH:0] d_out_o1;
output [`PATH_WIDTH:0] d_out_o2;
output [`PATH_WIDTH:0] d_out_o3;
output [`PATH_WIDTH:0] d_out_o4;
output [`PATH_WIDTH:0] d_out_o5;
output [`PATH_WIDTH:0] d_out_o6;
output [`PATH_WIDTH:0] d_out_o7;
output [`PATH_WIDTH:0] d_out_o8;
output [`PATH_WIDTH:0] d_out_o9;
output [`PATH_WIDTH:0] d_out_o10;
output [`PATH_WIDTH:0] d_out_o11;
output [`PATH_WIDTH:0] d_out_o12;
output [`PATH_WIDTH:0] d_out_o13;
output [`PATH_WIDTH:0] d_out_o14;
output [`PATH_WIDTH:0] d_out_o15;
output [`PATH_WIDTH:0] d_out_o16;
output [`PATH_WIDTH:0] d_out_o17;
output  c_out_e0;
output  c_out_e1;
output  c_out_e2;
output  c_out_e3;
output  c_out_e4;
output  c_out_e5;
output  c_out_e6;
output  c_out_e7;
output  c_out_e8;
output  c_out_e9;
output  c_out_e10;
output  c_out_e11;
output  c_out_e12;
output  c_out_e13;
output  c_out_e14;
output  c_out_e15;
output  c_out_e16;
output  c_out_e17;
output  c_out_e18;
output  c_out_e19;
output  c_out_e20;
output  c_out_e21;
output  c_out_e22;
output  c_out_e23;
output  c_out_e24;
output  c_out_e25;
output  c_out_e26;
output  c_out_e27;
output  c_out_e28;

////////////////////////////////////////////////
//
//    tiles and wires
//
////////////////////////////////////////////////

/* tile 0 output wires (data and credit lines) */
wire [`PATH_WIDTH:0] d_0_1, d_o_0_1, d_0_9, d_0_8, d_o_0_8;
wire c_o_0_8, c_o_0_1;
/* tile 0 input wires (credit and data lines) */
wire c_1_0, c_o_1_0, c_9_0, c_8_0, c_o_8_0;
wire [`PATH_WIDTH:0] d_o_8_0, d_o_1_0;

tile #(0, 0, 3, 1) t0(
  /* inputs */
  .d_in_f_NW(d_in_e0),
  .d_in_f_NE(d_in_e1),
  .d_in_f_SW(d_in_e15),
  .d_in_s_N(d_in_e2),
  .d_in_s_E(d_o_1_0),
  .d_in_s_S(d_o_8_0),
  .d_in_s_W(d_in_e16),

  .c_in_s_N(c_in_e0),
  .c_in_s_NE(c_1_0),
  .c_in_s_E(c_o_1_0),
  .c_in_s_SE(c_9_0),
  .c_in_s_S(c_o_8_0),
  .c_in_s_SW(c_8_0),
  .c_in_s_W(c_in_e5),
  .clk(clk),
  .rst(rst),
  .conf_en(conf_en),
  /* outputs */
  .d_out_s_N(d_out_e0),
  .d_out_s_NE(d_0_1),
  .d_out_s_E(d_o_0_1),
  .d_out_s_SE(d_0_9),
  .d_out_s_S(d_o_0_8),
  .d_out_s_SW(d_0_8),
  .d_out_s_W(d_out_e5),

  .c_out_f_NW(c_out_e0),
  .c_out_f_NE(c_out_e1),
  .c_out_f_SW(c_out_e15),
  .c_out_s_N(c_out_e2),
  .c_out_s_E(c_o_0_1),
  .c_out_s_S(c_o_0_8),
  .c_out_s_W(c_out_e16)
  );

/* tile 1 output wires (data and credit lines) */
wire [`PATH_WIDTH:0] d_1_2, d_o_1_2, d_1_10, d_1_9, d_o_1_9;
wire c_o_1_9, c_o_1_2;
/* tile 1 input wires (credit and data lines) */
wire c_2_1, c_o_2_1, c_10_1, c_9_1, c_o_9_1;
wire [`PATH_WIDTH:0] d_o_9_1, d_o_2_1;

tile #(1, 1, 3, 1) t1(
  /* inputs */
  .d_in_f_NW(d_in_e3),
  .d_in_f_NE(d_in_e4),
  .d_in_f_SW(d_0_1),
  .d_in_s_N(d_in_e5),
  .d_in_s_E(d_o_2_1),
  .d_in_s_S(d_o_9_1),
  .d_in_s_W(d_o_0_1),

  .c_in_s_N(c_in_e1),
  .c_in_s_NE(c_2_1),
  .c_in_s_E(c_o_2_1),
  .c_in_s_SE(c_10_1),
  .c_in_s_S(c_o_9_1),
  .c_in_s_SW(c_9_1),
  .c_in_s_W(c_o_0_1),
  .clk(clk),
  .rst(rst),
  .conf_en(conf_en),
  /* outputs */
  .d_out_s_N(d_out_e1),
  .d_out_s_NE(d_1_2),
  .d_out_s_E(d_o_1_2),
  .d_out_s_SE(d_1_10),
  .d_out_s_S(d_o_1_9),
  .d_out_s_SW(d_1_9),
  .d_out_s_W(d_o_1_0),

  .c_out_f_NW(c_out_e3),
  .c_out_f_NE(c_out_e4),
  .c_out_f_SW(c_1_0),
  .c_out_s_N(c_out_e5),
  .c_out_s_E(c_o_1_2),
  .c_out_s_S(c_o_1_9),
  .c_out_s_W(c_o_1_0)
  );

/* tile 2 output wires (data and credit lines) */
wire [`PATH_WIDTH:0] d_2_3, d_o_2_3, d_2_11, d_2_10, d_o_2_10;
wire c_o_2_10, c_o_2_3;
/* tile 2 input wires (credit and data lines) */
wire c_3_2, c_o_3_2, c_11_2, c_10_2, c_o_10_2;
wire [`PATH_WIDTH:0] d_o_10_2, d_o_3_2;

tile #(2, 0, 3, 1) t2(
  /* inputs */
  .d_in_f_NW(d_in_e6),
  .d_in_f_NE(d_in_e7),
  .d_in_f_SW(d_1_2),
  .d_in_s_N(d_in_e8),
  .d_in_s_E(d_o_3_2),
  .d_in_s_S(d_o_10_2),
  .d_in_s_W(d_o_1_2),
  .c_in_s_N(c_in_e2),
  .c_in_s_NE(c_3_2),
  .c_in_s_E(c_o_3_2),
  .c_in_s_SE(c_11_2),
  .c_in_s_S(c_o_10_2),
  .c_in_s_SW(c_10_2),
  .c_in_s_W(c_o_1_2),
  .clk(clk),
  .rst(rst),
  .conf_en(conf_en),
  /* outputs */
  .d_out_s_N(d_out_e2),
  .d_out_s_NE(d_2_3),
  .d_out_s_E(d_o_2_3),
  .d_out_s_SE(d_2_11),
  .d_out_s_S(d_o_2_10),
  .d_out_s_SW(d_2_10),
  .d_out_s_W(d_o_2_1),
  .c_out_f_NW(c_out_e6),
  .c_out_f_NE(c_out_e7),
  .c_out_f_SW(c_2_1),
  .c_out_s_N(c_out_e8),
  .c_out_s_E(c_o_2_3),
  .c_out_s_S(c_o_2_10),
  .c_out_s_W(c_o_2_1)
  );

/* tile 3 output wires (data and credit lines) */
wire [`PATH_WIDTH:0] d_3_4, d_o_3_4, d_3_12, d_3_11, d_o_3_11;
wire c_o_3_11, c_o_3_4;
/* tile 3 input wires (credit and data lines) */
wire c_4_3, c_o_4_3, c_12_3, c_11_3, c_o_11_3;
wire [`PATH_WIDTH:0] d_o_11_3, d_o_4_3;

tile #(3, 0, 3, 1) t3(
  /* inputs */
  .d_in_f_NW(d_in_e9),
  .d_in_f_NE(d_in_e10),
  .d_in_f_SW(d_2_3),
  .d_in_s_N(d_in_e11),
  .d_in_s_E(d_o_4_3),
  .d_in_s_S(d_o_11_3),
  .d_in_s_W(d_o_2_3),
  .c_in_s_N(c_in_e3),
  .c_in_s_NE(c_4_3),
  .c_in_s_E(c_o_4_3),
  .c_in_s_SE(c_12_3),
  .c_in_s_S(c_o_11_3),
  .c_in_s_SW(c_11_3),
  .c_in_s_W(c_o_2_3),
  .clk(clk),
  .rst(rst),
  .conf_en(conf_en),
  /* outputs */
  .d_out_s_N(d_out_e3),
  .d_out_s_NE(d_3_4),
  .d_out_s_E(d_o_3_4),
  .d_out_s_SE(d_3_12),
  .d_out_s_S(d_o_3_11),
  .d_out_s_SW(d_3_11),
  .d_out_s_W(d_o_3_2),
  .c_out_f_NW(c_out_e9),
  .c_out_f_NE(c_out_e10),
  .c_out_f_SW(c_3_2),
  .c_out_s_N(c_out_e11),
  .c_out_s_E(c_o_3_4),
  .c_out_s_S(c_o_3_11),
  .c_out_s_W(c_o_3_2)
  );

/* tile 4 output wires (data and credit lines) */
wire [`PATH_WIDTH:0] d_4_5, d_o_4_5, d_4_13, d_4_12, d_o_4_12;
wire c_o_4_12, c_o_4_5;
/* tile 4 input wires (credit and data lines) */
wire c_5_4, c_o_5_4, c_13_4, c_12_4, c_o_12_4;
wire [`PATH_WIDTH:0] d_o_12_4, d_o_5_4;

tile #(4, 0, 3, 0) t4(
  /* inputs */
  .d_in_f_NW(d_in_e12),
  .d_in_f_NE(d_in_e13),
  .d_in_f_SW(d_3_4),
  .d_in_s_N(d_in_e14),
  .d_in_s_E(d_o_5_4),
  .d_in_s_S(d_o_12_4),
  .d_in_s_W(d_o_3_4),
  
  .c_in_s_N(c_in_e4),
  .c_in_s_NE(),
  .c_in_s_E(c_in_o17),
  .c_in_s_SE(c_in_o16),
  .c_in_s_S(c_o_12_4),
  .c_in_s_SW(c_12_4),
  .c_in_s_W(c_o_3_4),
  .clk(clk),
  .rst(rst),
  .conf_en(conf_en),
  /* outputs */
  .d_out_s_N(d_out_e4),
  .d_out_s_NE(),
  .d_out_s_E(d_out_o17),
  .d_out_s_SE(d_out_o16),
  .d_out_s_S(d_o_4_12),
  .d_out_s_SW(d_4_12),
  .d_out_s_W(d_o_4_3),
  
  .c_out_f_NW(c_out_e12),
  .c_out_f_NE(c_out_e13),
  .c_out_f_SW(c_4_3),
  .c_out_s_N(c_out_e14),
  .c_out_s_E(),
  .c_out_s_S(c_o_4_12),
  .c_out_s_W(c_o_4_3)
  );


/* tile 8 output wires (data and credit lines) */
wire [`PATH_WIDTH:0] d_8_9, d_o_8_9, d_8_17, d_8_16, d_o_8_16;
wire c_o_8_16, c_o_8_9;
/* tile 8 input wires (credit and data lines) */
wire c_9_8, c_o_9_8, c_17_8, c_16_8, c_o_16_8;
wire [`PATH_WIDTH:0] d_o_16_8, d_o_9_8;

tile #(8, 0, 1, 3) t8(
  /* inputs */
  .d_in_f_NW(d_in_e17),
  .d_in_f_NE(d_0_8),
  .d_in_f_SW(d_in_e18),
  .d_in_s_N(d_o_0_8),
  .d_in_s_E(d_o_9_8),
  .d_in_s_S(d_o_16_8),
  .d_in_s_W(d_in_e19),

  .c_in_s_N(c_o_0_8),
  .c_in_s_NE(c_9_8),
  .c_in_s_E(c_o_9_8),
  .c_in_s_SE(c_17_8),
  .c_in_s_S(c_o_16_8),
  .c_in_s_SW(c_16_8),
  .c_in_s_W(c_in_e6),
  .clk(clk),
  .rst(rst),
  .conf_en(conf_en),
  /* outputs */
  .d_out_s_N(d_o_8_0),
  .d_out_s_NE(d_8_9),
  .d_out_s_E(d_o_8_9),
  .d_out_s_SE(d_8_17),
  .d_out_s_S(d_o_8_16),
  .d_out_s_SW(d_8_16),
  .d_out_s_W(d_out_e6),

  .c_out_f_NW(c_out_e17),
  .c_out_f_NE(c_8_0),
  .c_out_f_SW(c_out_e18),
  .c_out_s_N(c_o_8_0),
  .c_out_s_E(c_o_8_9),
  .c_out_s_S(c_o_8_16),
  .c_out_s_W(c_out_e19)
  );

/* tile 9 output wires (data and credit lines) */
wire [`PATH_WIDTH:0] d_9_10, d_o_9_10, d_9_18, d_9_17, d_o_9_17;
wire c_o_9_17, c_o_9_10;
/* tile 9 input wires (credit and data lines) */
wire c_10_9, c_o_10_9, c_18_9, c_17_9, c_o_17_9;
wire [`PATH_WIDTH:0] d_o_17_9, d_o_10_9;

tile #(9, 1, 1, 3) t9(
  /* inputs */
  .d_in_f_NW(d_0_9),
  .d_in_f_NE(d_1_9),
  .d_in_f_SW(d_8_9),
  .d_in_s_N(d_o_1_9),
  .d_in_s_E(d_o_10_9),
  .d_in_s_S(d_o_17_9),
  .d_in_s_W(d_o_8_9),

  .c_in_s_N(c_o_1_9),
  .c_in_s_NE(c_10_9),
  .c_in_s_E(c_o_10_9),
  .c_in_s_SE(c_18_9),
  .c_in_s_S(c_o_17_9),
  .c_in_s_SW(c_17_9),
  .c_in_s_W(c_o_8_9),
  .clk(clk),
  .rst(rst),
  .conf_en(conf_en),
  /* outputs */
  .d_out_s_N(d_o_9_1),
  .d_out_s_NE(d_9_10),
  .d_out_s_E(d_o_9_10),
  .d_out_s_SE(d_9_18),
  .d_out_s_S(d_o_9_17),
  .d_out_s_SW(d_9_17),
  .d_out_s_W(d_o_9_8),

  .c_out_f_NW(c_9_0),
  .c_out_f_NE(c_9_1),
  .c_out_f_SW(c_9_8),
  .c_out_s_N(c_o_9_1),
  .c_out_s_E(c_o_9_10),
  .c_out_s_S(c_o_9_17),
  .c_out_s_W(c_o_9_8)
  );

/* tile 10 output wires (data and credit lines) */
wire [`PATH_WIDTH:0] d_10_11, d_o_10_11, d_10_19, d_10_18, d_o_10_18;
wire c_o_10_18, c_o_10_11;
/* tile 10 input wires (credit and data lines) */
wire c_11_10, c_o_11_10, c_19_10, c_18_10, c_o_18_10;
wire [`PATH_WIDTH:0] d_o_18_10, d_o_11_10;

tile #(10, 1, 1, 3) t10(
  /* inputs */
  .d_in_f_NW(d_1_10),
  .d_in_f_NE(d_2_10),
  .d_in_f_SW(d_9_10),
  .d_in_s_N(d_o_2_10),
  .d_in_s_E(d_o_11_10),
  .d_in_s_S(d_o_18_10),
  .d_in_s_W(d_o_9_10),
  .c_in_s_N(c_o_2_10),
  .c_in_s_NE(c_11_10),
  .c_in_s_E(c_o_11_10),
  .c_in_s_SE(c_19_10),
  .c_in_s_S(c_o_18_10),
  .c_in_s_SW(c_18_10),
  .c_in_s_W(c_o_9_10),
  .clk(clk),
  .rst(rst),
  .conf_en(conf_en),
  /* outputs */
  .d_out_s_N(d_o_10_2),
  .d_out_s_NE(d_10_11),
  .d_out_s_E(d_o_10_11),
  .d_out_s_SE(d_10_19),
  .d_out_s_S(d_o_10_18),
  .d_out_s_SW(d_10_18),
  .d_out_s_W(d_o_10_9),
  .c_out_f_NW(c_10_1),
  .c_out_f_NE(c_10_2),
  .c_out_f_SW(c_10_9),
  .c_out_s_N(c_o_10_2),
  .c_out_s_E(c_o_10_11),
  .c_out_s_S(c_o_10_18),
  .c_out_s_W(c_o_10_9)
  );

/* tile 11 output wires (data and credit lines) */
wire [`PATH_WIDTH:0] d_11_12, d_o_11_12, d_11_20, d_11_19, d_o_11_19;
wire c_o_11_19, c_o_11_12;
/* tile 11 input wires (credit and data lines) */
wire c_12_11, c_o_12_11, c_20_11, c_19_11, c_o_19_11;
wire [`PATH_WIDTH:0] d_o_19_11, d_o_12_11;

tile #(11, 1, 1, 3) t11(
  /* inputs */
  .d_in_f_NW(d_2_11),
  .d_in_f_NE(d_3_11),
  .d_in_f_SW(d_10_11),
  .d_in_s_N(d_o_3_11),
  .d_in_s_E(d_o_12_11),
  .d_in_s_S(d_o_19_11),
  .d_in_s_W(d_o_10_11),
  .c_in_s_N(c_o_3_11),
  .c_in_s_NE(c_12_11),
  .c_in_s_E(c_o_12_11),
  .c_in_s_SE(c_20_11),
  .c_in_s_S(c_o_19_11),
  .c_in_s_SW(c_19_11),
  .c_in_s_W(c_o_10_11),
  .clk(clk),
  .rst(rst),
  .conf_en(conf_en),
  /* outputs */
  .d_out_s_N(d_o_11_3),
  .d_out_s_NE(d_11_12),
  .d_out_s_E(d_o_11_12),
  .d_out_s_SE(d_11_20),
  .d_out_s_S(d_o_11_19),
  .d_out_s_SW(d_11_19),
  .d_out_s_W(d_o_11_10),
  .c_out_f_NW(c_11_2),
  .c_out_f_NE(c_11_3),
  .c_out_f_SW(c_11_10),
  .c_out_s_N(c_o_11_3),
  .c_out_s_E(c_o_11_12),
  .c_out_s_S(c_o_11_19),
  .c_out_s_W(c_o_11_10)
  );

/* tile 12 output wires (data and credit lines) */
wire [`PATH_WIDTH:0] d_12_13, d_o_12_13, d_12_21, d_12_20, d_o_12_20;
wire c_o_12_20, c_o_12_13;
/* tile 12 input wires (credit and data lines) */
wire c_13_12, c_o_13_12, c_21_12, c_20_12, c_o_20_12;
wire [`PATH_WIDTH:0] d_o_20_12, d_o_13_12;

tile #(12, 1, 2, 3) t12(
  /* inputs */
  .d_in_f_NW(d_3_12),
  .d_in_f_NE(d_4_12),
  .d_in_f_SW(d_11_12),
  .d_in_s_N(d_o_4_12),
  .d_in_s_E(d_o_13_12),
  .d_in_s_S(d_o_20_12),
  .d_in_s_W(d_o_11_12),
  
  .c_in_s_N(c_o_4_12),
  .c_in_s_NE(),
  .c_in_s_E(c_in_o15),
  .c_in_s_SE(c_in_o14),
  .c_in_s_S(c_o_20_12),
  .c_in_s_SW(c_20_12),
  .c_in_s_W(c_o_11_12),
  .clk(clk),
  .rst(rst),
  .conf_en(conf_en),
  /* outputs */
  .d_out_s_N(d_o_12_4),
  .d_out_s_NE(),
  .d_out_s_E(d_out_o15),
  .d_out_s_SE(d_out_o14),
  .d_out_s_S(d_o_12_20),
  .d_out_s_SW(d_12_20),
  .d_out_s_W(d_o_12_11),
  
  .c_out_f_NW(c_12_3),
  .c_out_f_NE(c_12_4),
  .c_out_f_SW(c_12_11),
  .c_out_s_N(c_o_12_4),
  .c_out_s_E(),
  .c_out_s_S(c_o_12_20),
  .c_out_s_W(c_o_12_11)
  );

/* tile 16 output wires (data and credit lines) */
wire [`PATH_WIDTH:0] d_16_17, d_o_16_17, d_16_25, d_16_24, d_o_16_24;
wire c_o_16_24, c_o_16_17;
/* tile 16 input wires (credit and data lines) */
wire c_17_16, c_o_17_16, c_25_16, c_24_16, c_o_24_16;
wire [`PATH_WIDTH:0] d_o_24_16, d_o_17_16;

tile #(16, 0, 3, 1) t16(
  /* inputs */
  .d_in_f_NW(d_in_e20),
  .d_in_f_NE(d_8_16),
  .d_in_f_SW(d_in_e21),
  .d_in_s_N(d_o_8_16),
  .d_in_s_E(d_o_17_16),
  .d_in_s_S(d_o_24_16),
  .d_in_s_W(d_in_e22),
  
  .c_in_s_N(c_o_8_16),
  .c_in_s_NE(c_17_16),
  .c_in_s_E(c_o_17_16),
  .c_in_s_SE(c_25_16),
  .c_in_s_S(c_o_24_16),
  .c_in_s_SW(c_24_16),
  .c_in_s_W(c_in_e7),
  .clk(clk),
  .rst(rst),
  .conf_en(conf_en),
  /* outputs */
  .d_out_s_N(d_o_16_8),
  .d_out_s_NE(d_16_17),
  .d_out_s_E(d_o_16_17),
  .d_out_s_SE(d_16_25),
  .d_out_s_S(d_o_16_24),
  .d_out_s_SW(d_16_24),
  .d_out_s_W(d_out_e7),
  
  .c_out_f_NW(c_out_e20),
  .c_out_f_NE(c_16_8),
  .c_out_f_SW(c_out_e21),
  .c_out_s_N(c_o_16_8),
  .c_out_s_E(c_o_16_17),
  .c_out_s_S(c_o_16_24),
  .c_out_s_W(c_out_e22)
  );

/* tile 17 output wires (data and credit lines) */
wire [`PATH_WIDTH:0] d_17_18, d_o_17_18, d_17_26, d_17_25, d_o_17_25;
wire c_o_17_25, c_o_17_18;
/* tile 17 input wires (credit and data lines) */
wire c_18_17, c_o_18_17, c_26_17, c_25_17, c_o_25_17;
wire [`PATH_WIDTH:0] d_o_25_17, d_o_18_17;

tile #(17, 1, 3, 1) t17(
  /* inputs */
  .d_in_f_NW(d_8_17),
  .d_in_f_NE(d_9_17),
  .d_in_f_SW(d_16_17),
  .d_in_s_N(d_o_9_17),
  .d_in_s_E(d_o_18_17),
  .d_in_s_S(d_o_25_17),
  .d_in_s_W(d_o_16_17),
  .c_in_s_N(c_o_9_17),
  .c_in_s_NE(c_18_17),
  .c_in_s_E(c_o_18_17),
  .c_in_s_SE(c_26_17),
  .c_in_s_S(c_o_25_17),
  .c_in_s_SW(c_25_17),
  .c_in_s_W(c_o_16_17),
  .clk(clk),
  .rst(rst),
  .conf_en(conf_en),
  /* outputs */
  .d_out_s_N(d_o_17_9),
  .d_out_s_NE(d_17_18),
  .d_out_s_E(d_o_17_18),
  .d_out_s_SE(d_17_26),
  .d_out_s_S(d_o_17_25),
  .d_out_s_SW(d_17_25),
  .d_out_s_W(d_o_17_16),
  .c_out_f_NW(c_17_8),
  .c_out_f_NE(c_17_9),
  .c_out_f_SW(c_17_16),
  .c_out_s_N(c_o_17_9),
  .c_out_s_E(c_o_17_18),
  .c_out_s_S(c_o_17_25),
  .c_out_s_W(c_o_17_16)
  );

/* tile 18 output wires (data and credit lines) */
wire [`PATH_WIDTH:0] d_18_19, d_o_18_19, d_18_27, d_18_26, d_o_18_26;
wire c_o_18_26, c_o_18_19;
/* tile 18 input wires (credit and data lines) */
wire c_19_18, c_o_19_18, c_27_18, c_26_18, c_o_26_18;
wire [`PATH_WIDTH:0] d_o_26_18, d_o_19_18;

tile #(18, 0, 3, 1) t18(
  /* inputs */
  .d_in_f_NW(d_9_18),
  .d_in_f_NE(d_10_18),
  .d_in_f_SW(d_17_18),
  .d_in_s_N(d_o_10_18),
  .d_in_s_E(d_o_19_18),
  .d_in_s_S(d_o_26_18),
  .d_in_s_W(d_o_17_18),
  .c_in_s_N(c_o_10_18),
  .c_in_s_NE(c_19_18),
  .c_in_s_E(c_o_19_18),
  .c_in_s_SE(c_27_18),
  .c_in_s_S(c_o_26_18),
  .c_in_s_SW(c_26_18),
  .c_in_s_W(c_o_17_18),
  .clk(clk),
  .rst(rst),
  .conf_en(conf_en),
  /* outputs */
  .d_out_s_N(d_o_18_10),
  .d_out_s_NE(d_18_19),
  .d_out_s_E(d_o_18_19),
  .d_out_s_SE(d_18_27),
  .d_out_s_S(d_o_18_26),
  .d_out_s_SW(d_18_26),
  .d_out_s_W(d_o_18_17),
  .c_out_f_NW(c_18_9),
  .c_out_f_NE(c_18_10),
  .c_out_f_SW(c_18_17),
  .c_out_s_N(c_o_18_10),
  .c_out_s_E(c_o_18_19),
  .c_out_s_S(c_o_18_26),
  .c_out_s_W(c_o_18_17)
  );

/* tile 19 output wires (data and credit lines) */
wire [`PATH_WIDTH:0] d_19_20, d_o_19_20, d_19_28, d_19_27, d_o_19_27;
wire c_o_19_27, c_o_19_20;
/* tile 19 input wires (credit and data lines) */
wire c_20_19, c_o_20_19, c_28_19, c_27_19, c_o_27_19;
wire [`PATH_WIDTH:0] d_o_27_19, d_o_20_19;

tile #(19, 0, 3, 1) t19(
  /* inputs */
  .d_in_f_NW(d_10_19),
  .d_in_f_NE(d_11_19),
  .d_in_f_SW(d_18_19),
  .d_in_s_N(d_o_11_19),
  .d_in_s_E(d_o_20_19),
  .d_in_s_S(d_o_27_19),
  .d_in_s_W(d_o_18_19),
  .c_in_s_N(c_o_11_19),
  .c_in_s_NE(c_20_19),
  .c_in_s_E(c_o_20_19),
  .c_in_s_SE(c_28_19),
  .c_in_s_S(c_o_27_19),
  .c_in_s_SW(c_27_19),
  .c_in_s_W(c_o_18_19),
  .clk(clk),
  .rst(rst),
  .conf_en(conf_en),
  /* outputs */
  .d_out_s_N(d_o_19_11),
  .d_out_s_NE(d_19_20),
  .d_out_s_E(d_o_19_20),
  .d_out_s_SE(d_19_28),
  .d_out_s_S(d_o_19_27),
  .d_out_s_SW(d_19_27),
  .d_out_s_W(d_o_19_18),
  .c_out_f_NW(c_19_10),
  .c_out_f_NE(c_19_11),
  .c_out_f_SW(c_19_18),
  .c_out_s_N(c_o_19_11),
  .c_out_s_E(c_o_19_20),
  .c_out_s_S(c_o_19_27),
  .c_out_s_W(c_o_19_18)
  );

/* tile 20 output wires (data and credit lines) */
wire [`PATH_WIDTH:0] d_20_21, d_o_20_21, d_20_29, d_20_28, d_o_20_28;
wire c_o_20_28, c_o_20_21;
/* tile 20 input wires (credit and data lines) */
wire c_21_20, c_o_21_20, c_29_20, c_28_20, c_o_28_20;
wire [`PATH_WIDTH:0] d_o_28_20, d_o_21_20;

tile #(20, 0, 3, 0) t20(
  /* inputs */
  .d_in_f_NW(d_11_20),
  .d_in_f_NE(d_12_20),
  .d_in_f_SW(d_19_20),
  .d_in_s_N(d_o_12_20),
  .d_in_s_E(d_o_21_20),
  .d_in_s_S(d_o_28_20),
  .d_in_s_W(d_o_19_20),
  
  .c_in_s_N(),
  .c_in_s_NE(c_21_20),
  .c_in_s_E(c_in_o13),
  .c_in_s_SE(c_in_o12),
  .c_in_s_S(c_o_28_20),
  .c_in_s_SW(c_28_20),
  .c_in_s_W(c_o_19_20),
  .clk(clk),
  .rst(rst),
  .conf_en(conf_en),
  /* outputs */
  .d_out_s_N(d_o_20_12),
  .d_out_s_NE(),
  .d_out_s_E(d_out_o13),
  .d_out_s_SE(d_out_o12),
  .d_out_s_S(d_o_20_28),
  .d_out_s_SW(d_20_28),
  .d_out_s_W(d_o_20_19),
  
  .c_out_f_NW(c_20_11),
  .c_out_f_NE(c_20_12),
  .c_out_f_SW(c_20_19),
  .c_out_s_N(c_o_20_12),
  .c_out_s_E(),
  .c_out_s_S(c_o_20_28),
  .c_out_s_W(c_o_20_19)
  );

/* tile 24 output wires (data and credit lines) */
wire [`PATH_WIDTH:0] d_24_25, d_o_24_25, d_24_33, d_24_32, d_o_24_32;
wire c_o_24_32, c_o_24_25;
/* tile 24 input wires (credit and data lines) */
wire c_25_24, c_o_25_24, c_33_24, c_32_24, c_o_32_24;
wire [`PATH_WIDTH:0] d_o_32_24, d_o_25_24;

tile #(24, 0, 1, 3) t24(
  /* inputs */
  .d_in_f_NW(d_in_e23),
  .d_in_f_NE(d_16_24),
  .d_in_f_SW(d_in_e24),
  .d_in_s_N(d_o_16_24),
  .d_in_s_E(d_o_25_24),
  .d_in_s_S(d_o_32_24),
  .d_in_s_W(d_in_e25),
  
  .c_in_s_N(c_o_16_24),
  .c_in_s_NE(c_25_24),
  .c_in_s_E(c_o_25_24),
  .c_in_s_SE(c_33_24),
  .c_in_s_S(c_o_32_24),
  .c_in_s_SW(c_32_24),
  .c_in_s_W(c_in_e8),
  .clk(clk),
  .rst(rst),
  .conf_en(conf_en),
  /* outputs */
  .d_out_s_N(d_o_24_16),
  .d_out_s_NE(d_24_25),
  .d_out_s_E(d_o_24_25),
  .d_out_s_SE(d_24_33),
  .d_out_s_S(d_o_24_32),
  .d_out_s_SW(d_24_32),
  .d_out_s_W(d_out_e8),
  
  .c_out_f_NW(c_out_e23),
  .c_out_f_NE(c_24_16),
  .c_out_f_SW(c_out_e24),
  .c_out_s_N(c_o_24_16),
  .c_out_s_E(c_o_24_25),
  .c_out_s_S(c_o_24_32),
  .c_out_s_W(c_out_e25)
  );

/* tile 25 output wires (data and credit lines) */
wire [`PATH_WIDTH:0] d_25_26, d_o_25_26, d_25_34, d_25_33, d_o_25_33;
wire c_o_25_33, c_o_25_26;
/* tile 25 input wires (credit and data lines) */
wire c_26_25, c_o_26_25, c_34_25, c_33_25, c_o_33_25;
wire [`PATH_WIDTH:0] d_o_33_25, d_o_26_25;

tile #(25, 1, 1, 3) t25(
  /* inputs */
  .d_in_f_NW(d_16_25),
  .d_in_f_NE(d_17_25),
  .d_in_f_SW(d_24_25),
  .d_in_s_N(d_o_17_25),
  .d_in_s_E(d_o_26_25),
  .d_in_s_S(d_o_33_25),
  .d_in_s_W(d_o_24_25),
  .c_in_s_N(c_o_17_25),
  .c_in_s_NE(c_26_25),
  .c_in_s_E(c_o_26_25),
  .c_in_s_SE(c_34_25),
  .c_in_s_S(c_o_33_25),
  .c_in_s_SW(c_33_25),
  .c_in_s_W(c_o_24_25),
  .clk(clk),
  .rst(rst),
  .conf_en(conf_en),
  /* outputs */
  .d_out_s_N(d_o_25_17),
  .d_out_s_NE(d_25_26),
  .d_out_s_E(d_o_25_26),
  .d_out_s_SE(d_25_34),
  .d_out_s_S(d_o_25_33),
  .d_out_s_SW(d_25_33),
  .d_out_s_W(d_o_25_24),
  .c_out_f_NW(c_25_16),
  .c_out_f_NE(c_25_17),
  .c_out_f_SW(c_25_24),
  .c_out_s_N(c_o_25_17),
  .c_out_s_E(c_o_25_26),
  .c_out_s_S(c_o_25_33),
  .c_out_s_W(c_o_25_24)
  );

/* tile 26 output wires (data and credit lines) */
wire [`PATH_WIDTH:0] d_26_27, d_o_26_27, d_26_35, d_26_34, d_o_26_34;
wire c_o_26_34, c_o_26_27;
/* tile 26 input wires (credit and data lines) */
wire c_27_26, c_o_27_26, c_35_26, c_34_26, c_o_34_26;
wire [`PATH_WIDTH:0] d_o_34_26, d_o_27_26;

tile #(26, 0, 1, 3) t26(
  /* inputs */
  .d_in_f_NW(d_17_26),
  .d_in_f_NE(d_18_26),
  .d_in_f_SW(d_25_26),
  .d_in_s_N(d_o_18_26),
  .d_in_s_E(d_o_27_26),
  .d_in_s_S(d_o_34_26),
  .d_in_s_W(d_o_25_26),
  .c_in_s_N(c_o_18_26),
  .c_in_s_NE(c_27_26),
  .c_in_s_E(c_o_27_26),
  .c_in_s_SE(c_35_26),
  .c_in_s_S(c_o_34_26),
  .c_in_s_SW(c_34_26),
  .c_in_s_W(c_o_25_26),
  .clk(clk),
  .rst(rst),
  .conf_en(conf_en),
  /* outputs */
  .d_out_s_N(d_o_26_18),
  .d_out_s_NE(d_26_27),
  .d_out_s_E(d_o_26_27),
  .d_out_s_SE(d_26_35),
  .d_out_s_S(d_o_26_34),
  .d_out_s_SW(d_26_34),
  .d_out_s_W(d_o_26_25),
  .c_out_f_NW(c_26_17),
  .c_out_f_NE(c_26_18),
  .c_out_f_SW(c_26_25),
  .c_out_s_N(c_o_26_18),
  .c_out_s_E(c_o_26_27),
  .c_out_s_S(c_o_26_34),
  .c_out_s_W(c_o_26_25)
  );

/* tile 27 output wires (data and credit lines) */
wire [`PATH_WIDTH:0] d_27_28, d_o_27_28, d_27_36, d_27_35, d_o_27_35;
wire c_o_27_35, c_o_27_28;
/* tile 27 input wires (credit and data lines) */
wire c_28_27, c_o_28_27, c_36_27, c_35_27, c_o_35_27;
wire [`PATH_WIDTH:0] d_o_35_27, d_o_28_27;

tile #(27, 0, 1, 3) t27(
  /* inputs */
  .d_in_f_NW(d_18_27),
  .d_in_f_NE(d_19_27),
  .d_in_f_SW(d_26_27),
  .d_in_s_N(d_o_19_27),
  .d_in_s_E(d_o_28_27),
  .d_in_s_S(d_o_35_27),
  .d_in_s_W(d_o_26_27),
  .c_in_s_N(c_o_19_27),
  .c_in_s_NE(c_28_27),
  .c_in_s_E(c_o_28_27),
  .c_in_s_SE(c_36_27),
  .c_in_s_S(c_o_35_27),
  .c_in_s_SW(c_35_27),
  .c_in_s_W(c_o_26_27),
  .clk(clk),
  .rst(rst),
  .conf_en(conf_en),
  /* outputs */
  .d_out_s_N(d_o_27_19),
  .d_out_s_NE(d_27_28),
  .d_out_s_E(d_o_27_28),
  .d_out_s_SE(d_27_36),
  .d_out_s_S(d_o_27_35),
  .d_out_s_SW(d_27_35),
  .d_out_s_W(d_o_27_26),
  .c_out_f_NW(c_27_18),
  .c_out_f_NE(c_27_19),
  .c_out_f_SW(c_27_26),
  .c_out_s_N(c_o_27_19),
  .c_out_s_E(c_o_27_28),
  .c_out_s_S(c_o_27_35),
  .c_out_s_W(c_o_27_26)
  );

/* tile 28 output wires (data and credit lines) */
wire [`PATH_WIDTH:0] d_28_29, d_o_28_29, d_28_37, d_28_36, d_o_28_36;
wire c_o_28_36, c_o_28_29;
/* tile 28 input wires (credit and data lines) */
wire c_29_28, c_o_29_28, c_37_28, c_36_28, c_o_36_28;
wire [`PATH_WIDTH:0] d_o_36_28, d_o_29_28;

tile #(28, 0, 2, 3) t28(
  /* inputs */
  .d_in_f_NW(d_19_28),
  .d_in_f_NE(d_20_28),
  .d_in_f_SW(d_27_28),
  .d_in_s_N(d_o_20_28),
  .d_in_s_E(d_o_29_28),
  .d_in_s_S(d_o_36_28),
  .d_in_s_W(d_o_27_28),
  
  .c_in_s_N(c_o_20_28),
  .c_in_s_NE(),
  .c_in_s_E(c_in_o11),
  .c_in_s_SE(c_in_o12),
  .c_in_s_S(c_o_36_28),
  .c_in_s_SW(c_36_28),
  .c_in_s_W(c_o_27_28),
  .clk(clk),
  .rst(rst),
  .conf_en(conf_en),
  /* outputs */
  .d_out_s_N(d_o_28_20),
  .d_out_s_NE(),
  .d_out_s_E(d_out_o11),
  .d_out_s_SE(d_out_o10),
  .d_out_s_S(d_o_28_36),
  .d_out_s_SW(d_28_36),
  .d_out_s_W(d_o_28_27),
  
  .c_out_f_NW(c_28_19),
  .c_out_f_NE(c_28_20),
  .c_out_f_SW(c_28_27),
  .c_out_s_N(c_o_28_20),
  .c_out_s_E(),
  .c_out_s_S(c_o_28_36),
  .c_out_s_W(c_o_28_27)
  );


/* tile 32 output wires (data and credit lines) */
wire [`PATH_WIDTH:0] d_32_33, d_o_32_33, d_32_41, d_32_40, d_o_32_40;
wire c_o_32_40, c_o_32_33;
/* tile 32 input wires (credit and data lines) */
wire c_33_32, c_o_33_32, c_41_32, c_40_32, c_o_40_32;
wire [`PATH_WIDTH:0] d_o_40_32, d_o_33_32;

tile #(32, 0, 3, 1) t32(
  /* inputs */
  .d_in_f_NW(d_in_e26),
  .d_in_f_NE(d_24_32),
  .d_in_f_SW(d_in_e27),
  .d_in_s_N(d_o_24_32),
  .d_in_s_E(d_o_33_32),
  .d_in_s_S(d_o_40_32),
  .d_in_s_W(d_in_e28),
  
  .c_in_s_N(c_o_24_32),
  .c_in_s_NE(c_33_32),
  .c_in_s_E(c_o_33_32),
  .c_in_s_SE(c_in_o1),
  .c_in_s_S(c_in_o0),
  .c_in_s_SW(),
  .c_in_s_W(c_in_e9),
  .clk(clk),
  .rst(rst),
  .conf_en(conf_en),
  /* outputs */
  .d_out_s_N(d_o_32_24),
  .d_out_s_NE(d_32_33),
  .d_out_s_E(d_o_32_33),
  .d_out_s_SE(d_out_o1),
  .d_out_s_S(d_out_o0),
  .d_out_s_SW(),
  .d_out_s_W(d_out_e9),
  
  .c_out_f_NW(c_out_e26),
  .c_out_f_NE(c_32_24),
  .c_out_f_SW(c_out_e27),
  .c_out_s_N(c_o_32_24),
  .c_out_s_E(c_o_32_33),
  .c_out_s_S(),
  .c_out_s_W(c_out_e28)
  );

/* tile 33 output wires (data and credit lines) */
wire [`PATH_WIDTH:0] d_33_34, d_o_33_34, d_33_42, d_33_41, d_o_33_41;
wire c_o_33_41, c_o_33_34;
/* tile 33 input wires (credit and data lines) */
wire c_34_33, c_o_34_33, c_42_33, c_41_33, c_o_41_33;
wire [`PATH_WIDTH:0] d_o_41_33, d_o_34_33;

tile #(33, 1, 3, 1) t33(
  /* inputs */
  .d_in_f_NW(d_24_33),
  .d_in_f_NE(d_25_33),
  .d_in_f_SW(d_32_33),
  .d_in_s_N(d_o_25_33),
  .d_in_s_E(d_o_34_33),
  .d_in_s_S(d_o_41_33),
  .d_in_s_W(d_o_32_33),
  
  .c_in_s_N(c_o_25_33),
  .c_in_s_NE(c_34_33),
  .c_in_s_E(c_o_34_33),
  .c_in_s_SE(c_in_o3),
  .c_in_s_S(c_in_o2),
  .c_in_s_SW(1'b0),
  .c_in_s_W(c_o_32_33),
  .clk(clk),
  .rst(rst),
  .conf_en(conf_en),
  /* outputs */
  .d_out_s_N(d_o_33_25),
  .d_out_s_NE(d_33_34),
  .d_out_s_E(d_o_33_34),
  .d_out_s_SE(),
  .d_out_s_S(d_out_o2),
  .d_out_s_SW(d_out_o3),
  .d_out_s_W(d_o_33_32),
  
  .c_out_f_NW(c_33_24),
  .c_out_f_NE(c_33_25),
  .c_out_f_SW(c_33_32),
  .c_out_s_N(c_o_33_25),
  .c_out_s_E(c_o_33_34),
  .c_out_s_S(),
  .c_out_s_W(c_o_33_32)
  );

/* tile 34 output wires (data and credit lines) */
wire [`PATH_WIDTH:0] d_34_35, d_o_34_35, d_34_43, d_34_42, d_o_34_42;
wire c_o_34_42, c_o_34_35;
/* tile 34 input wires (credit and data lines) */
wire c_35_34, c_o_35_34, c_43_34, c_42_34, c_o_42_34;
wire [`PATH_WIDTH:0] d_o_42_34, d_o_35_34;

tile #(34, 0, 3, 1) t34(
  /* inputs */
  .d_in_f_NW(d_25_34),
  .d_in_f_NE(d_26_34),
  .d_in_f_SW(d_33_34),
  .d_in_s_N(d_o_26_34),
  .d_in_s_E(d_o_35_34),
  .d_in_s_S(d_o_42_34),
  .d_in_s_W(d_o_33_34),
  
  .c_in_s_N(c_o_26_34),
  .c_in_s_NE(c_35_34),
  .c_in_s_E(c_o_35_34),
  .c_in_s_SE(c_in_o5),
  .c_in_s_S(c_in_o4),
  .c_in_s_SW(1'b0),
  .c_in_s_W(c_o_33_34),
  .clk(clk),
  .rst(rst),
  .conf_en(conf_en),
  /* outputs */
  .d_out_s_N(d_o_34_26),
  .d_out_s_NE(d_34_35),
  .d_out_s_E(d_o_34_35),
  .d_out_s_SE(),
  .d_out_s_S(d_out_o4),
  .d_out_s_SW(d_out_o5),
  .d_out_s_W(d_o_34_33),
  
  .c_out_f_NW(c_34_25),
  .c_out_f_NE(c_34_26),
  .c_out_f_SW(c_34_33),
  .c_out_s_N(c_o_34_26),
  .c_out_s_E(c_o_34_35),
  .c_out_s_S(),
  .c_out_s_W(c_o_34_33)
  );

/* tile 35 output wires (data and credit lines) */
wire [`PATH_WIDTH:0] d_35_36, d_o_35_36, d_35_44, d_35_43, d_o_35_43;
wire c_o_35_43, c_o_35_36;
/* tile 35 input wires (credit and data lines) */
wire c_36_35, c_o_36_35, c_44_35, c_43_35, c_o_43_35;
wire [`PATH_WIDTH:0] d_o_43_35, d_o_36_35;

tile #(35, 0, 3, 1) t35(
  /* inputs */
  .d_in_f_NW(d_26_35),
  .d_in_f_NE(d_27_35),
  .d_in_f_SW(d_34_35),
  .d_in_s_N(d_o_27_35),
  .d_in_s_E(d_o_36_35),
  .d_in_s_S(d_o_43_35),
  .d_in_s_W(d_o_34_35),
  
  .c_in_s_N(c_o_27_35),
  .c_in_s_NE(c_36_35),
  .c_in_s_E(c_o_36_35),
  .c_in_s_SE(c_in_o7),
  .c_in_s_S(c_in_o6),
  .c_in_s_SW(1'b0),
  .c_in_s_W(c_o_34_35),
  .clk(clk),
  .rst(rst),
  .conf_en(conf_en),
  /* outputs */
  .d_out_s_N(d_o_35_27),
  .d_out_s_NE(d_35_36),
  .d_out_s_E(d_o_35_36),
  .d_out_s_SE(),
  .d_out_s_S(d_out_o6),
  .d_out_s_SW(d_out_o7),
  .d_out_s_W(d_o_35_34),
  
  .c_out_f_NW(c_35_26),
  .c_out_f_NE(c_35_27),
  .c_out_f_SW(c_35_34),
  .c_out_s_N(c_o_35_27),
  .c_out_s_E(c_o_35_36),
  .c_out_s_S(),
  .c_out_s_W(c_o_35_34)
  );

/* tile 36 output wires (data and credit lines) */
wire [`PATH_WIDTH:0] d_36_37, d_o_36_37, d_36_45, d_36_44, d_o_36_44;
wire c_o_36_44, c_o_36_37;
/* tile 36 input wires (credit and data lines) */
wire c_37_36, c_o_37_36, c_45_36, c_44_36, c_o_44_36;
wire [`PATH_WIDTH:0] d_o_44_36, d_o_37_36;

tile #(36, 0, 3, 0) t36(
  /* inputs */
  .d_in_f_NW(d_27_36),
  .d_in_f_NE(d_28_36),
  .d_in_f_SW(d_35_36),
  .d_in_s_N(d_o_28_36),
  .d_in_s_E(d_o_37_36),
  .d_in_s_S(d_o_44_36),
  .d_in_s_W(d_o_35_36),
  
  .c_in_s_N(c_o_28_36),
  .c_in_s_NE(),
  .c_in_s_E(c_in_o9),
  .c_in_s_SE(c_in_o8),
  .c_in_s_S(),
  .c_in_s_SW(),
  .c_in_s_W(c_o_35_36),
  .clk(clk),
  .rst(rst),
  .conf_en(conf_en),
  /* outputs */
  .d_out_s_N(d_o_36_28),
  .d_out_s_NE(),
  .d_out_s_E(d_out_o9),
  .d_out_s_SE(d_out_o8),
  .d_out_s_S(),
  .d_out_s_SW(),
  .d_out_s_W(d_o_36_35),
  
  .c_out_f_NW(c_36_27),
  .c_out_f_NE(c_36_28),
  .c_out_f_SW(c_36_35),
  .c_out_s_N(c_o_36_28),
  .c_out_s_E(),
  .c_out_s_S(c_o_36_44),
  .c_out_s_W(c_o_36_35)
  );

endmodule
