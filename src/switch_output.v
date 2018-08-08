//switch_output.v
//
// one DySER switch output
//
`include "config_5x5.v"


module switch_output(
    /* inputs */
    d_in_NW,
    d_in_N,
    d_in_E,
    d_in_W,
    d_in_S,
    conf,
    /* outputs */
    d_out,
    select_NW, // Is NW input data being used?
    select_N,
    select_E,
    select_W,
    select_S
    );


input  [`PATH_WIDTH:0] d_in_NW;
input  [`PATH_WIDTH:0] d_in_N;
input  [`PATH_WIDTH:0] d_in_E;
input  [`PATH_WIDTH:0] d_in_W;
input  [`PATH_WIDTH:0] d_in_S;

input            [3:0] conf;


output [`PATH_WIDTH:0] d_out;
output                 select_NW;
output                 select_N;
output                 select_E;
output                 select_W;
output                 select_S;



///////////////////////////////////////////
//
//    wires
//
//////////////////////////////////////////

wire   [`PATH_WIDTH:0] data1;



//////////////////////////////////////////
//
//    data mux - first level
//
//////////////////////////////////////////

// At the moment this is a 16->1 MUX 
// It can be optimized manually to a 8->1 MUX there are 
// only 5 "real" inputs
// There reason is not done is that the Xilinx optimizer 
// does this automatically
assign data1 = (conf[3:0] == 4'b0000 ? {`PATH_WIDTH{1'b0}} : // turned off
                conf[3:0] == 4'b0001 ? d_in_NW :
                conf[3:0] == 4'b0010 ? d_in_E  :
                conf[3:0] == 4'b0011 ? d_in_N  :
                conf[3:0] == 4'b0100 ? d_in_S  :
                conf[3:0] == 4'b0101 ? d_in_NW :
                conf[3:0] == 4'b0110 ? d_in_E  :
                conf[3:0] == 4'b0111 ? d_in_N  :
                conf[3:0] == 4'b1000 ? d_in_W  :
                conf[3:0] == 4'b1001 ? d_in_NW :
                conf[3:0] == 4'b1010 ? d_in_E  :
                conf[3:0] == 4'b1011 ? d_in_N  :
                conf[3:0] == 4'b1100 ? d_in_S  :
                conf[3:0] == 4'b1101 ? d_in_NW :
                conf[3:0] == 4'b1110 ? d_in_E  :
              /*conf[3:0] == 4'b1111*/ d_in_N);

//////////////////////////////////////////
//
//    data inputs being selected
//
//////////////////////////////////////////

assign select_NW = (conf[3:0] == 4'b0001) |
                   (conf[3:0] == 4'b0101) |
                   (conf[3:0] == 4'b1001) |
                   (conf[3:0] == 4'b1101) |
                   (conf[3:0] == 4'b1110);

assign select_N  = (conf[3:0] == 4'b0011) |
                   (conf[3:0] == 4'b0111) |
                   (conf[3:0] == 4'b1011) |
                   (conf[3:0] == 4'b1101) |
                   (conf[3:0] == 4'b1111);

assign select_E  = (conf[3:0] == 4'b0010) |
                   (conf[3:0] == 4'b0110) |
                   (conf[3:0] == 4'b1010) |
                   (conf[3:0] == 4'b1110) |
                   (conf[3:0] == 4'b1111);

assign select_W  = (conf[3:0] == 4'b1000) |
                   (conf[3:0] == 4'b1001) |
                   (conf[3:0] == 4'b1010) |
                   (conf[3:0] == 4'b1011) |
                   (conf[3:0] == 4'b1100);

assign select_S  = (conf[3:0] == 4'b0100) |
                   (conf[3:0] == 4'b0101) |
                   (conf[3:0] == 4'b0110) |
                   (conf[3:0] == 4'b0111) |
                   (conf[3:0] == 4'b1100);


//////////////////////////////////////////
//
//    data mux - second level
//
//////////////////////////////////////////

assign d_out = data1;



//////////////////////////////////////////
//
//  
//
//////////////////////////////////////////

endmodule
