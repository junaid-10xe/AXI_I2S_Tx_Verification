/*************************************************************************
   > File Name: i2s_tx_axi4_lite_intf.sv
   > Description: This file defines the AXI4-Lite interface signals and associated clocking blocks for I2S transmitter functionality.
   > Author: Muhammad Junaid Ramzan
   > Modified: Muhammad Junaid Ramzan
   > Mail: muhammad.junaid@10xengineers.ai
   ---------------------------------------------------------------
   Copyright   (c)2024 10xEngineers
   ---------------------------------------------------------------
************************************************************************/
`ifndef I2S_TX_AXI4_LITE_INTF
`define I2S_TX_AXI4_LITE_INTF

interface i2s_tx_axi4_lite_intf();

  // AXI4-Lite Address Write Channel
  logic                             s_axi_ctrl_awvalid;
  logic                             s_axi_ctrl_awready;
  i2s_tx_defines::reg_addr     s_axi_ctrl_awaddr;

  // AXI4-Lite Write Data Channel
  logic                             s_axi_ctrl_wvalid;
  logic                             s_axi_ctrl_wready;
  i2s_tx_defines::reg_data     s_axi_ctrl_wdata;

  // AXI4-Lite Write Response Channel
  logic                             s_axi_ctrl_bvalid;
  logic                             s_axi_ctrl_bready;
  logic [1:0]                       s_axi_ctrl_bresp;

  // AXI4-Lite Read Address Channel
  logic                             s_axi_ctrl_arvalid;
  logic                             s_axi_ctrl_arready;
  i2s_tx_defines::reg_addr     s_axi_ctrl_araddr;

  // AXI4-Lite Read Data Channel
  logic                             s_axi_ctrl_rvalid;
  logic                             s_axi_ctrl_rready;
  logic [1:0]                       s_axi_ctrl_rresp;
  i2s_tx_defines::reg_data     s_axi_ctrl_rdata;

  // Clk and reset signals
  logic s_axi_ctrl_aclk; 
  logic s_axi_ctrl_aresetn;


  // AXI4-Lite Driver Signals
  clocking axi4_lite_driver @(posedge s_axi_ctrl_aclk);
    // Address Write Channel
    output s_axi_ctrl_awaddr;
    output s_axi_ctrl_awvalid;
    input  s_axi_ctrl_awready;

    // Write Data Channel
    output s_axi_ctrl_wdata;
    output s_axi_ctrl_wvalid;
    input  s_axi_ctrl_wready;

    // Write Response Channel
    output s_axi_ctrl_bready;
    input  s_axi_ctrl_bresp;
    input  s_axi_ctrl_bvalid;

    // Read Address Channel
    output s_axi_ctrl_araddr;
    output s_axi_ctrl_arvalid;
    input  s_axi_ctrl_arready;

    // Read Data Channel
    output s_axi_ctrl_rready;
    input  s_axi_ctrl_rdata;
    input  s_axi_ctrl_rresp;
    input  s_axi_ctrl_rvalid;
  endclocking

  // AXI4-Lite Monitor Signals
  clocking axi4_lite_monitor @(posedge s_axi_ctrl_aclk);
    // Address Write Channel
    input  s_axi_ctrl_awaddr;
    input  s_axi_ctrl_awvalid;
    input  s_axi_ctrl_awready;

    // Write Data Channel
    input  s_axi_ctrl_wdata;
    input  s_axi_ctrl_wvalid;
    input  s_axi_ctrl_wready;

    // Write Response Channel
    input  s_axi_ctrl_bready;
    input  s_axi_ctrl_bresp;
    input  s_axi_ctrl_bvalid;

    // Read Address Channel
    input  s_axi_ctrl_araddr;
    input  s_axi_ctrl_arvalid;
    input  s_axi_ctrl_arready;

    // Read Data Channel
    input  s_axi_ctrl_rready;
    input  s_axi_ctrl_rdata;
    input  s_axi_ctrl_rresp;
    input  s_axi_ctrl_rvalid;
  endclocking

  // Driver Modport
  modport DRIVER (clocking axi4_lite_driver, input s_axi_ctrl_aclk);

  // Monitor Modport
  modport MONITOR (clocking axi4_lite_monitor, input s_axi_ctrl_aclk);

  // Reset Task
  task reset();
    `uvm_info("AXI4-LITE_INTF", "Waiting for reset", UVM_NONE)
    wait(!s_axi_ctrl_aresetn);

    `uvm_info("AXI4-LITE_INTF", "Reset Started", UVM_NONE)
    axi4_lite_driver.s_axi_ctrl_awaddr  <= 0;
    axi4_lite_driver.s_axi_ctrl_awvalid <= 0;
    axi4_lite_driver.s_axi_ctrl_wdata   <= 0;
    axi4_lite_driver.s_axi_ctrl_wvalid  <= 0;
    axi4_lite_driver.s_axi_ctrl_bready  <= 0;
    axi4_lite_driver.s_axi_ctrl_araddr  <= 0;
    axi4_lite_driver.s_axi_ctrl_arvalid <= 0;
    axi4_lite_driver.s_axi_ctrl_rready  <= 0;

    `uvm_info("AXI4-LITE_INTF", "Waiting for reset deassertion", UVM_NONE)
    wait(s_axi_ctrl_aresetn);

    `uvm_info("AXI4-LITE_INTF", "Reset Ended", UVM_NONE)
  endtask

  // task to generate clk
  task generate_clk();
    s_axi_ctrl_aclk = 0;
    forever
    #10 s_axi_ctrl_aclk = ~s_axi_ctrl_aclk;
  endtask

  // task to generate reset for 10 clock cycle
  task generate_reset();
    s_axi_ctrl_aresetn = 0;
    repeat(10) @(posedge s_axi_ctrl_aclk);
    s_axi_ctrl_aresetn = 1;
    @(posedge s_axi_ctrl_aclk);
  endtask

  initial begin
    fork
      generate_clk();
      generate_reset();
    join
  end

endinterface

`endif
