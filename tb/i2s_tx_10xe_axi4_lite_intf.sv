/*************************************************************************
   > File Name: i2s_tx_10xe_axi4_lite_intf.sv
   > Description: This file defines the AXI4-Lite interface signals and associated clocking blocks for I2S transmitter functionality.
   > Author: Muhammad Junaid Ramzan
   > Modified: Muhammad Junaid Ramzan
   > Mail: muhammad.junaid@10xengineers.ai
   ---------------------------------------------------------------
   Copyright   (c)2024 10xEngineers
   ---------------------------------------------------------------
************************************************************************/
interface i2s_tx_10xe_axi4_lite_intf (input s_axi_ctrl_aclk, s_axi_ctrl_aresetn );

//for address write channel 
wire                  s_axi_ctrl_awvalid;
wire                  s_axi_ctrl_awready;
wire [7:0]            s_axi_ctrl_awaddr;
//for write data channel
wire                    s_axi_ctrl_wvalid;
wire                    s_axi_ctrl_wready;
wire [31:0]             s_axi_ctrl_wdata;
//for write response channel
wire                    s_axi_ctrl_bvalid;
wire                    s_axi_ctrl_bready;
wire [1:0]              s_axi_ctrl_bresp;
//for read address channel
wire                    s_axi_ctrl_arvalid;
wire                    s_axi_ctrl_arready;
wire [7:0]              s_axi_ctrl_araddr;
//for read data channel
wire                    s_axi_ctrl_rvalid;
wire                    s_axi_ctrl_rready;
wire [1:0]              s_axi_ctrl_rresp;
wire [31:0]             s_axi_ctrl_rdata;


//Signals for Axi4_Lite driver
clocking axi4_lite_driver @(posedge s_axi_ctrl_aclk);
    //For address write channel
    output s_axi_ctrl_awaddr;
    output s_axi_ctrl_awvalid;
    input  s_axi_ctrl_awready;
    //For data write channel
    output s_axi_ctrl_wdata;
    output s_axi_ctrl_wvalid;
    input  s_axi_ctrl_wready;
    //For write response channel
    output s_axi_ctrl_bready;
    input  s_axi_ctrl_bresp;
    input  s_axi_ctrl_bvalid;
    //For read address channel
    output s_axi_ctrl_araddr;
    output s_axi_ctrl_arvalid;
    input  s_axi_ctrl_arready;
    //For read data channel
    output s_axi_ctrl_rready;
    input  s_axi_ctrl_rdata;
    input  s_axi_ctrl_rresp;
    input  s_axi_ctrl_bvalid;

endclocking

//Signals for Axi4_Lite Monitor
clocking axi4_lite_monitor @(posedge s_axi_ctrl_aclk)
    //For address write channel
    input  s_axi_ctrl_awaddr;
    input  s_axi_ctrl_awvalid;
    input  s_axi_ctrl_awready;
    //For data write channel
    input  s_axi_ctrl_wdata;
    input  s_axi_ctrl_wvalid;
    input  s_axi_ctrl_wready;
    //For write response channel
    input  s_axi_ctrl_bready;
    input  s_axi_ctrl_bresp;
    input  s_axi_ctrl_bvalid;
    //For read address channel
    input  s_axi_ctrl_araddr;
    input  s_axi_ctrl_arvalid;
    input  s_axi_ctrl_arready;
    //For read data channel
    input  s_axi_ctrl_rready;
    input  s_axi_ctrl_rdata;
    input  s_axi_ctrl_rresp;
    input  s_axi_ctrl_bvalid;
endclocking

	//driver modport
  	modport DRIVER  (clocking axi4_lite_driver,input s_axi_ctrl_aclk);
  
  	//monitor modport  
    modport MONITOR (clocking axi4_lite_monitor,input s_axi_ctrl_aclk);

endinterface