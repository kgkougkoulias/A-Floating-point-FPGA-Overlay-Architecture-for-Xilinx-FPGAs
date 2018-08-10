
`timescale 1 ns / 1 ps
`include "axi3_master_bfm.sv"


module test_burst_dyser();
		
	integer i;
        // lite inteface
        // data inputs
        reg [31:0] s00_axi_wdata;
        reg [31:0] s00_axi_araddr;
        reg [31:0] s00_axi_awaddr;
        reg [2:0] s00_axi_awprot;
        reg [2:0] s00_axi_arprot;
        reg [3:0] s00_axi_wstrb;
        reg s00_axi_awvalid;
        reg s00_axi_arvalid;
        reg s00_axi_rready;
        reg s00_axi_wvalid;
        reg s00_axi_bready;
        reg clk;
        reg reset;
        // outputs
        wire s00_axi_awready;
        wire s00_axi_wready;
        wire s00_axi_bvalid;
        wire [1:0] s00_axi_bresp;
        wire [1:0] s00_axi_rresp;
        wire s00_axi_arready;
        wire [31:0] s00_axi_rdata; 
        wire s00_axi_rvalid;
        // end of lite interface
        
        
        // full interface
	reg S01_AXI_ACLK;
	reg S01_AXI_ARESETN;
	wire S01_AXI_ARVALID;
	wire S01_AXI_AWVALID;
	wire S01_AXI_BREADY;
	wire S01_AXI_RREADY;
	wire S01_AXI_WLAST;
	wire S01_AXI_WVALID;
	wire S01_AXI_ARID;
	wire S01_AXI_AWID;
	wire [1:0] S01_AXI_ARBURST;
	wire S01_AXI_ARLOCK;
	wire [2:0] S01_AXI_ARSIZE;
	wire [1:0] S01_AXI_AWBURST;
	wire S01_AXI_AWLOCK;
	wire [2:0] S01_AXI_AWSIZE;
	wire [2:0] S01_AXI_ARPROT;
	wire [2:0] S01_AXI_AWPROT;
	wire [31:0] S01_AXI_ARADDR;
	wire [31:0] S01_AXI_AWADDR;
	wire [31:0] S01_AXI_WDATA;
	wire [3:0] S01_AXI_ARCACHE;
	wire [7:0] S01_AXI_ARLEN;
	wire [3:0] S01_AXI_ARQOS;
	wire [3:0] S01_AXI_AWCACHE;
	wire [7:0] S01_AXI_AWLEN;
	wire [3:0] S01_AXI_AWQOS;
	wire [3:0] S01_AXI_WSTRB;
	wire S01_AXI_ARREADY;
	wire S01_AXI_AWREADY;
	wire S01_AXI_BVALID;
	wire S01_AXI_RLAST;
	wire S01_AXI_RVALID;
	wire S01_AXI_WREADY;
	wire S01_AXI_BID;
	wire S01_AXI_RID;
	wire [1:0] S01_AXI_BRESP;
	wire [1:0] S01_AXI_RRESP;
	wire [31:0] S01_AXI_RDATA;
	wire S01_AXI_BUSER;
	reg [3:0] S01_AXI_AWREGION;
	reg S01_AXI_AWUSER;
	reg S01_AXI_WUSER;
	reg [3:0] S01_AXI_ARREGION;
	reg S01_AXI_ARUSER;
	wire S01_AXI_RUSER;
	reg [1:0] bs_response;
	reg [31:0] dout;

	axi3_master_bfm bs( 
   		.ACLK(S01_AXI_ACLK),
   		.ARESETn(~S01_AXI_ARESETN),
   		.ARVALID(S01_AXI_ARVALID),
   		.AWVALID(S01_AXI_AWVALID),
   		.BREADY(S01_AXI_BREADY),
   		.RREADY(S01_AXI_RREADY),
   		.WLAST(S01_AXI_WLAST),
   		.WVALID(S01_AXI_WVALID),
   		.ARID(S01_AXI_ARID),
   		.AWID(S01_AXI_AWID),
   		.WID(),
   		.ARBURST(S01_AXI_ARBURST),
   		.ARLOCK(S01_AXI_ARLOCK),
   		.ARSIZE(S01_AXI_ARSIZE),
   		.AWBURST(S01_AXI_AWBURST),
   		.AWLOCK(S01_AXI_AWLOCK),
   		.AWSIZE(S01_AXI_AWSIZE),
   		.ARPROT(S01_AXI_ARPROT),
   		.AWPROT(S01_AXI_AWPROT),
   		.ARADDR(S01_AXI_ARADDR),
   		.AWADDR(S01_AXI_AWADDR),
   		.WDATA(S01_AXI_WDATA),
   		.ARCACHE(S01_AXI_ARCACHE),
   		.ARLEN(S01_AXI_ARLEN),
   		.ARQOS(S01_AXI_ARQOS),
   		.AWCACHE(S01_AXI_AWCACHE),
   		.AWLEN(S01_AXI_AWLEN),
   		.AWQOS(S01_AXI_AWQOS),
   		.WSTRB(S01_AXI_WSTRB),
   		.ARREADY(S01_AXI_ARREADY),
   		.AWREADY(S01_AXI_AWREADY),
   		.BVALID(S01_AXI_BVALID),
   		.RLAST(S01_AXI_RLAST),
   		.RVALID(S01_AXI_RVALID),
   		.WREADY(S01_AXI_WREADY),
   		.BID(S01_AXI_BID),
   		.RID(S01_AXI_RID),
   		.BRESP(S01_AXI_BRESP),
   		.RRESP(S01_AXI_RRESP),
   		.RDATA(S01_AXI_RDATA)
	);

	ovrl_5x5_top_level#(32, 32, 1, 32, 32, 1, 1, 1, 1, 1) ds0_brs(
	
		// Ports of Axi Slave Bus Interface S00_AXI
		.s00_axi_aclk(S01_AXI_ACLK),
		.s00_axi_aresetn(~S01_AXI_ARESETN),
		.s00_axi_awaddr(s00_axi_awaddr),
		.s00_axi_awprot(s00_axi_awprot),
		.s00_axi_awvalid(s00_axi_awvalid),
		.s00_axi_awready(s00_axi_awready),
		.s00_axi_wdata(s00_axi_wdata),
		.s00_axi_wstrb(s00_axi_wstrb),
		.s00_axi_wvalid(s00_axi_wvalid),
		.s00_axi_wready(s00_axi_wready),
		.s00_axi_bresp(s00_axi_bresp),
		.s00_axi_bvalid(s00_axi_bvalid),
		.s00_axi_bready(s00_axi_bready),
		.s00_axi_araddr(s00_axi_araddr),
		.s00_axi_arprot(s00_axi_arprot),
		.s00_axi_arvalid(s00_axi_arvalid),
		.s00_axi_arready(s00_axi_arready),
		.s00_axi_rdata(s00_axi_rdata),
		.s00_axi_rresp(s00_axi_rresp),
		.s00_axi_rvalid(s00_axi_rvalid),
		.s00_axi_rready(s00_axi_rready),
		// Ports of Axi Slave Bus Interface S01_AXI
		.s01_axi_aclk(S01_AXI_ACLK),
		.s01_axi_aresetn(~S01_AXI_ARESETN),
		.s01_axi_awid(S01_AXI_AWID),
		.s01_axi_awaddr(S01_AXI_AWADDR),
		.s01_axi_awlen(S01_AXI_AWLEN),
		.s01_axi_awsize(S01_AXI_AWSIZE),
		.s01_axi_awburst(S01_AXI_AWBURST),
		.s01_axi_awlock(S01_AXI_AWLOCK),
		.s01_axi_awcache(S01_AXI_AWCACHE),
		.s01_axi_awprot(S01_AXI_AWPROT),
		.s01_axi_awqos(S01_AXI_AWQOS),
		.s01_axi_awregion(S01_AXI_AWREGION),
		.s01_axi_awuser(S01_AXI_AWUSER),
		.s01_axi_awvalid(S01_AXI_AWVALID),
		.s01_axi_awready(S01_AXI_AWREADY),
		.s01_axi_wdata(S01_AXI_WDATA),
		.s01_axi_wstrb(S01_AXI_WSTRB),
		.s01_axi_wlast(S01_AXI_WLAST),
		.s01_axi_wuser(S01_AXI_WUSER),
		.s01_axi_wvalid(S01_AXI_WVALID),
		.s01_axi_wready(S01_AXI_WREADY),
		.s01_axi_bid(S01_AXI_BID),
		.s01_axi_bresp(S01_AXI_BRESP),
		.s01_axi_buser(S01_AXI_BUSER),
		.s01_axi_bvalid(S01_AXI_BVALID),
		.s01_axi_bready(S01_AXI_BREADY),
		.s01_axi_arid(S01_AXI_ARID),
		.s01_axi_araddr(S01_AXI_ARADDR),
		.s01_axi_arlen(S01_AXI_ARLEN),
		.s01_axi_arsize(S01_AXI_ARSIZE),
		.s01_axi_arburst(S01_AXI_ARBURST),
		.s01_axi_arlock(S01_AXI_ARLOCK),
		.s01_axi_arcache(S01_AXI_ARCACHE),
		.s01_axi_arprot(S01_AXI_ARPROT),
		.s01_axi_arqos(S01_AXI_ARQOS),
		.s01_axi_arregion(S01_AXI_ARREGION),
		.s01_axi_aruser(S01_AXI_ARUSER),
		.s01_axi_arvalid(S01_AXI_ARVALID),
		.s01_axi_arready(S01_AXI_ARREADY),
		.s01_axi_rid(S01_AXI_RID),
		.s01_axi_rdata(S01_AXI_RDATA),
		.s01_axi_rresp(S01_AXI_RRESP),
		.s01_axi_rlast(S01_AXI_RLAST),
		.s01_axi_ruser(S01_AXI_RUSER),
		.s01_axi_rvalid(S01_AXI_RVALID),
		.s01_axi_rready(S01_AXI_RREADY)
	);

	
	always #100
	begin
	   S01_AXI_ACLK = ~S01_AXI_ACLK;
	end

	initial
	begin
	// lite interface
	s00_axi_wdata = 32'h0000_0000;
	s00_axi_araddr = 32'h0000_0000;
	s00_axi_awaddr = 32'h0000_0000;
	s00_axi_awprot = 3'b00;
	s00_axi_arprot = 3'b000;
	s00_axi_wstrb = 4'b1111;
	s00_axi_awvalid = 1'b0;
	s00_axi_arvalid = 1'b0;
	s00_axi_rready = 1'b0; 
	s00_axi_wvalid = 1'b0;
	s00_axi_bready = 1'b0;
	// end lite interface
	S01_AXI_ACLK = 1'b0;
	// WAIT 100ns before starting changing the signal values 
	// due to glbl.v, that is required for Xilinx IPs simulation
	#100000
	S01_AXI_ARESETN = 1'b0;
	dout = 32'h0000_0000;
	S01_AXI_AWREGION = 4'h0;
	S01_AXI_AWUSER = 1'b0;
	S01_AXI_WUSER = 1'b0;
	S01_AXI_ARREGION = 4'h0;
	S01_AXI_ARUSER = 1'b0; 
	bs_response = 2'b00;
	#2000
	S01_AXI_ARESETN = 1'b1;
	#2000
	S01_AXI_ARESETN = 1'b0;
	
	
	write_adress(32'h43c3_0050, 32'h0000_0001);  // write control register to get into CONF mode
	
	//			START STREAMING THE CONFIGURATION SEQUENCE 
	//					INTO THE OVERLAY
	//
	//         transaction_id start_address burst_length burst_size burst_type            write_data    response
    // row 0
	bs.WRITE_BURST(12'h000, 32'h7600_0200, 8'h00, 3'b010, 2'b01, 2'b00, 4'h0, 3'b000, 32'h1000_0000, 5, bs_response); // switch 0 blank
	bs.WRITE_BURST(12'h000, 32'h7600_0200, 8'h00, 3'b010, 2'b01, 2'b00, 4'h0, 3'b000, 32'h1000_0084, 5, bs_response); // switch 1 switch 0
	bs.WRITE_BURST(12'h000, 32'h7600_0200, 8'h00, 3'b010, 2'b01, 2'b00, 4'h0, 3'b000, 32'h1000_0038, 5, bs_response); // switch 2 switch 1
	bs.WRITE_BURST(12'h000, 32'h7600_0200, 8'h00, 3'b010, 2'b01, 2'b00, 4'h0, 3'b000, 32'h1000_0038, 5, bs_response); // switch 3 switch 2
	bs.WRITE_BURST(12'h000, 32'h7600_0200, 8'h00, 3'b010, 2'b01, 2'b00, 4'h0, 3'b000, 32'h1000_0038, 5, bs_response); // switch 4 switch 3
	bs.WRITE_BURST(12'h000, 32'h7600_0200, 8'h00, 3'b010, 2'b01, 2'b00, 4'h0, 3'b000, 32'h0000_0038, 5, bs_response); // switch 5 switch 4
	bs.WRITE_BURST(12'h000, 32'h7600_0200, 8'h00, 3'b010, 2'b01, 2'b00, 4'h0, 3'b000, 32'h0000_0080, 5, bs_response); // tile 4   switch 5

	// 7
	// row 1
	bs.WRITE_BURST(12'h000, 32'h7600_0200, 8'h00, 3'b010, 2'b01, 2'b00, 4'h0, 3'b000, 32'h8022_1300, 5, bs_response); // tile 4
	bs.WRITE_BURST(12'h000, 32'h7600_0200, 8'h00, 3'b010, 2'b01, 2'b00, 4'h0, 3'b000, 32'h1203_0800, 5, bs_response); // tile 3
	bs.WRITE_BURST(12'h000, 32'h7600_0200, 8'h00, 3'b010, 2'b01, 2'b00, 4'h0, 3'b000, 32'h3800_8022, 5, bs_response); // tile 2 tile 3
	bs.WRITE_BURST(12'h000, 32'h7600_0200, 8'h00, 3'b010, 2'b01, 2'b00, 4'h0, 3'b000, 32'h8022_1200, 5, bs_response); // tile 2
	bs.WRITE_BURST(12'h000, 32'h7600_0200, 8'h00, 3'b010, 2'b01, 2'b00, 4'h0, 3'b000, 32'h0102_3800, 5, bs_response); // tile 1 tile 1
	bs.WRITE_BURST(12'h000, 32'h7600_0200, 8'h00, 3'b010, 2'b01, 2'b00, 4'h0, 3'b000, 32'h3800_8022, 5, bs_response); // tile 0 tile 1
	bs.WRITE_BURST(12'h000, 32'h7600_0200, 8'h00, 3'b010, 2'b01, 2'b00, 4'h0, 3'b000, 32'h8022_0001, 5, bs_response); // tile 0
	bs.WRITE_BURST(12'h000, 32'h7600_0200, 8'h00, 3'b010, 2'b01, 2'b00, 4'h0, 3'b000, 32'h0000_3180, 5, bs_response); // switch 9

	// 15
	// row 2
	bs.WRITE_BURST(12'h000, 32'h7600_0200, 8'h00, 3'b010, 2'b01, 2'b00, 4'h0, 3'b000, 32'h0000_8100, 5, bs_response); // switch 10
	bs.WRITE_BURST(12'h000, 32'h7600_0200, 8'h00, 3'b010, 2'b01, 2'b00, 4'h0, 3'b000, 32'h0001_0008, 5, bs_response); // tile 8
	bs.WRITE_BURST(12'h000, 32'h7600_0200, 8'h00, 3'b010, 2'b01, 2'b00, 4'h0, 3'b000, 32'h0000_8018, 5, bs_response); // tile 9 tile 8
	bs.WRITE_BURST(12'h000, 32'h7600_0200, 8'h00, 3'b010, 2'b01, 2'b00, 4'h0, 3'b000, 32'h0032_0001, 5, bs_response); // tile 9
	bs.WRITE_BURST(12'h000, 32'h7600_0200, 8'h00, 3'b010, 2'b01, 2'b00, 4'h0, 3'b000, 32'h0001_0000, 5, bs_response); // tile 10
	bs.WRITE_BURST(12'h000, 32'h7600_0200, 8'h00, 3'b010, 2'b01, 2'b00, 4'h0, 3'b000, 32'h0002_0032, 5, bs_response); // tile 11 tile 10
	bs.WRITE_BURST(12'h000, 32'h7600_0200, 8'h00, 3'b010, 2'b01, 2'b00, 4'h0, 3'b000, 32'h005c_0100, 5, bs_response); // tile 11
	bs.WRITE_BURST(12'h000, 32'h7600_0200, 8'h00, 3'b010, 2'b01, 2'b00, 4'h0, 3'b000, 32'h1000_0000, 5, bs_response); // tile 12
	bs.WRITE_BURST(12'h000, 32'h7600_0200, 8'h00, 3'b010, 2'b01, 2'b00, 4'h0, 3'b000, 32'h0000_8032, 5, bs_response); // tile 20 tile 12

	// 24
	// row 3
	bs.WRITE_BURST(12'h000, 32'h7600_0200, 8'h00, 3'b010, 2'b01, 2'b00, 4'h0, 3'b000, 32'h0000_0000, 5, bs_response); // tile 20
	bs.WRITE_BURST(12'h000, 32'h7600_0200, 8'h00, 3'b010, 2'b01, 2'b00, 4'h0, 3'b000, 32'h0100_0000, 5, bs_response); // tile 19 
	bs.WRITE_BURST(12'h000, 32'h7600_0200, 8'h00, 3'b010, 2'b01, 2'b00, 4'h0, 3'b000, 32'h0000_0032, 5, bs_response); // tile 18 tile 19
	bs.WRITE_BURST(12'h000, 32'h7600_0200, 8'h00, 3'b010, 2'b01, 2'b00, 4'h0, 3'b000, 32'h0022_0001, 5, bs_response); // tile 18
	bs.WRITE_BURST(12'h000, 32'h7600_0200, 8'h00, 3'b010, 2'b01, 2'b00, 4'h0, 3'b000, 32'h0000_0100, 5, bs_response); // tile 17
	bs.WRITE_BURST(12'h000, 32'h7600_0200, 8'h00, 3'b010, 2'b01, 2'b00, 4'h0, 3'b000, 32'h0108_0022, 5, bs_response); // tile 16 tile 17
	bs.WRITE_BURST(12'h000, 32'h7600_0200, 8'h00, 3'b010, 2'b01, 2'b00, 4'h0, 3'b000, 32'h8018_0000, 5, bs_response); // tile 16
	bs.WRITE_BURST(12'h000, 32'h7600_0200, 8'h00, 3'b010, 2'b01, 2'b00, 4'h0, 3'b000, 32'h0000_8100, 5, bs_response); // switch 11

	// 32
	// row 4
	bs.WRITE_BURST(12'h000, 32'h7600_0200, 8'h00, 3'b010, 2'b01, 2'b00, 4'h0, 3'b000, 32'h0000_8100, 5, bs_response); // switch 12
	bs.WRITE_BURST(12'h000, 32'h7600_0200, 8'h00, 3'b010, 2'b01, 2'b00, 4'h0, 3'b000, 32'h0001_0008, 5, bs_response); // tile 24
	bs.WRITE_BURST(12'h000, 32'h7600_0200, 8'h00, 3'b010, 2'b01, 2'b00, 4'h0, 3'b000, 32'h0000_8018, 5, bs_response); // tile 25 tile 24
	bs.WRITE_BURST(12'h000, 32'h7600_0200, 8'h00, 3'b010, 2'b01, 2'b00, 4'h0, 3'b000, 32'h0000_0000, 5, bs_response); // tile 25
	bs.WRITE_BURST(12'h000, 32'h7600_0200, 8'h00, 3'b010, 2'b01, 2'b00, 4'h0, 3'b000, 32'h0000_0000, 5, bs_response); // tile 26
	bs.WRITE_BURST(12'h000, 32'h7600_0200, 8'h00, 3'b010, 2'b01, 2'b00, 4'h0, 3'b000, 32'h0000_0000, 5, bs_response); // tile 27 tile 26
	bs.WRITE_BURST(12'h000, 32'h7600_0200, 8'h00, 3'b010, 2'b01, 2'b00, 4'h0, 3'b000, 32'h0032_0100, 5, bs_response); // tile 27
	bs.WRITE_BURST(12'h000, 32'h7600_0200, 8'h00, 3'b010, 2'b01, 2'b00, 4'h0, 3'b000, 32'h0000_0000, 5, bs_response); // tile 28 
	bs.WRITE_BURST(12'h000, 32'h7600_0200, 8'h00, 3'b010, 2'b01, 2'b00, 4'h0, 3'b000, 32'h0000_0000, 5, bs_response); // tile 36 tile 28

	// 41
	// row 5
	bs.WRITE_BURST(12'h000, 32'h7600_0200, 8'h00, 3'b010, 2'b01, 2'b00, 4'h0, 3'b000, 32'h0000_0000, 5, bs_response); // tile 36
	bs.WRITE_BURST(12'h000, 32'h7600_0200, 8'h00, 3'b010, 2'b01, 2'b00, 4'h0, 3'b000, 32'h0010_0000, 5, bs_response); // tile 35
	bs.WRITE_BURST(12'h000, 32'h7600_0200, 8'h00, 3'b010, 2'b01, 2'b00, 4'h0, 3'b000, 32'h0800_0044, 5, bs_response); // tile 34 tile 35
	bs.WRITE_BURST(12'h000, 32'h7600_0200, 8'h00, 3'b010, 2'b01, 2'b00, 4'h0, 3'b000, 32'h0000_0000, 5, bs_response); // tile 34
	bs.WRITE_BURST(12'h000, 32'h7600_0200, 8'h00, 3'b010, 2'b01, 2'b00, 4'h0, 3'b000, 32'h0000_1000, 5, bs_response); // tile 33
	bs.WRITE_BURST(12'h000, 32'h7600_0200, 8'h00, 3'b010, 2'b01, 2'b00, 4'h0, 3'b000, 32'h0108_0022, 5, bs_response); // tile 32 tile 33
	bs.WRITE_BURST(12'h000, 32'h7600_0200, 8'h00, 3'b010, 2'b01, 2'b00, 4'h0, 3'b000, 32'h8018_0000, 5, bs_response); // tile 32
	bs.WRITE_BURST(12'h000, 32'h7600_0200, 8'h00, 3'b010, 2'b01, 2'b00, 4'h0, 3'b000, 32'h0000_8100, 5, bs_response); // switch 13
	
	////////////////////////////////////////////////
	//
	//  END OF STREAMING THE CONFIGURATION SEQUENCE
	//
	////////////////////////////////////////////////

	// data #1
	
	write_adress(32'h43c3_0050, 32'h0006_0006);  // write control register to get into CALC mode and 
												 // program output bridge to expect in-order to 
												 // direct data into output FIFOs

	// write multiple bursts in-order to verify if the Overlay responds accordingly
	for(i=0; i<16; i = i + 1) begin
    bs.WRITE_BURST(12'h000, 32'h7600_0000, 8'h4f, 3'b010, 2'b01, 2'b00, 4'h0, 3'b000,      2560'h3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000,
    5, bs_response);
	end

	// wait for calculation to finish   	
	#80000
	read_adress(32'h43c3_0054);
    
    	#100000
	
	// read results
	for(i=0; i<16; i = i + 1) begin
   	#20000
	read_adress(32'h43c3_005c);
	#20000
	read_adress(32'h43c3_005c);
	#20000
	read_adress(32'h43c3_005c);
	#20000
	read_adress(32'h43c3_005c);
	end

    	#10000
    	read_adress(32'h43c3_0064);
	
	
	// data #2
	bs.WRITE_BURST(12'h000, 32'h7600_0000, 8'h4f, 3'b010, 2'b01, 2'b00, 4'h0, 3'b000,   2560'h3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000_3f80_0000,
        5, bs_response);

	#100000
    	#20000
	read_adress(32'h43c3_005c);
	#20000
	read_adress(32'h43c3_005c);
	#20000
	read_adress(32'h43c3_005c);
	#20000
	read_adress(32'h43c3_005c);
    	#10000
    	read_adress(32'h43c3_0064);

	end
	
	// task that emulates AXI4-Lite write transaction at an addr 
	task automatic write_adress;
        
        input [31:0] addr;
        input [31:0] data;
        
        begin
            #2000
		
            s00_axi_wdata = data;
            s00_axi_awaddr = addr;
            s00_axi_awvalid = 1;
            s00_axi_wvalid = 1;
            wait(s00_axi_awready && s00_axi_wready);

            @(posedge S01_AXI_ACLK) #1;
            s00_axi_awvalid = 0;
            s00_axi_wvalid = 0;
        end
    
    endtask
    
	// task that emulates AXI4-Lite read transaction for addr
	task automatic read_adress;
  
        input [31:0] addr;
  
        begin
            s00_axi_araddr = addr;
            s00_axi_arvalid = 1;
            s00_axi_rready = 1;
            wait(s00_axi_arready);
            wait(s00_axi_rvalid);

            
            @(posedge S01_AXI_ACLK) #1;
            s00_axi_arvalid = 0;
            s00_axi_rready = 0;
            
            if (s00_axi_rdata == 32'h0000_0001 && addr == 32'h43c3_0054) begin
                $display("Calculation Completed Succesfully\n");
            end	else if (addr == 32'h43c3_0044)  begin
				$display("mem[%x] = %x\n",addr, s00_axi_rdata);
	    	end else begin
                $display("mem[%x] = %x\n",addr, s00_axi_rdata);
	    end
            
            
    end
        
    endtask



endmodule
