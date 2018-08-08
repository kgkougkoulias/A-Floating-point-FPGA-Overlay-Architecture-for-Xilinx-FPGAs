// functional_unit.v
//
// DySER functional unit, includes computational logic, mux and flip-flops
// responsible for computation.
//
`include "config_5x5.v"
`include "floating_point_0_4cyc_sim_netlist.v"
`include "floating_point_mul0_4cyc_sim_netlist.v"
`include "glbl.v"

module functional_unit(
    /* inputs */
    d_in_NW,
    d_in_NE,
    d_in_SE,
    d_in_SW,
    c_in_SE,
    clk,
    rst,
    conf,
    /* outputs */
    c_out_NW,
    c_out_NE,
    c_out_SE,
    c_out_SW,
    d_out_SE
    );


parameter              ID = 0;
parameter              TYPE = 0;

input  [`PATH_WIDTH:0] d_in_NW;
input  [`PATH_WIDTH:0] d_in_NE;
input  [`PATH_WIDTH:0] d_in_SE;
input  [`PATH_WIDTH:0] d_in_SW;
input                  c_in_SE;
input                  clk;
input                  rst;
input           [15:0] conf; // func[15:12] const-enable[11] constant[10:7] right-input[6:5] left-input[4:3] predicate-input[2:1] predicate-invert[0]

output                 c_out_NW;
output                 c_out_NE;
output                 c_out_SE;
output                 c_out_SW;
output [`PATH_WIDTH:0] d_out_SE;

wire                   c_out_NW;
wire                   c_out_NE;
wire                   c_out_SE;
wire                   c_out_SW;


/////////////////////////////////////
//
//    wires
//  
/////////////////////////////////////

reg    [`PATH_WIDTH:0] d_in_c0; // to computational unit input 0
reg    [`PATH_WIDTH:0] d_in_c1; // to computational unit input 1
wire   [`PATH_WIDTH:0] d_in_const; // constant configured
reg              [1:0] d_in_meta; // meta bit  // DEPENDS ON: `META_BITS

wire [`PATH_WIDTH-1:0] d_out_c; // computational unit output
wire                   c_out_ff;
wire                   done;

wire   [`PATH_WIDTH:0] d_out_fu_c0;
wire   [`PATH_WIDTH:0] d_out_fu_c1;
wire             [1:0] d_out_fu_meta;
wire                   c_out_fu_c0;
wire                   c_out_fu_c1;
wire                   c_out_fu_meta;



/////////////////////////////////////
//
//       input mux
//  
/////////////////////////////////////

// conf: 4'bC1C0
// NW: 01   NE: 10
// SW: 00   SE: 11
//  e.g. 4'b1100 => C1=SE, C0=SW
always @(conf[6:3] or d_in_SW or d_in_NW or d_in_NE or d_in_SE) begin  // Only grab in the data if it's valid
  case(conf[6:3])
   4'b0000:
     begin
       d_in_c1  = d_in_SW;
       d_in_c0  = d_in_SW;
     end
   4'b0001:
     begin
       d_in_c1  = d_in_SW;
       d_in_c0  = d_in_NW;
     end
   4'b0010:
     begin
       d_in_c1  = d_in_SW;
       d_in_c0  = d_in_NE;
     end
   4'b0011:
     begin
       d_in_c1  = d_in_SW;
       d_in_c0  = d_in_SE;
     end
   4'b0100:
     begin
       d_in_c1  = d_in_NW;
       d_in_c0  = d_in_SW;
     end
   4'b0101:
     begin
       d_in_c1  = d_in_NW;
       d_in_c0  = d_in_NW;
     end
   4'b0110:
     begin
       d_in_c1  = d_in_NW;
       d_in_c0  = d_in_NE;
     end
   4'b0111:
     begin
       d_in_c1  = d_in_NW;
       d_in_c0  = d_in_SE;
     end
   4'b1000:
     begin
       d_in_c1  = d_in_NE;
       d_in_c0  = d_in_SW;
     end
   4'b1001:
     begin
       d_in_c1  = d_in_NE;
       d_in_c0  = d_in_NW;
     end
   4'b1010:
     begin
       d_in_c1  = d_in_NE;
       d_in_c0  = d_in_NE;
     end
   4'b1011:
     begin
       d_in_c1  = d_in_NE;
       d_in_c0  = d_in_SE;
     end
   4'b1100:
     begin
       d_in_c1  = d_in_SE;
       d_in_c0  = d_in_SW;
     end
   4'b1101:
     begin
       d_in_c1  = d_in_SE;
       d_in_c0  = d_in_NW;
     end
   4'b1110:
     begin
       d_in_c1  = d_in_SE;
       d_in_c0  = d_in_NE;
     end
   4'b1111:
     begin
       d_in_c1  = d_in_SE;
       d_in_c0  = d_in_SE;
     end
   default:
     begin
       d_in_c1  = 0;
       d_in_c0  = 0;
     end
  endcase
end


// DEPENDS ON: `META_BITS
always @(conf[2:1] or d_in_SW or d_in_NW or d_in_NE or d_in_SE) begin
	case (conf[2:1])
	  2'b00:
	 	  d_in_meta = d_in_SW[1:0];
	  2'b01:
	 	  d_in_meta = d_in_NW[1:0];
	 	2'b10:
	 	  d_in_meta = d_in_NE[1:0];
	  2'b11:
	 	  d_in_meta = d_in_SE[1:0];
	  default:
	 	  d_in_meta = 0;
	endcase
end

// the "constant" only arrives when the other data arrives (valid bits are the same)
assign d_in_const = {{(`DATA_BITS-8){conf[10]}}, conf[10:5], 1'b1, d_in_c0[0]};



// TODO: just make one fu_stage and "3" normal flip-flops
// left-operand
fu_stage #(ID, `PATH_BITS-1) fu0(
    .valid_in(d_in_c0[0]),
    .credit_in(c_out_ff),
    .data_in(d_in_c0[`PATH_WIDTH:1]),
    .done(done),
    .clk(clk),
    .rst(rst),
    .credit_out(c_out_fu_c0),
    .data_out(d_out_fu_c0[`PATH_WIDTH:1]),
    .valid_out(d_out_fu_c0[0]));

/*
// right-operand:  either a constant or arriving data, based on configuration
fu_stage #(ID, `PATH_BITS-1) fu1(
    .valid_in(conf[13] ? d_in_const[0] : d_in_c1[0]),
    .credit_in(c_out_ff),
    .data_in(conf[13] ? d_in_const[`PATH_WIDTH:1] : d_in_c1[`PATH_WIDTH:1]),
    .done(done),
    .clk(clk),
    .rst(rst),
    .credit_out(c_out_fu_c1),
    .data_out(d_out_fu_c1[`PATH_WIDTH:1]),
    .valid_out(d_out_fu_c1[0]));
*/
// right-operand:  either a constant or arriving data, based on configuration
fu_stage #(ID, `PATH_BITS-1) fu1(
    .valid_in(conf[11] ? d_in_const[0] : d_in_c1[0]),
    .credit_in(c_out_ff),
    .data_in(conf[11] ? d_in_const[`PATH_WIDTH:1] : d_in_c1[`PATH_WIDTH:1]),
    .done(done),
    .clk(clk),
    .rst(rst),
    .credit_out(c_out_fu_c1),
    .data_out(d_out_fu_c1[`PATH_WIDTH:1]),
    .valid_out(d_out_fu_c1[0]));


// DEPENDS ON: `META_BITS
fu_stage #(ID, 1) meta(
    .valid_in(d_in_meta[0]),
    .credit_in(c_out_ff),
    .data_in(d_in_meta[1]),
    .done(done),
    .clk(clk),
    .rst(rst),
    .credit_out(c_out_fu_meta),
    .data_out(d_out_fu_meta[1]),
    .valid_out(d_out_fu_meta[0]));


assign c_out_SW = (conf[6:5] == 2'b00 && ~conf[11] && c_out_fu_c1) | // right-input only used if immediate isn't used
                  (conf[4:3] == 2'b00 && c_out_fu_c0) | 
                  (conf[2:1] == 2'b00 && c_out_fu_meta);
assign c_out_NW = (conf[6:5] == 2'b01 && ~conf[11] && c_out_fu_c1) | 
                  (conf[4:3] == 2'b01 && c_out_fu_c0) |
                  (conf[2:1] == 2'b01 && c_out_fu_meta);
assign c_out_NE = (conf[6:5] == 2'b10 && ~conf[11] && c_out_fu_c1) | 
                  (conf[4:3] == 2'b10 && c_out_fu_c0) |
                  (conf[2:1] == 2'b10 && c_out_fu_meta);
assign c_out_SE = (conf[6:5] == 2'b11 && ~conf[11] && c_out_fu_c1) | 
                  (conf[4:3] == 2'b11 && c_out_fu_c0) |
                  (conf[2:1] == 2'b11 && c_out_fu_meta);


/////////////////////////////////////
//
//  to computational logic
//  
/////////////////////////////////////

comp_logic #(TYPE) c0(
    .d_in_c0(d_out_fu_c0[`PATH_WIDTH:0]),
    .d_in_c1(d_out_fu_c1[`PATH_WIDTH:0]),
    .conf(conf[15:12]),
    .clk(clk),
    .rst(rst),
    .d_out(d_out_c[`PATH_WIDTH-1:0]),
    .done(done));



ff_stage #(ID, 0) fo(
    .valid_in(d_out_fu_c0[0] & d_out_fu_c1[0] & d_out_fu_meta[0]),
    .credit_in(c_in_SE),
    .data_in({d_out_c[`PATH_WIDTH-1:1], d_out_fu_meta[1]}), // TODO: what's "correct" meta to use?
    .done(done),
    .clk(clk),
    .rst(rst),
    .credit_out(c_out_ff),
    .data_out(d_out_SE[`PATH_WIDTH:1]),
    .valid_out(d_out_SE[0]));


endmodule
