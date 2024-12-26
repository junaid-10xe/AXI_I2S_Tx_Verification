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
`ifndef I2S_TX_10XE_DUT_INTF
`define I2S_TX_10XE_DUT_INTF

interface i2s_tx_10xe_dut_intf (input aud_mclk, input aud_mrst); // Parameter for clock period
  // Interrupt signal indicating an event
  logic irq;

  // Left-right clock signal for audio synchronization
  logic lrclk_out;

  // Serial clock output for audio data transmission
  logic sclk_out;

  // Serial data output
  logic sdata_0_out;

  // Internal clock signal
  // logic aud_mclk;

  // // Internal reset signal
  // logic aud_mrst;

  // // Clock generation process
  // //Calculate Time Period
  // localparam T = 1.0 / (CLK_FREQ*1000);
  // initial begin

  //   aud_mclk = 0;
  //   forever #(T/2) aud_mclk = ~aud_mclk; // Generate clock
  // end

  // // Reset initialization
  // initial begin
  //   aud_mrst = 1;
  //   #(10 * T); // Hold reset for a few clock cycles
  //   aud_mrst = 0;
  // end

endinterface

`endif
