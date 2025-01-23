/*************************************************************************
   > File Name: i2s_tx_params.sv
   > Description: This file defines the Parameters that should not be changed if changed then other environment variable should be changed accordingly  
   for I2S transmitter functionality.
   > Author: Muhammad Junaid Ramzan
   > Modified: Muhammad Junaid Ramzan
   > Mail: muhammad.junaid@10xengineers.ai
   ---------------------------------------------------------------
   Copyright   (c)2024 10xEngineers
   ---------------------------------------------------------------
************************************************************************/
`ifndef I2S_TX_PARAMS
`define I2S_TX_PARAMS

package i2s_tx_params;
    
    // Audio data width 
    localparam AUD_WIDTH = 24;
    // Parameters
    // FOR AXI-STREAM
    localparam int AXI_STREAM_DATA_WIDTH    = 32;
    localparam int AXI_STREAM_TID_WIDTH     = 3;
    //Specify FIFO DEPTH as per core is configure so that Scoreboard will work accordingly
    localparam int FIFO_DEPTH               = 128;
 
    // FOR REGISTER 
    localparam int REG_DATA_WIDTH                 = 32;
    localparam int REG_ADDR_WIDTH                 = 8;
    localparam int SAMPLING_FREQUENCY             = 192000;                                 // Sampling Frequency of Audio in kHz
    localparam int MULTIPLIER                     = 128;                                    // Will be used to calculate time period aud_mclk
    // Calculate the frequency of aud_mclk (Hz)
    localparam int AUD_MCLK_FREQUENCY             = SAMPLING_FREQUENCY * MULTIPLIER;
    localparam int AUD_MCLK_PERIOD                = (1000000000) / AUD_MCLK_FREQUENCY;      // Time Period of aud_mclk in ns
                  
    
endpackage 


`endif