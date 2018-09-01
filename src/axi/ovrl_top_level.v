
`timescale 1 ns / 1 ps

	module ovrl_5x5_top_level #
	(
        // Users to add parameters here

        // User parameters ends
        // Do not modify the parameters beyond this line


        // Parameters of Axi Slave Bus Interface S00_AXI
        parameter integer C_S00_AXI_DATA_WIDTH    = 32,
        parameter integer C_S00_AXI_ADDR_WIDTH    = 32,

        // Parameters of Axi Slave Bus Interface S01_AXI
        parameter integer C_S01_AXI_ID_WIDTH    = 1,
        parameter integer C_S01_AXI_DATA_WIDTH    = 32,
        parameter integer C_S01_AXI_ADDR_WIDTH    = 32,
        parameter integer C_S01_AXI_AWUSER_WIDTH    = 1,
        parameter integer C_S01_AXI_ARUSER_WIDTH    = 1,
        parameter integer C_S01_AXI_WUSER_WIDTH    = 1,
        parameter integer C_S01_AXI_RUSER_WIDTH    = 1,
        parameter integer C_S01_AXI_BUSER_WIDTH    = 1
    )
    (
        // Users to add ports here
        // Do not modify the ports beyond this line

        // Ports of Axi Slave Bus Interface S00_AXI
        input wire  s00_axi_aclk,
        input wire  s00_axi_aresetn,
        input wire [C_S00_AXI_ADDR_WIDTH-1 : 0] s00_axi_awaddr,
        input wire [2 : 0] s00_axi_awprot,
        input wire  s00_axi_awvalid,
        output wire  s00_axi_awready,
        input wire [C_S00_AXI_DATA_WIDTH-1 : 0] s00_axi_wdata,
        input wire [(C_S00_AXI_DATA_WIDTH/8)-1 : 0] s00_axi_wstrb,
        input wire  s00_axi_wvalid,
        output wire  s00_axi_wready,
        output wire [1 : 0] s00_axi_bresp,
        output wire  s00_axi_bvalid,
        input wire  s00_axi_bready,
        input wire [C_S00_AXI_ADDR_WIDTH-1 : 0] s00_axi_araddr,
        input wire [2 : 0] s00_axi_arprot,
        input wire  s00_axi_arvalid,
        output wire  s00_axi_arready,
        output wire [C_S00_AXI_DATA_WIDTH-1 : 0] s00_axi_rdata,
        output wire [1 : 0] s00_axi_rresp,
        output wire  s00_axi_rvalid,
        input wire  s00_axi_rready,

        // Ports of Axi Slave Bus Interface S01_AXI
        input wire  s01_axi_aclk,
        input wire  s01_axi_aresetn,
        input wire [C_S01_AXI_ID_WIDTH-1 : 0] s01_axi_awid,
        input wire [C_S01_AXI_ADDR_WIDTH-1 : 0] s01_axi_awaddr,
        input wire [7 : 0] s01_axi_awlen,
        input wire [2 : 0] s01_axi_awsize,
        input wire [1 : 0] s01_axi_awburst,
        input wire  s01_axi_awlock,
        input wire [3 : 0] s01_axi_awcache,
        input wire [2 : 0] s01_axi_awprot,
        input wire [3 : 0] s01_axi_awqos,
        input wire [3 : 0] s01_axi_awregion,
        input wire [C_S01_AXI_AWUSER_WIDTH-1 : 0] s01_axi_awuser,
        input wire  s01_axi_awvalid,
        output wire  s01_axi_awready,
        input wire [C_S01_AXI_DATA_WIDTH-1 : 0] s01_axi_wdata,
        input wire [(C_S01_AXI_DATA_WIDTH/8)-1 : 0] s01_axi_wstrb,
        input wire  s01_axi_wlast,
        input wire [C_S01_AXI_WUSER_WIDTH-1 : 0] s01_axi_wuser,
        input wire  s01_axi_wvalid,
        output wire  s01_axi_wready,
        output wire [C_S01_AXI_ID_WIDTH-1 : 0] s01_axi_bid,
        output wire [1 : 0] s01_axi_bresp,
        output wire [C_S01_AXI_BUSER_WIDTH-1 : 0] s01_axi_buser,
        output wire  s01_axi_bvalid,
        input wire  s01_axi_bready,
        input wire [C_S01_AXI_ID_WIDTH-1 : 0] s01_axi_arid,
        input wire [C_S01_AXI_ADDR_WIDTH-1 : 0] s01_axi_araddr,
        input wire [7 : 0] s01_axi_arlen,
        input wire [2 : 0] s01_axi_arsize,
        input wire [1 : 0] s01_axi_arburst,
        input wire  s01_axi_arlock,
        input wire [3 : 0] s01_axi_arcache,
        input wire [2 : 0] s01_axi_arprot,
        input wire [3 : 0] s01_axi_arqos,
        input wire [3 : 0] s01_axi_arregion,
        input wire [C_S01_AXI_ARUSER_WIDTH-1 : 0] s01_axi_aruser,
        input wire  s01_axi_arvalid,
        output wire  s01_axi_arready,
        output wire [C_S01_AXI_ID_WIDTH-1 : 0] s01_axi_rid,
        output wire [C_S01_AXI_DATA_WIDTH-1 : 0] s01_axi_rdata,
        output wire [1 : 0] s01_axi_rresp,
        output wire  s01_axi_rlast,
        output wire [C_S01_AXI_RUSER_WIDTH-1 : 0] s01_axi_ruser,
        output wire  s01_axi_rvalid,
        input wire  s01_axi_rready
    );
    
	wire [4:0] out_port0;
	wire [4:0] out_port1;
	wire conf_en;
	wire wr_en_ovrl;
	wire out_en_ovrl0;
	wire out_en_ovrl1;
	wire done0;
	wire done1;
	wire [31:0] ovrl_res0;
	wire [31:0] ovrl_res1;

	// DEBUG wires
	wire [31:0] debug0;
	wire [31:0] debug1;
	wire [31:0] data_debug00;
	wire [31:0] data_debug10;
	wire [31:0] data_debug01;
	wire [31:0] data_debug11;
	wire [31:0] data_debug02;
	wire [31:0] data_debug12;
	wire [31:0] cpu_poll;
    
    // Instantiation of Axi Bus Interface S00_AXI
    ovrl_5x5_axi4_lite # ( 
        .C_S_AXI_DATA_WIDTH(C_S00_AXI_DATA_WIDTH),
        .C_S_AXI_ADDR_WIDTH(C_S00_AXI_ADDR_WIDTH)
    ) ovrl_5x5_axi4_lite_inst (
        // Users to add ports here
        .out_port0(out_port0),
        .out_port1(out_port1),
        .conf_en(conf_en),
        .wr_en_ovrl(wr_en_ovrl),
        .out_en_ovrl0(out_en_ovrl0),
        .out_en_ovrl1(out_en_ovrl1),
        .done0(done0),
        .done1(done1),
        .ovrl_res0(ovrl_res0),
        .ovrl_res1(ovrl_res1),
        // DEBUG PORTS
        .dbg0(debug0),
        .dbg1(debug1),
        .data_dbg00(data_debug00),
        .data_dbg10(data_debug10),
        .data_dbg01(data_debug01),
        .data_dbg11(data_debug11),
        .data_dbg02(data_debug02),
        .data_dbg12(data_debug12),
        .cpu_poll(cpu_poll),
        // DEBUG PORTS
        // User ports ends
        .S_AXI_ACLK(s00_axi_aclk),
        .S_AXI_ARESETN(s00_axi_aresetn),
        .S_AXI_AWADDR(s00_axi_awaddr),
        .S_AXI_AWPROT(s00_axi_awprot),
        .S_AXI_AWVALID(s00_axi_awvalid),
        .S_AXI_AWREADY(s00_axi_awready),
        .S_AXI_WDATA(s00_axi_wdata),
        .S_AXI_WSTRB(s00_axi_wstrb),
        .S_AXI_WVALID(s00_axi_wvalid),
        .S_AXI_WREADY(s00_axi_wready),
        .S_AXI_BRESP(s00_axi_bresp),
        .S_AXI_BVALID(s00_axi_bvalid),
        .S_AXI_BREADY(s00_axi_bready),
        .S_AXI_ARADDR(s00_axi_araddr),
        .S_AXI_ARPROT(s00_axi_arprot),
        .S_AXI_ARVALID(s00_axi_arvalid),
        .S_AXI_ARREADY(s00_axi_arready),
        .S_AXI_RDATA(s00_axi_rdata),
        .S_AXI_RRESP(s00_axi_rresp),
        .S_AXI_RVALID(s00_axi_rvalid),
        .S_AXI_RREADY(s00_axi_rready)
    );

// Instantiation of Axi Bus Interface S01_AXI
    ovrl_5x5_axi4_full # ( 
        .C_S_AXI_ID_WIDTH(C_S01_AXI_ID_WIDTH),
        .C_S_AXI_DATA_WIDTH(C_S01_AXI_DATA_WIDTH),
        .C_S_AXI_ADDR_WIDTH(C_S01_AXI_ADDR_WIDTH),
        .C_S_AXI_AWUSER_WIDTH(C_S01_AXI_AWUSER_WIDTH),
        .C_S_AXI_ARUSER_WIDTH(C_S01_AXI_ARUSER_WIDTH),
        .C_S_AXI_WUSER_WIDTH(C_S01_AXI_WUSER_WIDTH),
        .C_S_AXI_RUSER_WIDTH(C_S01_AXI_RUSER_WIDTH),
        .C_S_AXI_BUSER_WIDTH(C_S01_AXI_BUSER_WIDTH)
    ) ovrl_5x5_axi4_full_inst (
        // Users to add ports here 
        .out_port0(out_port0),
        .out_port1(out_port1),
        .conf_wr_en(conf_en),
        .wr_en(wr_en_ovrl),
        .out_en0(out_en_ovrl0),
        .out_en1(out_en_ovrl1),
        .out_rd0(done0),
        .out_rd1(done1),
        .ovrl_res0(ovrl_res0),
        .ovrl_res1(ovrl_res1),
        // DEBUG PORTS
        .dbg0(debug0),
        .dbg1(debug1),
        .data_dbg00(data_debug00),
        .data_dbg10(data_debug10),
        .data_dbg01(data_debug01),
        .data_dbg11(data_debug11),
        .data_dbg02(data_debug02),
        .data_dbg12(data_debug12),
        .cpu_poll(cpu_poll),
        //
        // DEBUG PORTS
        // User ports ends 
        .S_AXI_ACLK(s01_axi_aclk),
        .S_AXI_ARESETN(s01_axi_aresetn),
        .S_AXI_AWID(s01_axi_awid),
        .S_AXI_AWADDR(s01_axi_awaddr),
        .S_AXI_AWLEN(s01_axi_awlen),
        .S_AXI_AWSIZE(s01_axi_awsize),
        .S_AXI_AWBURST(s01_axi_awburst),
        .S_AXI_AWLOCK(s01_axi_awlock),
        .S_AXI_AWCACHE(s01_axi_awcache),
        .S_AXI_AWPROT(s01_axi_awprot),
        .S_AXI_AWQOS(s01_axi_awqos),
        .S_AXI_AWREGION(s01_axi_awregion),
        .S_AXI_AWUSER(s01_axi_awuser),
        .S_AXI_AWVALID(s01_axi_awvalid),
        .S_AXI_AWREADY(s01_axi_awready),
        .S_AXI_WDATA(s01_axi_wdata),
        .S_AXI_WSTRB(s01_axi_wstrb),
        .S_AXI_WLAST(s01_axi_wlast),
        .S_AXI_WUSER(s01_axi_wuser),
        .S_AXI_WVALID(s01_axi_wvalid),
        .S_AXI_WREADY(s01_axi_wready),
        .S_AXI_BID(s01_axi_bid),
        .S_AXI_BRESP(s01_axi_bresp),
        .S_AXI_BUSER(s01_axi_buser),
        .S_AXI_BVALID(s01_axi_bvalid),
        .S_AXI_BREADY(s01_axi_bready),
        .S_AXI_ARID(s01_axi_arid),
        .S_AXI_ARADDR(s01_axi_araddr),
        .S_AXI_ARLEN(s01_axi_arlen),
        .S_AXI_ARSIZE(s01_axi_arsize),
        .S_AXI_ARBURST(s01_axi_arburst),
        .S_AXI_ARLOCK(s01_axi_arlock),
        .S_AXI_ARCACHE(s01_axi_arcache),
        .S_AXI_ARPROT(s01_axi_arprot),
        .S_AXI_ARQOS(s01_axi_arqos),
        .S_AXI_ARREGION(s01_axi_arregion),
        .S_AXI_ARUSER(s01_axi_aruser),
        .S_AXI_ARVALID(s01_axi_arvalid),
        .S_AXI_ARREADY(s01_axi_arready),
        .S_AXI_RID(s01_axi_rid),
        .S_AXI_RDATA(s01_axi_rdata),
        .S_AXI_RRESP(s01_axi_rresp),
        .S_AXI_RLAST(s01_axi_rlast),
        .S_AXI_RUSER(s01_axi_ruser),
        .S_AXI_RVALID(s01_axi_rvalid),
        .S_AXI_RREADY(s01_axi_rready)
    );

    // Add user logic here

    // User logic ends

endmodule
