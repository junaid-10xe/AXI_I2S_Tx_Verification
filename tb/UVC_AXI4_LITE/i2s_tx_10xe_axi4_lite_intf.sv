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
`ifndef I2S_TX_10XE_AXI4_LITE_INTF
`define I2S_TX_10XE_AXI4_LITE_INTF

interface i2s_tx_10xe_axi4_lite_intf (input s_axi_ctrl_aclk, input s_axi_ctrl_aresetn );

//for address write channel 
logic                  s_axi_ctrl_awvalid;
logic                  s_axi_ctrl_awready;
logic [7:0]            s_axi_ctrl_awaddr;
//for write data channel
logic                    s_axi_ctrl_wvalid;
logic                    s_axi_ctrl_wready;
logic [31:0]             s_axi_ctrl_wdata;
//for write response channel
logic                    s_axi_ctrl_bvalid;
logic                    s_axi_ctrl_bready;
logic [1:0]              s_axi_ctrl_bresp;
//for read address channel
logic                    s_axi_ctrl_arvalid;
logic                    s_axi_ctrl_arready;
logic [7:0]              s_axi_ctrl_araddr;
//for read data channel
logic                    s_axi_ctrl_rvalid;
logic                    s_axi_ctrl_rready;
logic [1:0]              s_axi_ctrl_rresp;
logic [31:0]             s_axi_ctrl_rdata;


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
    input  s_axi_ctrl_rvalid;

endclocking

//Signals for Axi4_Lite Monitor
clocking axi4_lite_monitor @(posedge s_axi_ctrl_aclk);
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
    input  s_axi_ctrl_rvalid;
endclocking

	//driver modport
  	modport DRIVER  (clocking axi4_lite_driver,input s_axi_ctrl_aclk);
  
  	//monitor modport  
    modport MONITOR (clocking axi4_lite_monitor,input s_axi_ctrl_aclk);

    task reset();
        `uvm_info("AXI-INTF", "Waiting for reset", UVM_NONE)
        wait(!s_axi_ctrl_aresetn);
        `uvm_info("AXI-INTF", "Reset Started", UVM_NONE)

        s_axi_ctrl_awaddr   <= 0;
        s_axi_ctrl_awvalid  <= 0;
        s_axi_ctrl_wdata    <= 0;
        s_axi_ctrl_wvalid   <= 0;
        s_axi_ctrl_bready   <= 0;
        s_axi_ctrl_araddr   <= 0;
        s_axi_ctrl_arvalid  <= 0;
        s_axi_ctrl_rready   <= 0;
        `uvm_info("AXI-INTF", "Waiting for reset to be deasserted", UVM_NONE)
        wait(s_axi_ctrl_aresetn);
        `uvm_info("AXI-INTF", "Reset ENDED", UVM_NONE)

        
    endtask

endinterface

`endif