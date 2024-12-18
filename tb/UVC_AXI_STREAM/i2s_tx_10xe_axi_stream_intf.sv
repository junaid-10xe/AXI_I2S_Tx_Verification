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
  wire [31:0]          s_axis_aud_tdata;
  wire [2:0]           s_axis_aud_tid;
  wire                 s_axis_aud_tvalid;
  wire                 s_axis_aud_tready;

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

endinterface

`endif