//switch.v
//
// DySER switch, responsible for passing data    
//
`include "config_5x5.v"


module switch(
    /* inputs */
    d_in_NW,
    d_in_N,
    d_in_E,
    d_in_W,
    d_in_S,
    c_in_NW,
    c_in_N,
    c_in_NE,
    c_in_E,
    c_in_SE,
    c_in_S,
    c_in_SW,
    c_in_W,
    conf_en,
    clk,
    rst,
    /* outputs */
    d_out_NW,
    d_out_N,
    d_out_NE,
    d_out_E,
    d_out_SE,
    d_out_S,
    d_out_SW,
    d_out_W,
    c_out_NW,
    c_out_N,
    c_out_E,
    c_out_W,
    c_out_S,
    fu_conf
    );


parameter              ID = 0;
parameter              EDGE = 0;
parameter              CONFIG_PATH_IN = 0;  // Statically configured input for CONFIG bits
parameter              CONFIG_PATH_OUT = 0; // Statically configured output for CONFIG bits

// TODO: EDGE switches have only 32 config bits!

input  [`PATH_WIDTH:0] d_in_NW;
input  [`PATH_WIDTH:0] d_in_N;
input  [`PATH_WIDTH:0] d_in_E;
input  [`PATH_WIDTH:0] d_in_W;
input  [`PATH_WIDTH:0] d_in_S;

input                  c_in_NW;
input                  c_in_N;
input                  c_in_NE;
input                  c_in_E;
input                  c_in_SE;
input                  c_in_S;
input                  c_in_SW;
input                  c_in_W;

input                  conf_en;
input                  clk, rst;


output [`PATH_WIDTH:0] d_out_NW;
output [`PATH_WIDTH:0] d_out_N;
output [`PATH_WIDTH:0] d_out_NE;
output [`PATH_WIDTH:0] d_out_E;
output [`PATH_WIDTH:0] d_out_SE;
output [`PATH_WIDTH:0] d_out_S;
output [`PATH_WIDTH:0] d_out_SW;
output [`PATH_WIDTH:0] d_out_W;

output                 c_out_NW;
output                 c_out_N;
output                 c_out_E;
output                 c_out_W;
output                 c_out_S;
output          [15:0] fu_conf;


//parameter CONF_BITS = (EDGE == 0 ? 47 : 31);
reg             [47:0] conf;


assign fu_conf = (EDGE == 0 ? conf[47:32] : 16'b0); // top 16 bits


///////////////////////////////////////////
//
//    wires
//
//////////////////////////////////////////

wire   [`PATH_WIDTH:0] ff_in_N,     ff_in_E,     ff_in_W,     ff_in_S, 
                       ff_in_NW,    ff_in_NE,    ff_in_SW,    ff_in_SE;
wire   [`PATH_WIDTH:0] ff_out_N,    ff_out_E,    ff_out_W,    ff_out_S;

wire                   ff_c_out_N,  ff_c_out_E,  ff_c_out_W,  ff_c_out_S,
                       ff_c_out_NW, ff_c_out_NE, ff_c_out_SW, ff_c_out_SE;

wire [7:0] select_NW;
wire [7:0] select_N;
wire [7:0] select_E;
wire [7:0] select_S;
wire [7:0] select_W;



//////////////////////////////////////////
//
//    data muxes and flip-flop stage
//
//////////////////////////////////////////


always @(posedge clk)
begin
  if (rst == 1'b1)
    conf <= 0;
  else if (conf_en == 1'b1) begin
  	if (EDGE == 0) begin // CORE SWITCH
  		conf[47-`CONF_BITS:0]  <= conf[47:`CONF_BITS];
    	conf[47:47-`CONF_WIDTH] <= (CONFIG_PATH_IN == `NORTH ? d_in_N[`CONF_WIDTH:0] : 
      	                          CONFIG_PATH_IN == `EAST  ? d_in_E[`CONF_WIDTH:0] : 
        	                        CONFIG_PATH_IN == `SOUTH ? d_in_S[`CONF_WIDTH:0] : 
          	                    /*CONFIG_PATH_IN == `WEST*/  d_in_W[`CONF_WIDTH:0]);
    end
    else begin // EDGE SWITCH
    	conf[31:0] <= (CONFIG_PATH_IN == `NORTH ? d_in_N[`CONF_WIDTH:0] : 
      	               CONFIG_PATH_IN == `EAST  ? d_in_E[`CONF_WIDTH:0] : 
        	       CONFIG_PATH_IN == `SOUTH ? d_in_S[`CONF_WIDTH:0] : 
                     /*CONFIG_PATH_IN == `WEST*/  d_in_W[`CONF_WIDTH:0]);
    end
  end
end



// North-West output
switch_output mux_NW(
    .d_in_NW(d_in_NW),
    .d_in_N(d_in_N),
    .d_in_E(d_in_E),
    .d_in_W(d_in_W),
    .d_in_S(d_in_S),
    .conf(conf[3:0]),
    .d_out(ff_in_NW),
    .select_NW(select_NW[0]),
    .select_N(select_N[0]),
    .select_E(select_E[0]),
    .select_W(select_W[0]),
    .select_S(select_S[0])
    );

ff_stage #(ID, EDGE) ff_NW(
    .valid_in(~conf_en & ff_in_NW[0]),
    .credit_in(c_in_NW),
    .data_in(ff_in_NW[`PATH_WIDTH:1]),
    .done(1'b1),
    .clk(clk),
    .rst(rst),
    .credit_out(ff_c_out_NW),
    .data_out(d_out_NW[`PATH_WIDTH:1]),
    .valid_out(d_out_NW[0])
    );



// North output
switch_output mux_N(
    .d_in_NW(d_in_NW),
    .d_in_N(d_in_N),
    .d_in_E(d_in_E),
    .d_in_W(d_in_W),
    .d_in_S(d_in_S),
    .conf(conf[7:4]),
    .d_out(ff_in_N),
    .select_NW(select_NW[1]),
    .select_N(select_N[1]),
    .select_E(select_E[1]),
    .select_W(select_W[1]),
    .select_S(select_S[1])
    );

ff_stage #(ID, EDGE) ff_N(
    .valid_in(~conf_en & ff_in_N[0]),
    .credit_in(c_in_N),
    .data_in(ff_in_N[`PATH_WIDTH:1]),
    .done(1'b1),
    .clk(clk),
    .rst(rst),
    .credit_out(ff_c_out_N),
    .data_out(ff_out_N[`PATH_WIDTH:1]),
    .valid_out(ff_out_N[0])
    );

// Switch network is statically multiplexed with configuration data during config mode (conf_en)
assign d_out_N  = ((conf_en && CONFIG_PATH_OUT == `NORTH) ? (`CONF_WIDTH == `PATH_WIDTH ? conf[`CONF_WIDTH:0] : {ff_out_N[`PATH_WIDTH:`CONF_BITS], conf[`CONF_WIDTH:0]}) : ff_out_N);



// North-East output
switch_output mux_NE(
    .d_in_NW(d_in_NW),
    .d_in_N(d_in_N),
    .d_in_E(d_in_E),
    .d_in_W(d_in_W),
    .d_in_S(d_in_S),
    .conf(conf[11:8]),
    .d_out(ff_in_NE),
    .select_NW(select_NW[2]),
    .select_N(select_N[2]),
    .select_E(select_E[2]),
    .select_W(select_W[2]),
    .select_S(select_S[2])
    );

ff_stage #(ID, EDGE) ff_NE(
    .valid_in(~conf_en & ff_in_NE[0]),
    .credit_in(c_in_NE),
    .data_in(ff_in_NE[`PATH_WIDTH:1]),
    .done(1'b1),
    .clk(clk),
    .rst(rst),
    .credit_out(ff_c_out_NE),
    .data_out(d_out_NE[`PATH_WIDTH:1]),
    .valid_out(d_out_NE[0])
    );



// East output
switch_output mux_E(
    .d_in_NW(d_in_NW),
    .d_in_N(d_in_N),
    .d_in_E(d_in_E),
    .d_in_W(d_in_W),
    .d_in_S(d_in_S),
    .conf(conf[15:12]),
    .d_out(ff_in_E),
    .select_NW(select_NW[3]),
    .select_N(select_N[3]),
    .select_E(select_E[3]),
    .select_W(select_W[3]),
    .select_S(select_S[3])
    );

ff_stage #(ID, EDGE) ff_E(
    .valid_in(~conf_en & ff_in_E[0]),
    .credit_in(c_in_E),
    .data_in(ff_in_E[`PATH_WIDTH:1]),
    .done(1'b1),
    .clk(clk),
    .rst(rst),
    .credit_out(ff_c_out_E),
    .data_out(ff_out_E[`PATH_WIDTH:1]),
    .valid_out(ff_out_E[0])
    );

// Switch network is statically multiplexed with configuration data during config mode (conf_en)
assign d_out_E  = ((conf_en && CONFIG_PATH_OUT == `EAST) ? (`CONF_WIDTH == `PATH_WIDTH ? conf[`CONF_WIDTH:0] : {ff_out_E[`PATH_WIDTH:`CONF_BITS], conf[`CONF_WIDTH:0]}) : ff_out_E);



// South-East output
switch_output mux_SE(
    .d_in_NW(d_in_NW),
    .d_in_N(d_in_N),
    .d_in_E(d_in_E),
    .d_in_W(d_in_W),
    .d_in_S(d_in_S),
    .conf(conf[19:16]),
    .d_out(ff_in_SE),
    .select_NW(select_NW[4]),
    .select_N(select_N[4]),
    .select_E(select_E[4]),
    .select_W(select_W[4]),
    .select_S(select_S[4])
    );

ff_stage #(ID, EDGE) ff_SE(
    .valid_in(~conf_en & ff_in_SE[0]),
    .credit_in(c_in_SE),
    .data_in(ff_in_SE[`PATH_WIDTH:1]),
    .done(1'b1),
    .clk(clk),
    .rst(rst),
    .credit_out(ff_c_out_SE),
    .data_out(d_out_SE[`PATH_WIDTH:1]),
    .valid_out(d_out_SE[0])
    );



// South output
switch_output mux_S(
    .d_in_NW(d_in_NW),
    .d_in_N(d_in_N),
    .d_in_E(d_in_E),
    .d_in_W(d_in_W),
    .d_in_S(d_in_S),
    .conf(conf[23:20]),
    .d_out(ff_in_S),
    .select_NW(select_NW[5]),
    .select_N(select_N[5]),
    .select_E(select_E[5]),
    .select_W(select_W[5]),
    .select_S(select_S[5])
    );

ff_stage #(ID, EDGE) ff_S(
    .valid_in(~conf_en & ff_in_S[0]),
    .credit_in(c_in_S),
    .data_in(ff_in_S[`PATH_WIDTH:1]),
    .done(1'b1),
    .clk(clk),
    .rst(rst),
    .credit_out(ff_c_out_S),
    .data_out(ff_out_S[`PATH_WIDTH:1]),
    .valid_out(ff_out_S[0])
    );

// Switch network is statically multiplexed with configuration data during config mode (conf_en)
assign d_out_S  = ((conf_en && CONFIG_PATH_OUT == `SOUTH) ? (`CONF_WIDTH == `PATH_WIDTH ? conf[`CONF_WIDTH:0] : {ff_out_S[`PATH_WIDTH:`CONF_BITS], conf[`CONF_WIDTH:0]}) : ff_out_S);



// South-West output
switch_output mux_SW(
    .d_in_NW(d_in_NW),
    .d_in_N(d_in_N),
    .d_in_E(d_in_E),
    .d_in_W(d_in_W),
    .d_in_S(d_in_S),
    .conf(conf[27:24]),
    .d_out(ff_in_SW),
    .select_NW(select_NW[6]),
    .select_N(select_N[6]),
    .select_E(select_E[6]),
    .select_W(select_W[6]),
    .select_S(select_S[6])
    );

ff_stage #(ID, EDGE) ff_SW(
    .valid_in(~conf_en & ff_in_SW[0]),
    .credit_in(c_in_SW),
    .data_in(ff_in_SW[`PATH_WIDTH:1]),
    .done(1'b1),
    .clk(clk),
    .rst(rst),
    .credit_out(ff_c_out_SW),
    .data_out(d_out_SW[`PATH_WIDTH:1]),
    .valid_out(d_out_SW[0])
    );



// West output
switch_output mux_W(
    .d_in_NW(d_in_NW),
    .d_in_N(d_in_N),
    .d_in_E(d_in_E),
    .d_in_W(d_in_W),
    .d_in_S(d_in_S),
    .conf(conf[31:28]),
    .d_out(ff_in_W),
    .select_NW(select_NW[7]),
    .select_N(select_N[7]),
    .select_E(select_E[7]),
    .select_W(select_W[7]),
    .select_S(select_S[7])
    );

ff_stage #(ID, EDGE) ff_W(
    .valid_in(~conf_en & ff_in_W[0]),
    .credit_in(c_in_W),
    .data_in(ff_in_W[`PATH_WIDTH:1]),
    .done(1'b1),
    .clk(clk),
    .rst(rst),
    .credit_out(ff_c_out_W),
    .data_out(ff_out_W[`PATH_WIDTH:1]),
    .valid_out(ff_out_W[0])
    );

// Switch network is statically multiplexed with configuration data during config mode (conf_en)
assign d_out_W  = ((conf_en && CONFIG_PATH_OUT == `WEST) ? (`CONF_WIDTH == `PATH_WIDTH ? conf[`CONF_WIDTH:0] : {ff_out_W[`PATH_WIDTH:`CONF_BITS], conf[`CONF_WIDTH:0]}) : ff_out_W);



//////////////////////////////////////////
//
//  credit signal path  
//
//////////////////////////////////////////

// when input is sent to multiple outputs,
//   need to "hold" credit until ALL outputs ready

reg [7:0] c_out_NW_save;
reg [7:0] c_out_N_save;
reg [7:0] c_out_E_save;
reg [7:0] c_out_S_save;
reg [7:0] c_out_W_save;

always @(posedge clk)
begin
  if (rst == 1'b1) begin
    c_out_NW_save[7:0] <= select_NW[7:0];
    c_out_N_save[7:0]  <= select_N[7:0];
    c_out_E_save[7:0]  <= select_E[7:0];
    c_out_S_save[7:0]  <= select_S[7:0];
    c_out_W_save[7:0]  <= select_W[7:0];
  end
  else begin
    c_out_NW_save[0] <= (c_out_NW ? 0 : ff_c_out_NW | c_out_NW_save[0]);
    c_out_NW_save[1] <= (c_out_NW ? 0 : ff_c_out_N  | c_out_NW_save[1]);
    c_out_NW_save[2] <= (c_out_NW ? 0 : ff_c_out_NE | c_out_NW_save[2]);
    c_out_NW_save[3] <= (c_out_NW ? 0 : ff_c_out_E  | c_out_NW_save[3]);
    c_out_NW_save[4] <= (c_out_NW ? 0 : ff_c_out_SE | c_out_NW_save[4]);
    c_out_NW_save[5] <= (c_out_NW ? 0 : ff_c_out_S  | c_out_NW_save[5]);
    c_out_NW_save[6] <= (c_out_NW ? 0 : ff_c_out_SW | c_out_NW_save[6]);
    c_out_NW_save[7] <= (c_out_NW ? 0 : ff_c_out_W  | c_out_NW_save[7]);
    
    c_out_N_save[0]  <= (c_out_N  ? 0 : ff_c_out_NW | c_out_N_save[0]);
    c_out_N_save[1]  <= (c_out_N  ? 0 : ff_c_out_N  | c_out_N_save[1]);
    c_out_N_save[2]  <= (c_out_N  ? 0 : ff_c_out_NE | c_out_N_save[2]);
    c_out_N_save[3]  <= (c_out_N  ? 0 : ff_c_out_E  | c_out_N_save[3]);
    c_out_N_save[4]  <= (c_out_N  ? 0 : ff_c_out_SE | c_out_N_save[4]);
    c_out_N_save[5]  <= (c_out_N  ? 0 : ff_c_out_S  | c_out_N_save[5]);
    c_out_N_save[6]  <= (c_out_N  ? 0 : ff_c_out_SW | c_out_N_save[6]);
    c_out_N_save[7]  <= (c_out_N  ? 0 : ff_c_out_W  | c_out_N_save[7]);
    
    c_out_E_save[0]  <= (c_out_E  ? 0 : ff_c_out_NW | c_out_E_save[0]);
    c_out_E_save[1]  <= (c_out_E  ? 0 : ff_c_out_N  | c_out_E_save[1]);
    c_out_E_save[2]  <= (c_out_E  ? 0 : ff_c_out_NE | c_out_E_save[2]);
    c_out_E_save[3]  <= (c_out_E  ? 0 : ff_c_out_E  | c_out_E_save[3]);
    c_out_E_save[4]  <= (c_out_E  ? 0 : ff_c_out_SE | c_out_E_save[4]);
    c_out_E_save[5]  <= (c_out_E  ? 0 : ff_c_out_S  | c_out_E_save[5]);
    c_out_E_save[6]  <= (c_out_E  ? 0 : ff_c_out_SW | c_out_E_save[6]);
    c_out_E_save[7]  <= (c_out_E  ? 0 : ff_c_out_W  | c_out_E_save[7]);
    
    c_out_S_save[0]  <= (c_out_S  ? 0 : ff_c_out_NW | c_out_S_save[0]);
    c_out_S_save[1]  <= (c_out_S  ? 0 : ff_c_out_N  | c_out_S_save[1]);
    c_out_S_save[2]  <= (c_out_S  ? 0 : ff_c_out_NE | c_out_S_save[2]);
    c_out_S_save[3]  <= (c_out_S  ? 0 : ff_c_out_E  | c_out_S_save[3]);
    c_out_S_save[4]  <= (c_out_S  ? 0 : ff_c_out_SE | c_out_S_save[4]);
    c_out_S_save[5]  <= (c_out_S  ? 0 : ff_c_out_S  | c_out_S_save[5]);
    c_out_S_save[6]  <= (c_out_S  ? 0 : ff_c_out_SW | c_out_S_save[6]);
    c_out_S_save[7]  <= (c_out_S  ? 0 : ff_c_out_W  | c_out_S_save[7]);
    
    c_out_W_save[0]  <= (c_out_W  ? 0 : ff_c_out_NW | c_out_W_save[0]);
    c_out_W_save[1]  <= (c_out_W  ? 0 : ff_c_out_N  | c_out_W_save[1]);
    c_out_W_save[2]  <= (c_out_W  ? 0 : ff_c_out_NE | c_out_W_save[2]);
    c_out_W_save[3]  <= (c_out_W  ? 0 : ff_c_out_E  | c_out_W_save[3]);
    c_out_W_save[4]  <= (c_out_W  ? 0 : ff_c_out_SE | c_out_W_save[4]);
    c_out_W_save[5]  <= (c_out_W  ? 0 : ff_c_out_S  | c_out_W_save[5]);
    c_out_W_save[6]  <= (c_out_W  ? 0 : ff_c_out_SW | c_out_W_save[6]);
    c_out_W_save[7]  <= (c_out_W  ? 0 : ff_c_out_W  | c_out_W_save[7]);
  end
end



assign c_out_NW = (select_NW[0] ? c_out_NW_save[0] | ff_c_out_NW : 1) &
                  (select_NW[1] ? c_out_NW_save[1] | ff_c_out_N  : 1) &
                  (select_NW[2] ? c_out_NW_save[2] | ff_c_out_NE : 1) &
                  (select_NW[3] ? c_out_NW_save[3] | ff_c_out_E  : 1) &
                  (select_NW[4] ? c_out_NW_save[4] | ff_c_out_SE : 1) &
                  (select_NW[5] ? c_out_NW_save[5] | ff_c_out_S  : 1) &
                  (select_NW[6] ? c_out_NW_save[6] | ff_c_out_SW : 1) &
                  (select_NW[7] ? c_out_NW_save[7] | ff_c_out_W  : 1);

assign c_out_N  = (select_N[0]  ? c_out_N_save[0]  | ff_c_out_NW : 1) &
                  (select_N[1]  ? c_out_N_save[1]  | ff_c_out_N  : 1) &
                  (select_N[2]  ? c_out_N_save[2]  | ff_c_out_NE : 1) &
                  (select_N[3]  ? c_out_N_save[3]  | ff_c_out_E  : 1) &
                  (select_N[4]  ? c_out_N_save[4]  | ff_c_out_SE : 1) &
                  (select_N[5]  ? c_out_N_save[5]  | ff_c_out_S  : 1) &
                  (select_N[6]  ? c_out_N_save[6]  | ff_c_out_SW : 1) &
                  (select_N[7]  ? c_out_N_save[7]  | ff_c_out_W  : 1);

assign c_out_E  = (select_E[0]  ? c_out_E_save[0]  | ff_c_out_NW : 1) &
                  (select_E[1]  ? c_out_E_save[1]  | ff_c_out_N  : 1) &
                  (select_E[2]  ? c_out_E_save[2]  | ff_c_out_NE : 1) &
                  (select_E[3]  ? c_out_E_save[3]  | ff_c_out_E  : 1) &
                  (select_E[4]  ? c_out_E_save[4]  | ff_c_out_SE : 1) &
                  (select_E[5]  ? c_out_E_save[5]  | ff_c_out_S  : 1) &
                  (select_E[6]  ? c_out_E_save[6]  | ff_c_out_SW : 1) &
                  (select_E[7]  ? c_out_E_save[7]  | ff_c_out_W  : 1);

assign c_out_S  = (select_S[0]  ? c_out_S_save[0]  | ff_c_out_NW : 1) &
                  (select_S[1]  ? c_out_S_save[1]  | ff_c_out_N  : 1) &
                  (select_S[2]  ? c_out_S_save[2]  | ff_c_out_NE : 1) &
                  (select_S[3]  ? c_out_S_save[3]  | ff_c_out_E  : 1) &
                  (select_S[4]  ? c_out_S_save[4]  | ff_c_out_SE : 1) &
                  (select_S[5]  ? c_out_S_save[5]  | ff_c_out_S  : 1) &
                  (select_S[6]  ? c_out_S_save[6]  | ff_c_out_SW : 1) &
                  (select_S[7]  ? c_out_S_save[7]  | ff_c_out_W  : 1);

assign c_out_W  = (select_W[0]  ? c_out_W_save[0]  | ff_c_out_NW : 1) &
                  (select_W[1]  ? c_out_W_save[1]  | ff_c_out_N  : 1) &
                  (select_W[2]  ? c_out_W_save[2]  | ff_c_out_NE : 1) &
                  (select_W[3]  ? c_out_W_save[3]  | ff_c_out_E  : 1) &
                  (select_W[4]  ? c_out_W_save[4]  | ff_c_out_SE : 1) &
                  (select_W[5]  ? c_out_W_save[5]  | ff_c_out_S  : 1) &
                  (select_W[6]  ? c_out_W_save[6]  | ff_c_out_SW : 1) &
                  (select_W[7]  ? c_out_W_save[7]  | ff_c_out_W  : 1);



//////////////////////////////////////////
//
//  
//
//////////////////////////////////////////

endmodule
