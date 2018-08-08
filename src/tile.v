// tile.v
//
// DySER tile structure, includes one functional unit and one switch
//
//
`include "config_5x5.v"

module tile(
    /* inputs */
    d_in_f_NW,
    d_in_f_NE,
    d_in_f_SW,
    d_in_s_N,
    d_in_s_E,
    d_in_s_S,
    d_in_s_W,
    c_in_s_N,
    c_in_s_NE,
    c_in_s_E,
    c_in_s_SE,
    c_in_s_S,
    c_in_s_SW,
    c_in_s_W,
    conf_en,
    clk,
    rst,
    /* outputs */
    d_out_s_N,
    d_out_s_NE,
    d_out_s_E,
    d_out_s_SE,
    d_out_s_S,
    d_out_s_SW,
    d_out_s_W,
    c_out_f_NW,
    c_out_f_NE,
    c_out_f_SW,
    c_out_s_N,
    c_out_s_E,
    c_out_s_S,
    c_out_s_W
    );


parameter              ID = 0;
parameter              TYPE = 0;
parameter              CONFIG_PATH_IN  = 0; // For switch.v
parameter              CONFIG_PATH_OUT = 0; // For switch.v

input  [`PATH_WIDTH:0] d_in_f_NW;
input  [`PATH_WIDTH:0] d_in_f_NE;
input  [`PATH_WIDTH:0] d_in_f_SW;
input  [`PATH_WIDTH:0] d_in_s_N;
input  [`PATH_WIDTH:0] d_in_s_E;
input  [`PATH_WIDTH:0] d_in_s_S;
input  [`PATH_WIDTH:0] d_in_s_W;

input                  c_in_s_N;
input                  c_in_s_NE;
input                  c_in_s_E;
input                  c_in_s_SE;
input                  c_in_s_S;
input                  c_in_s_SW;
input                  c_in_s_W;
input                  conf_en;
input                  clk, rst;


output [`PATH_WIDTH:0] d_out_s_N;
output [`PATH_WIDTH:0] d_out_s_NE;
output [`PATH_WIDTH:0] d_out_s_E;
output [`PATH_WIDTH:0] d_out_s_SE;
output [`PATH_WIDTH:0] d_out_s_S;
output [`PATH_WIDTH:0] d_out_s_SW;
output [`PATH_WIDTH:0] d_out_s_W;

output                 c_out_f_NW;
output                 c_out_f_NE;
output                 c_out_f_SW;
output                 c_out_s_N;
output                 c_out_s_E;
output                 c_out_s_S;
output                 c_out_s_W;


/////////////////////////////////////////////////
//
//    wires
//
////////////////////////////////////////////////

wire [`PATH_WIDTH:0] d_f_s; //data from functional unit to switch
wire [`PATH_WIDTH:0] d_s_f; //data from to switch functional unit
wire                 c_f_s; //credit from functional unit to switch
wire                 c_s_f; //credit from switch to functional unit

wire          [15:0] fu_conf;


/////////////////////////////////////////////////
//
//  switch and functional unit
//
////////////////////////////////////////////////

functional_unit #(ID, TYPE) f0(
    /* inputs */
    .d_in_NW(d_in_f_NW),
    .d_in_NE(d_in_f_NE),
    .d_in_SE(d_s_f),
    .d_in_SW(d_in_f_SW),
    .c_in_SE(c_s_f),
    .conf(fu_conf),
    .clk(clk),
    .rst(rst),
    /* outputs */
    .c_out_NW(c_out_f_NW),
    .c_out_NE(c_out_f_NE),
    .c_out_SE(c_f_s),
    .c_out_SW(c_out_f_SW),
    .d_out_SE(d_f_s)
    );

switch #(ID, 0, CONFIG_PATH_IN, CONFIG_PATH_OUT) s0(
    /* inputs */
    .d_in_NW(d_f_s),
    .d_in_N(d_in_s_N),
    .d_in_E(d_in_s_E),
    .d_in_W(d_in_s_W),
    .d_in_S(d_in_s_S),
    .c_in_NW(c_f_s),
    .c_in_N(c_in_s_N),
    .c_in_NE(c_in_s_NE),
    .c_in_E(c_in_s_E),
    .c_in_SE(c_in_s_SE),
    .c_in_S(c_in_s_S),
    .c_in_SW(c_in_s_SW),
    .c_in_W(c_in_s_W),
    .conf_en(conf_en),
    .clk(clk),
    .rst(rst),
    /* outputs */
    .d_out_NW(d_s_f),
    .d_out_N(d_out_s_N),
    .d_out_NE(d_out_s_NE),
    .d_out_E(d_out_s_E),
    .d_out_SE(d_out_s_SE),
    .d_out_S(d_out_s_S),
    .d_out_SW(d_out_s_SW),
    .d_out_W(d_out_s_W),
    .c_out_NW(c_s_f),
    .c_out_N(c_out_s_N),
    .c_out_E(c_out_s_E),
    .c_out_W(c_out_s_W),
    .c_out_S(c_out_s_S),
    .fu_conf(fu_conf)
    );

endmodule
