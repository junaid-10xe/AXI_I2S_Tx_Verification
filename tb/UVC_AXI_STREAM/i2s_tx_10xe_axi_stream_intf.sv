/*************************************************************************
   > File Name: i2s_tx_10xe_axi_stream_intf.sv
   > Description: This file defines the AXI-Stream interface signals and associated clocking blocks for I2S transmitter functionality.
   > Author: Muhammad Junaid Ramzan
   > Modified: Muhammad Junaid Ramzan
   > Mail: muhammad.junaid@10xengineers.ai
   ---------------------------------------------------------------
   Copyright   (c)2024 10xEngineers
   ---------------------------------------------------------------
************************************************************************/
`ifndef I2S_TX_10XE_AXI_STREAM_INTF
`define I2S_TX_10XE_AXI_STREAM_INTF

interface i2s_tx_10xe_axi_stream_intf (input s_axis_aud_aclk, input s_axis_aud_aresetn);
  // AXI-Stream signals for audio data transfer
  logic [31:0]          s_axis_aud_tdata;
  logic [2:0]           s_axis_aud_tid;
  logic                 s_axis_aud_tvalid;
  logic                 s_axis_aud_tready;

//Signals for axi-stream driver
clocking axi_stream_driver @(posedge s_axis_aud_aclk);
    output s_axis_aud_tdata;
    output s_axis_aud_tid;
    output s_axis_aud_tvalid;
    input  s_axis_aud_tready;
endclocking

//Signals for axi-stream monitor

clocking axi_stream_monitor @(posedge s_axis_aud_aclk);
    input  s_axis_aud_tdata;
    input  s_axis_aud_tid;
    input  s_axis_aud_tvalid;
    input  s_axis_aud_tready;
endclocking

//driver modport
modport DRIVER  (clocking axi_stream_driver,input s_axis_aud_aclk);
  
//monitor modport  
modport MONITOR (clocking axi_stream_monitor,input s_axis_aud_aclk);

//Task for reset 
task reset();
  `uvm_info("STREAM_INTF", "Waiting for reset", UVM_NONE)
  wait(!s_axis_aud_aresetn);

  `uvm_info("STREAM_INTF", "RESET STARTED", UVM_NONE)

  axi_stream_driver.s_axis_aud_tdata  <= 0;

  axi_stream_driver.s_axis_aud_tid    <= 0;
  
  axi_stream_driver.s_axis_aud_tvalid <= 0;
  `uvm_info("STREAM_INTF", "Waiting for reset to be deasserted", UVM_NONE)
  wait(s_axis_aud_aresetn);
  `uvm_info("STREAM_INTF", "RESET ENDED", UVM_NONE)

endtask

endinterface

`endif