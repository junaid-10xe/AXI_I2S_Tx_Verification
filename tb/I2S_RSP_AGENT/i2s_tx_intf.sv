/*************************************************************************
   > File Name: i2s_tx_intf.sv
   > Description: This file defines the  input/ouput signals of DUT that are not the part of axi4-lite and axi-stream 
   for I2S transmitter functionality.
   > Author: Muhammad Junaid Ramzan
   > Modified: Muhammad Junaid Ramzan
   > Mail: muhammad.junaid@10xengineers.ai
   ---------------------------------------------------------------
   Copyright   (c)2024 10xEngineers
   ---------------------------------------------------------------
************************************************************************/
`ifndef I2S_TX_INTF
`define I2S_TX_INTF

interface i2s_tx_intf (); 
  // Interrupt signal indicating an event
  logic irq;

  // Left-right clock signal for audio synchronization
  logic lrclk_out;

  // Serial clock output for audio data transmission
  logic sclk_out;

  // Serial data output
  logic sdata_0_out;

  logic [15:0] fifo_wrdata_count;
  logic [15:0] fifo_rdata_count;
  // Signals for clock and reset
  logic aud_mclk;
  logic aud_mrst;

  int TIME_PERIOD = i2s_tx_params::AUD_MCLK_PERIOD;
  // task to generate clk
  task generate_clk();
    aud_mclk = 0;
    forever
    #(TIME_PERIOD/2) aud_mclk = ~aud_mclk;
  endtask

  // task to generate reset for 10 clock cycle
  task generate_reset();
    aud_mrst = 1;
    repeat(10) @(posedge aud_mclk);
    aud_mrst = 0;
  endtask

  initial begin
    fork
      generate_clk();
      generate_reset();
    join
  end

endinterface

`endif
