/*************************************************************************
   > File Name: i2s_tx_10xe_defines.sv
   > Description: This file defines the  parameters and variables to control the testbench environment  
   for I2S transmitter functionality.
   > Author: Muhammad Junaid Ramzan
   > Modified: Muhammad Junaid Ramzan
   > Mail: muhammad.junaid@10xengineers.ai
   ---------------------------------------------------------------
   Copyright   (c)2024 10xEngineers
   ---------------------------------------------------------------
************************************************************************/
`ifndef I2S_TX_10XE_DEFINES
`define I2S_TX_10XE_DEFINES

package i2s_tx_10xe_defines;
    // Enum Used in RAL
    typedef enum logic [1:0] { 
        ALL_ZERO = 2'b00,
        ALL_ONES = 2'b01,
        RANDOM   = 2'b10,
        DEFAULT  = 2'b11
     } data_pattern_e;

    // Parameters
    // FOR AXI-STREAM
    localparam int AXI_STREAM_DATA_WIDTH    = 32;
    localparam int AXI_STREAM_TID_WIDTH     = 3;
 
    // FOR REGISTER 
    localparam int REG_DATA_WIDTH                 = 32;
    localparam int REG_ADDR_WIDTH                 = 8;
    localparam int DATA_PATTERN                   = 2;
    localparam int SAMPLING_FREQUENCY             = 192000;                                 // Sampling Frequency of Audio in kHz
    localparam int MULTIPLIER                     = 128;                                    // Will be used to calculate time period aud_mclk
    // Calculate the frequency of aud_mclk (Hz)
    localparam int AUD_MCLK_FREQUENCY             = SAMPLING_FREQUENCY * MULTIPLIER;
    localparam int AUD_MCLK_PERIOD                = (1000000000) / AUD_MCLK_FREQUENCY;      // Time Period of aud_mclk in ns
    // Calculate SCLK FREQUENCY
    localparam int SCLK_DIVIDER_VALUE             = 1;                                                     // MCLK_FREQ/SCLK_FREQ = Divider_val*2
    localparam int SCLK_PERIOD                    = AUD_MCLK_PERIOD*(SCLK_DIVIDER_VALUE*2);                // Time Period of SCLK in ns
    localparam int SCLK_FREQUENCY                 = 1000000000/SCLK_PERIOD;                       // Frequency of SCLK              
    // CALCULATE SCLK DIVIDER Value to configure register
    // Parameters to control sequences of RAL
    localparam data_pattern_e RAL_DATA_PATTERN    = ALL_ONES;
    localparam bit CORE_CFG                       = 1;    // Bit to cinfugure core
    localparam bit AXI_STREAM_DATA_VALID          = 0;    // Optional if we want to make data valid on stream 
    localparam bit EN_DIS_INT                     = 0;    // BIT to enable disable interrupt
    localparam bit RD_REGS                        = 1;    // Bit to READ RAL REGISTERS
    localparam bit RD_REGS_IN_RST                 = 0;    // BIT to read registers in reset phase
    localparam bit WR_RD_REGS                     = 0;    // Bit to write and read RAL REGISTERS
    
    // Typedefs for RAL and AXI-Lite
    typedef bit [REG_DATA_WIDTH-1:0]        reg_data;
    typedef bit [REG_ADDR_WIDTH-1:0]        reg_addr;
    // Typedes for AXI-Stream
    typedef bit [AXI_STREAM_DATA_WIDTH-1:0] axi_stream_data;
    typedef bit [AXI_STREAM_TID_WIDTH-1:0]  axi_stream_tid;
        
endpackage

`endif