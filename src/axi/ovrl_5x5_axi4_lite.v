`define IDLE  2'b00
`define CONF  2'b01
`define CALC  2'b11

`define IDLE            2'b00
`define START_COUNTING  2'b01
`define WAIT_COMPLETION 2'b10

`define FIFO_ADDR_0		32'h43c3_005c
`define FIFO_ADDR_1		32'h43c3_0060

`timescale 1 ns / 1 ps

module ovrl_5x5_axi4_lite #
	(
	// Users to add parameters here

	// User parameters ends
	// Do not modify the parameters beyond this line

	// Width of S_AXI data bus
	parameter integer C_S_AXI_DATA_WIDTH	= 32,
	// Width of S_AXI address bus
	parameter integer C_S_AXI_ADDR_WIDTH	= 32
	)
	(
	// Users to add ports here
    	output wire [4:0] out_port0,
	output wire [4:0] out_port1,
    	output wire conf_en,
    	output wire wr_en_ovrl,
    	output wire out_en_ovrl0,
	output wire out_en_ovrl1,
    	input wire done0,
	input wire done1,
    	input wire [31:0] ovrl_res0,
	input wire [31:0] ovrl_res1,
		
		/* DEBUD REGISTERS    */
        input wire [31:0] dbg0,
        input wire [31:0] dbg1,
        input wire [31:0] data_dbg00,
        input wire [31:0] data_dbg10,
        input wire [31:0] data_dbg01,
        input wire [31:0] data_dbg11,
        input wire [31:0] data_dbg02,
        input wire [31:0] data_dbg12,
        input wire [31:0] cycles,
        output wire [31:0] cpu_poll,
        /* END OF DEBUG REGISTERS*/
		
		
	// User ports ends
	// Do not modify the ports beyond this line

	// Global Clock Signal
	input wire  S_AXI_ACLK,
	// Global Reset Signal. This Signal is Active LOW
	input wire  S_AXI_ARESETN,
	// Write address (issued by master, acceped by Slave)
	input wire [C_S_AXI_ADDR_WIDTH-1 : 0] S_AXI_AWADDR,
	// Write channel Protection type. This signal indicates the
	// privilege and security level of the transaction, and whether
	// the transaction is a data access or an instruction access.
	input wire [2 : 0] S_AXI_AWPROT,
	// Write address valid. This signal indicates that the master signaling
	// valid write address and control information.
	input wire  S_AXI_AWVALID,
	// Write address ready. This signal indicates that the slave is ready
	// to accept an address and associated control signals.
	output wire  S_AXI_AWREADY,
	// Write data (issued by master, acceped by Slave) 
	input wire [C_S_AXI_DATA_WIDTH-1 : 0] S_AXI_WDATA,
	// Write strobes. This signal indicates which byte lanes hold
	// valid data. There is one write strobe bit for each eight
	// bits of the write data bus.    
	input wire [(C_S_AXI_DATA_WIDTH/8)-1 : 0] S_AXI_WSTRB,
	// Write valid. This signal indicates that valid write
	// data and strobes are available.
	input wire  S_AXI_WVALID,
	// Write ready. This signal indicates that the slave
	// can accept the write data.
	output wire  S_AXI_WREADY,
	// Write response. This signal indicates the status
	// of the write transaction.
	output wire [1 : 0] S_AXI_BRESP,
	// Write response valid. This signal indicates that the channel
	// is signaling a valid write response.
	output wire  S_AXI_BVALID,
	// Response ready. This signal indicates that the master
	// can accept a write response.
	input wire  S_AXI_BREADY,
	// Read address (issued by master, acceped by Slave)
	input wire [C_S_AXI_ADDR_WIDTH-1 : 0] S_AXI_ARADDR,
	// Protection type. This signal indicates the privilege
	// and security level of the transaction, and whether the
	// transaction is a data access or an instruction access.
	input wire [2 : 0] S_AXI_ARPROT,
	// Read address valid. This signal indicates that the channel
	// is signaling valid read address and control information.
	input wire  S_AXI_ARVALID,
	// Read address ready. This signal indicates that the slave is
	// ready to accept an address and associated control signals.
	output wire  S_AXI_ARREADY,
	// Read data (issued by slave)
	output wire [C_S_AXI_DATA_WIDTH-1 : 0] S_AXI_RDATA,
	// Read response. This signal indicates the status of the
	// read transfer.
	output wire [1 : 0] S_AXI_RRESP,
	// Read valid. This signal indicates that the channel is
	// signaling the required read data.
	output wire  S_AXI_RVALID,
	// Read ready. This signal indicates that the master can
	// accept the read data and response information.
	input wire  S_AXI_RREADY
	);

	// AXI4LITE signals
	reg [C_S_AXI_ADDR_WIDTH-1 : 0] 	axi_awaddr;
	reg  	axi_awready;
	reg  	axi_wready;
	reg [1 : 0] 	axi_bresp;
	reg  	axi_bvalid;
	reg [C_S_AXI_ADDR_WIDTH-1 : 0] 	axi_araddr;
	reg  	axi_arready;
	reg [C_S_AXI_DATA_WIDTH-1 : 0] 	axi_rdata;
	reg [1 : 0] 	axi_rresp;
	reg  	axi_rvalid;

	// Example-specific design signals
	// local parameter for addressing 32 bit / 64 bit C_S_AXI_DATA_WIDTH
	// ADDR_LSB is used for addressing 32/64 bit registers/memories
	// ADDR_LSB = 2 for 32 bits (n downto 2)
	// ADDR_LSB = 3 for 64 bits (n downto 3)
	localparam integer ADDR_LSB = (C_S_AXI_DATA_WIDTH/32) + 1;
	localparam integer OPT_MEM_ADDR_BITS = 1;
	//----------------------------------------------
	//-- Signals for user logic register space example
	//------------------------------------------------
	//-- Number of Slave Registers 4
	reg [C_S_AXI_DATA_WIDTH-1:0]	ctrl_reg;
	reg [C_S_AXI_DATA_WIDTH-1:0]	status_reg;
	wire	 slv_reg_rden;
	wire	 slv_reg_wren;
	reg [C_S_AXI_DATA_WIDTH-1:0]	 reg_data_out;
	integer	 byte_index;
    
   
	reg [1:0] state;
	reg [1:0] counter_state;
	reg [31:0] debug;
	reg wr_en;
	reg conf_wr_en;
	reg out_port_en0;
	reg out_port_en1;
	reg [31:0] latency_counter;
	reg [31:0] throughtput_counter;
	//reg [31:0] dyser_out;

	wire [31:0] d_out0;
	//wire done0;
	//wire done1;
	wire empty;
	wire d_out0_en;
	wire mem_wren;
	wire mem_rden;
	wire [31:0] fifo_out0;
	wire [31:0] fifo_out1;
   

	// I/O Connections assignments

	assign S_AXI_AWREADY	= axi_awready;
	assign S_AXI_WREADY	= axi_wready;
	assign S_AXI_BRESP	= axi_bresp;
	assign S_AXI_BVALID	= axi_bvalid;
	assign S_AXI_ARREADY	= axi_arready;
	assign S_AXI_RDATA	= axi_rdata;
	assign S_AXI_RRESP	= axi_rresp;
	assign S_AXI_RVALID	= axi_rvalid;
	// Implement axi_awready generation
	// axi_awready is asserted for one S_AXI_ACLK clock cycle when both
	// S_AXI_AWVALID and S_AXI_WVALID are asserted. axi_awready is
	// de-asserted when reset is low.

	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      axi_awready <= 1'b0;
	    end 
	  else
	    begin    
	      if (~axi_awready && S_AXI_AWVALID && S_AXI_WVALID)
	        begin
	          // slave is ready to accept write address when 
	          // there is a valid write address and write data
	          // on the write address and data bus. This design 
	          // expects no outstanding transactions. 
	          axi_awready <= 1'b1;
	        end
	      else           
	        begin
	          axi_awready <= 1'b0;
	        end
	    end 
	end       

	// Implement axi_awaddr latching
	// This process is used to latch the address when both 
	// S_AXI_AWVALID and S_AXI_WVALID are valid. 

	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      axi_awaddr <= 0;
	    end 
	  else
	    begin    
	      if (~axi_awready && S_AXI_AWVALID && S_AXI_WVALID)
	        begin
	          // Write Address latching 
	          axi_awaddr <= S_AXI_AWADDR;
	        end
	    end 
	end       

	// Implement axi_wready generation
	// axi_wready is asserted for one S_AXI_ACLK clock cycle when both
	// S_AXI_AWVALID and S_AXI_WVALID are asserted. axi_wready is 
	// de-asserted when reset is low. 

	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      axi_wready <= 1'b0;
	    end 
	  else
	    begin    
	      if (~axi_wready && S_AXI_WVALID && S_AXI_AWVALID)
	        begin
	          // slave is ready to accept write data when 
	          // there is a valid write address and write data
	          // on the write address and data bus. This design 
	          // expects no outstanding transactions. 
	          axi_wready <= 1'b1;
	        end
	      else
	        begin
	          axi_wready <= 1'b0;
	        end
	    end 
	end       

	// Implement memory mapped register select and write logic generation
	// The write data is accepted and written to memory mapped registers when
	// axi_awready, S_AXI_WVALID, axi_wready and S_AXI_WVALID are asserted. Write strobes are used to
	// select byte enables of slave registers while writing.
	// These registers are cleared when reset (active low) is applied.
	// Slave register write enable is asserted when valid address and data are available
	// and the slave is ready to accept the write address and write data.
	assign slv_reg_wren = axi_wready && S_AXI_WVALID && axi_awready && S_AXI_AWVALID;

	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      ctrl_reg   <= 0;
	    end 
	  /* else if (state == `READY) 
	    begin
	      ctrl_reg <= 32'h0000_0000; 
	    end */
	  else begin
	    if (slv_reg_wren)
	      begin
	        case ( axi_awaddr[7:0] )
	          8'h50:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 0
	                ctrl_reg[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          default : begin
	                      ctrl_reg   <= ctrl_reg;
	                    end
	        endcase
	      end
	  end
	end    

	// Implement write response logic generation
	// The write response and response valid signals are asserted by the slave 
	// when axi_wready, S_AXI_WVALID, axi_wready and S_AXI_WVALID are asserted.  
	// This marks the acceptance of address and indicates the status of 
	// write transaction.

	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      axi_bvalid  <= 0;
	      axi_bresp   <= 2'b0;
	    end 
	  else
	    begin    
	      if (axi_awready && S_AXI_AWVALID && ~axi_bvalid && axi_wready && S_AXI_WVALID)
	        begin
	          // indicates a valid write response is available
	          axi_bvalid <= 1'b1;
	          axi_bresp  <= 2'b0; // 'OKAY' response 
	        end                   // work error responses in future
	      else
	        begin
	          if (S_AXI_BREADY && axi_bvalid) 
	            //check if bready is asserted while bvalid is high) 
	            //(there is a possibility that bready is always asserted high)   
	            begin
	              axi_bvalid <= 1'b0; 
	            end  
	        end
	    end
	end   

	// Implement axi_arready generation
	// axi_arready is asserted for one S_AXI_ACLK clock cycle when
	// S_AXI_ARVALID is asserted. axi_awready is 
	// de-asserted when reset (active low) is asserted. 
	// The read address is also latched when S_AXI_ARVALID is 
	// asserted. axi_araddr is reset to zero on reset assertion.

	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      axi_arready <= 1'b0;
	      axi_araddr  <= 32'b0;
	    end 
	  else
	    begin    
	      if (~axi_arready && S_AXI_ARVALID)
	        begin
	          // indicates that the slave has acceped the valid read address
	          axi_arready <= 1'b1;
	          // Read address latching
	          axi_araddr  <= S_AXI_ARADDR;
	        end
	      else
	        begin
	          axi_arready <= 1'b0;
	        end
	    end 
	end       

	// Implement axi_arvalid generation
	// axi_rvalid is asserted for one S_AXI_ACLK clock cycle when both 
	// S_AXI_ARVALID and axi_arready are asserted. The slave registers 
	// data are available on the axi_rdata bus at this instance. The 
	// assertion of axi_rvalid marks the validity of read data on the 
	// bus and axi_rresp indicates the status of read transaction.axi_rvalid 
	// is deasserted on reset (active low). axi_rresp and axi_rdata are 
	// cleared to zero on reset (active low).  
	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      axi_rvalid <= 0;
	      axi_rresp  <= 0;
	    end 
	  else
	    begin    
	      if (axi_arready && S_AXI_ARVALID && ~axi_rvalid)
	        begin
	          // Valid read data is available at the read data bus
	          axi_rvalid <= 1'b1;
	          axi_rresp  <= 2'b0; // 'OKAY' response
	        end   
	      else if (axi_rvalid && S_AXI_RREADY)
	        begin
	          // Read data is accepted by the master
	          axi_rvalid <= 1'b0;
	        end                
	    end
	end    

	// Implement memory mapped register select and read logic generation
	// Slave register read enable is asserted when valid address is available
	// and the slave is ready to accept the read address.
	assign slv_reg_rden = axi_arready & S_AXI_ARVALID & ~axi_rvalid;
	always @(*)
	begin
	      // Address decoding for reading registers
	      case (axi_araddr[7:0])
		8'h50   : reg_data_out <= ctrl_reg;
		8'h54   : reg_data_out <= status_reg;
		8'h5c   : reg_data_out <= fifo_out0;
		8'h60   : reg_data_out <= fifo_out1;
		8'h64   : reg_data_out <= latency_counter;
		8'h68   : reg_data_out <= dbg0;
		8'h6c   : reg_data_out <= dbg1;
		8'h70   : reg_data_out <= data_dbg00;
		8'h74   : reg_data_out <= data_dbg01;
		8'h78   : reg_data_out <= data_dbg02;
		8'h84   : reg_data_out <= data_dbg10;
		8'h88   : reg_data_out <= data_dbg11;
		8'h8c   : reg_data_out <= data_dbg12;
		8'h98   : reg_data_out <= cycles;
	        default : reg_data_out <= 0;
	      endcase
	end

	// Output register or memory read data
	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      axi_rdata  <= 0;
	    end 
	  else
	    begin    
	      // When there is a valid read address (S_AXI_ARVALID) with 
	      // acceptance of read address by the slave (axi_arready), 
	      // output the read dada 
	      if (slv_reg_rden)
	        begin
	          axi_rdata <= reg_data_out;     // register read data
	        end   
	    end
	end    

	// Add user logic here
	assign cpu_poll = status_reg;
	assign wr_en_ovrl = wr_en;
	assign conf_en = conf_wr_en;
	assign out_port0 = ctrl_reg[20:16];
	assign out_port1 = ctrl_reg[28:24];
	assign out_en_ovrl0 = out_port_en0;
	assign out_en_ovrl1 = out_port_en1;
	
	fifo_dyser_out#(0) f0(
                //      INPUTS
                .d_in(ovrl_res0), 
                .enq(done0), 
                .deq(axi_araddr == FIFO_ADDR_0 && S_AXI_RVALID), 
                .clk(S_AXI_ACLK), 
                .rst(~S_AXI_ARESETN),
                //      OUTPUTS
                .d_out(fifo_out0),
                .empty(empty0),
                .valid(),
                .busy(),
                .c_out()
                );

	fifo_dyser_out#(1) f1(
                //      INPUTS
                .d_in(ovrl_res1), 
                .enq(done1), 
                .deq(axi_araddr == FIFO_ADDR_1 && S_AXI_RVALID), 
                .clk(S_AXI_ACLK), 
                .rst(~S_AXI_ARESETN),
                //      OUTPUTS
                .d_out(fifo_out1),
                .empty(empty1),
                .valid(),
                .busy(),
                .c_out()
                );


	always@(posedge S_AXI_ACLK)
    	begin
        if(S_AXI_ARESETN == 1'b0) begin
		state <= `IDLE;
		wr_en <= 1'b0;
		conf_wr_en <= 1'b0;
		state <= 2'b00;
		out_port_en0 <= 1'b0;
		out_port_en1 <= 1'b0;
		status_reg <= 32'h0000_0000;   
        end else begin
            
            case(state)
                    
                `IDLE: begin
                    if(ctrl_reg[1:0] == 2'b01) begin
                        state <= `CONF;
                        conf_wr_en <= 1'b1;
			out_port_en0 <= 1'b0;
			out_port_en1 <= 1'b0;
                    end
                end
                        
                `CONF: begin
                
                    if(ctrl_reg[1:0] == 2'b00) begin
                        state <= `IDLE;
                        wr_en <= 1'b0;
                        conf_wr_en <= 1'b0;
                    end if(ctrl_reg[1:0] == 2'b10) begin
                        state <= `CALC;
                        conf_wr_en <= 1'b0;
                        wr_en <= 1'b1;
			out_port_en0 <= ctrl_reg[2];
			out_port_en1 <= ctrl_reg[3];
                    end
                end
                        
                `CALC: begin
		    
                    if(ctrl_reg[3:2] == 2'b11) begin

                        if(empty0 == 1'b0 && empty1 == 1'b0)begin
                        	status_reg <= 32'h0000_0001;
                    	end else begin
                        	status_reg <= 32'h0000_0000;
                    	end
		    end else if(empty0 == 1'b0) begin
                        status_reg <= 32'h0000_0001;
                    end else begin
                        status_reg <= 32'h0000_0000;
                    end 
        
                    if(ctrl_reg[1:0] == 2'b00) begin
                        state <= `IDLE;
                        wr_en <= 1'b0;
                        conf_wr_en <= 1'b0;
                    end
                 end
                        
            endcase    
                        
        end
    end

// User logic ends

endmodule
