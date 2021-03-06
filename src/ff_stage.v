// ff_stage.v
//
// DySER flip-flop stage
//
`include "config_5x5.v"

module ff_stage(
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


parameter                ID = 0;
parameter                EDGE = 0;

input                    valid_in;
input                    credit_in;
input  [`PATH_WIDTH-1:0] data_in;
input                    clk;
input                    rst;
input                    done;

output                   credit_out;
output [`PATH_WIDTH-1:0] data_out;
output                   valid_out;


///////////////////////////////////////////////////
//
//    wires
//
//////////////////////////////////////////////////

reg                      credit_out;
reg    [`PATH_WIDTH-1:0] data_out;
reg                      valid_out;

reg                [1:0] state;
reg                      done_save; // Used for remembering the 'done' signal when still waiting for a credit


///////////////////////////////////////////////////
//
//  states: 00: credit-no valid  01: valid-no credit
//          10: processing       11: idle
//
//////////////////////////////////////////////////


always @(posedge clk)
begin: FSM
  if (rst == 1'b1) begin
    done_save  <= 0;
    data_out   <= 0;
    credit_out <= 1'b0;
    valid_out  <= 1'b0;
    state      <= 2'b00;
    //$display("ID:%3d  RESET", ID);
  end
  else
  begin
    //$display("ID:%3d  ff_stage STATE:%b  DATA:%0d (V:%b C:%b)", ID, {state[1:0], valid_in, credit_in, done}, data_in, valid_out, credit_out);
    casez({state[1:0], valid_in, credit_in, done | done_save})
    // 00: credit-no valid
    5'b00_0??: // remain in credit-no valid state
      begin
        valid_out  <= 1'b0;
        credit_out <= (EDGE ? 1'b0 : 1'b0);
        state      <= 2'b00; // credit-no valid
      end
    5'b00_1?0: // valid and not done, go to processing state
      begin
        valid_out  <= 1'b0;
        credit_out <= 1'b0;
        state      <= 2'b10; // processing
        data_out   <= data_in;
      end
    5'b00_101: // valid and done in one cycle, go to idle
      begin
        valid_out  <= 1'b1;
        credit_out <= 1'b1;
        state      <= 2'b11; // idle
        data_out   <= data_in;
        done_save  <= 1'b0;
      end
    5'b00_111: // valid and done in one cycle, and received a new credit, stay in credit-no valid
      begin
        valid_out  <= 1'b1;
        credit_out <= 1'b1;
        state      <= 2'b00; // credit-no valid
        data_out   <= data_in;
        done_save  <= 1'b0;
      end
    // 01: valid-no credit
    5'b01_1?0: // have valid data and waiting on a credit, should not be getting sent more valid data
      begin
        //$display("[ID:%3d] ERROR(FF:011?0) == why are we getting sent VALID data when not ready??", ID);
      end
    5'b01_101: // functional unit ff_stage specific (multi-cycle compute with no credit yet)
      begin
        valid_out  <= 1'b0;
        credit_out <= 1'b0;
        state      <= 2'b01; // valid-no credit
        data_out   <= data_in;
        done_save  <= 1'b1; // computation is done, but still waiting for credit
        // This is probably considered an error for SWITCH ff_stages, but not FUNCTIONAL_UNIT ff_stages
        //$display("[ID:%3d] ERROR(FF:01101) == why are we getting sent VALID data when not ready??", ID);
      end
    5'b01_000: // remain in valid-no credit state
      begin
        valid_out  <= 1'b0;
        credit_out <= 1'b0;
        state      <= 2'b01; // valid-no credit
      end
    5'b01_001: // remain in valid-no credit state
      begin
        valid_out  <= 1'b0;
        credit_out <= 1'b0;
        state      <= 2'b01; // valid-no credit
        // Done signal but no valid signal, we probably shouldn't grab the data then
        //$display("[ID:%3d] (FF:01001) should I grab this data?", ID);
      end
    5'b01_010: // credit and not done, go to processing state
      begin
        valid_out  <= 1'b0;
        credit_out <= 1'b0;
        state      <= 2'b10; // processing
      end
    5'b01_011: // credit and done in one cycle, go to idle
      begin
        valid_out  <= 1'b1;
        credit_out <= 1'b1;
        state      <= 2'b11; // idle
        done_save  <= 1'b0;
        // 
        //$display("[ID:%3d] (FF:01011) this should only happen for switches", ID);
      end
    5'b01_111: // credit and done in one cycle, go to idle
      begin
        valid_out  <= 1'b1;
        credit_out <= 1'b1;
        state      <= 2'b11; // idle
        data_out   <= data_in;
        done_save  <= 1'b0;
        // Should SWITCHES go to 2'b01 ??  probably not, shouldn't be getting sent valid data before sending out a credit
        //$display("[ID:%3d] (FF:01111) this should only happen for functional_units", ID);
      end
    // 10: process state
    5'b10_1?0: // valid but not done?  getting sent unfinished result
      begin
        //$display("[ID:%3d] ERROR(FF:101?0) == why are we getting sent VALID data when not DONE??", ID);
      end
    5'b10_0?0: // not done, continue processing
      begin
        valid_out  <= 1'b0;
        credit_out <= 1'b0;
        state      <= 2'b10; // processing
      end
    5'b10_0?1: // done?
      begin
        //$display("[ID:%3d] ERROR(FF:100?1) == why aren't we getting sent VALID data when DONE processing??", ID);
      end
    5'b10_101: //done!
      begin
        valid_out  <= 1'b1;
        credit_out <= 1'b1;
        state      <= 2'b11; // idle
        data_out   <= data_in;
        done_save  <= 1'b0;
      end
    5'b10_111: // done! and received a fresh credit
      begin
        valid_out  <= 1'b1;
        credit_out <= 1'b1;
        state      <= 2'b00; // credit-no valid
        data_out   <= data_in;
        done_save  <= 1'b0;
      end
    // 11: idle state
    5'b11_00?: // remain in idle
      begin
        valid_out  <= 1'b0;
        credit_out <= (EDGE ? 1'b0 : 1'b0);
        state      <= 2'b11; // idle
      end
    5'b11_01?: // credit but no valid
      begin
        valid_out  <= 1'b0;
        credit_out <= (EDGE ? 1'b0 : 1'b0);
        state      <= 2'b00; // credit-no valid
      end
    5'b11_10?: // valid, but no credit
      begin
        valid_out  <= 1'b0;
        credit_out <= 1'b0;
        state      <= 2'b01; // valid-no credit
        data_out   <= data_in;
        done_save  <= done;
      end
    5'b11110:  // credit, valid, but not done, go to process state
      begin
        valid_out  <= 1'b0;
        credit_out <= 1'b0;
        state      <= 2'b10; // processing
        data_out   <= data_in;
      end
    5'b11111:  // credit, valid, and done in one cycle
      begin
        valid_out  <= 1'b1;
        credit_out <= 1'b1;
        state      <= 2'b11; // idle
        data_out   <= data_in;
        done_save  <= 1'b0;
      end
    default:
      begin
        //$display("ERR: ID:%3d  ff_stage STATE:%b  DATA:%0d", ID, {state[1:0], valid_in, credit_in, done}, data_in);
      end
    endcase
  end
end
endmodule
