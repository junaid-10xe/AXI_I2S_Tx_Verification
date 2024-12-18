/*************************************************************************
   > File Name: i2s_tx_10xe_dut_intf.sv
   > Description: This file defines the  input/ouput signals of DUT that are not the part of axi4-lite and axi-stream 
   for I2S transmitter functionality.
   > Author: Muhammad Junaid Ramzan
   > Modified: Muhammad Junaid Ramzan
   > Mail: muhammad.junaid@10xengineers.ai
   ---------------------------------------------------------------
   Copyright   (c)2024 10xEngineers
   ---------------------------------------------------------------
************************************************************************/
`ifndef i2s_tx_10xe_dut_intf.sv
`define i2s_tx_10xe_dut_intf.sv

interface i2s_tx_10xe_dut_intf (input aud_mclk, input aud_mrst);

  // Interrupt signal indicating an event
  wire irq;

  // Left-right clock signal for audio synchronization
  wire lrclk_out;

  // Serial clock output for audio data transmission
  wire sclk_out;

  // Serial data output
  wire sdata_0_out;

endinterface

`endif