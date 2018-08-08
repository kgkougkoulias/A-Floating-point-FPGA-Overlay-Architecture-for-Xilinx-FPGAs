// ff_stage.v
//
//
`include "config_5x5.v"

module fu_stage(
    /* inputs */
    valid_in,
    credit_in,
    data_in,
    done,
    clk,
    rst,
    
    /* outputs */
    credit_out,
    data_out,
    valid_out
    );


parameter          ID = 0;
parameter          BITS = `PATH_BITS;

input              valid_in;
input              credit_in;
input   [BITS-1:0] data_in;
input              clk;
input              rst;
input              done;

output             credit_out;
output  [BITS-1:0] data_out;
output             valid_out;


///////////////////////////////////////////////////
//
//    wires
//
//////////////////////////////////////////////////

reg                credit_out;
reg     [BITS-1:0] data_out;
reg                valid_out;

reg          [1:0] state;


///////////////////////////////////////////////////
//
//  states: 00: credit-no valid  01: valid-no credit
//          10: processing       11: idle
//
//////////////////////////////////////////////////


always @(posedge clk)
begin: FSM
  if (rst==1'b1) begin
    data_out   <= 0;
    credit_out <= 1'b0;
    valid_out  <= 1'b0;
    state      <= 2'b00;
    //$display("ID:%3d  RESET", ID);
  end
  else
  begin
    //$display("ID:%3d  fu_stage STATE:%b  DATA:%0d (V:%b C:%b)", ID, {state[1:0], valid_in, credit_in, done}, data_in, valid_out, credit_out); //[REMOVE]
    casez({state[1:0], valid_in, credit_in, done})
    // 00: credit-no valid
    5'b00_??1:
      begin
        //$display("[ID:%3d] ERROR(FU:00??1) -- why are we done when nothing was processing??", ID);
      end
    5'b00_0?0: // remain in credit-no valid state
      begin
        valid_out  <= 1'b0;
        credit_out <= 1'b0;
        state      <= 2'b00;
      end
    5'b00_1?0: // valid and not done, go to processing state
      begin
        valid_out  <= 1'b1;
        credit_out <= 1'b0;
        state      <= 2'b10; // processing
        data_out   <= data_in;
      end
    // 01: valid-no credit
    5'b01_1??:
      begin
        //$display("[ID:%3d] ERROR(FU:011??) -- why are we getting sent VALID data when not ready??", ID);
      end
    5'b01_0?1:
      begin
        //$display("[ID:%3d] ERROR(FU:010?1) -- why are we done when nothing was processing??", ID);
      end
    5'b01_000: // remain in valid-no credit state
      begin
        valid_out  <= 1'b0;
        credit_out <= 1'b0;
        state      <= 2'b01; // valid-no credit
      end
    5'b01_010: // credit and not done, go to processing state
      begin
        valid_out  <= 1'b1;
        credit_out <= 1'b0;
        state      <= 2'b10; // processing
      end
    // 10: processing state
    5'b10_1?0: 
      begin
        //$display("[ID:%3d] ERROR(FU:101?0) -- why are we getting sent VALID data when not ready??", ID);
      end
    5'b10_0?0: // stay in processing
      begin
        valid_out  <= 1'b1;
        credit_out <= 1'b0;
        state      <= 2'b10; // processing
      end
    5'b10_001: // done!
      begin
        valid_out  <= 1'b0;
        credit_out <= 1'b1;
        state      <= 2'b11; // idle
      end
    5'b10_011: // done!
      begin
        valid_out  <= 1'b0;
        credit_out <= 1'b1;
        state      <= 2'b00; // credit-no valid
      end
    5'b10_101: // done!
      begin
        valid_out  <= 1'b0;
        credit_out <= 1'b1;
        state      <= 2'b01; // valid-no credit
        data_out   <= data_in;
      end
    5'b10_111: // done!
      begin
        valid_out  <= 1'b1;
        credit_out <= 1'b1;
        state      <= 2'b10; // processing
        data_out   <= data_in;
      end
    // 11: idle state
    5'b11_??1: // done but no processing?
      begin
        //$display("[ID:%3d] ERROR(FU:11??1) -- why are we done when nothing was processing??", ID);
      end
    5'b11_000: // remain in idle
      begin
        valid_out  <= 1'b0;
        credit_out <= 1'b0;
        state      <= 2'b11; // idle
      end
    5'b11_010: // received a credit
      begin
        valid_out  <= 1'b0;
        credit_out <= 1'b0;
        state      <= 2'b00; // credit-no valid
      end
    5'b11_100: // valid data
      begin
        valid_out  <= 1'b0;
        credit_out <= 1'b0;
        state      <= 2'b01; // valid-no credit
        data_out   <= data_in;
      end
    5'b11_110:  // credit, valid, but not done, go to process state
      begin
        valid_out  <= 1'b1;
        credit_out <= 1'b0;
        state      <= 2'b10; // processing
        data_out   <= data_in;
      end
    default:
      begin
        //$display("ERR: ID:%3d  fu_stage STATE:%b  DATA:%0d", ID, {state[1:0], valid_in, credit_in, done}, data_in);
      end
    endcase
  end
end
endmodule
