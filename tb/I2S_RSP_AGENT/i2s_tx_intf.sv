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
  // Expected sclk and lrclk
  bit expected_sclk;
  bit expected_lrclk;
  // Time period of clock according to sampling frequency
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


  // ASSERTION TO VALIDATE SCK AND LRCK
  // Counter to track sclk_out edges
  integer count = 0;
  // bit for justification mode
  bit justification;
  // Always block to monitor sclk_out and reset the counter based on justification
  always @(negedge sclk_out) begin
          count <= count + 1;
          if (justification && count == 32) begin
                  count <= 1; // Reset after 32 counts for left or right justification
          end
          else if (count == 24)  begin
                  count <= 1; // Reset after 24 counts otherwise
          end
  end
  // Sequence to detect count reaching 24 or 32
  sequence sclk_count_check;
      @(negedge sclk_out)
      (justification ? (count == 32) : (count == 24));
  endsequence
  // Property to check lrclk_out toggles on negedge sclk_out after count reaches the threshold
  property lrclk_check;
      @(negedge sclk_out)
      sclk_count_check |=> $changed(lrclk_out);
  endproperty
  // Assertion to verify the property
  assert property (lrclk_check)
    else `uvm_error("I2S_INTF_ASSERION", "LRCLK toggle verification failed");

endinterface

`endif
