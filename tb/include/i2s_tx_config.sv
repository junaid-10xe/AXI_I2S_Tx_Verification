/*************************************************************************
   > File Name: i2s_tx_config.sv
   > Description: This file defines config class to configure test becnh environment.
   > Author: Muhammad Junaid Ramzan
   > Modified: Muhammad Junaid Ramzan
   > Mail: muhammad.junaid@10xengineers.ai
   ---------------------------------------------------------------
   Copyright   (c)2024 10xEngineers
   ---------------------------------------------------------------
************************************************************************/
`ifndef I2S_TX_CONFIG
`define I2S_TX_CONFIG
// Class :: Config

class i2s_tx_config extends uvm_object;
    `uvm_object_utils(i2s_tx_config)

    // Constructor
    function new(string name = "i2s_tx_config");
        super.new();
    endfunction: new;

     // TODO will add these in config class later 
    // Parameters to control sequences of RAL
    i2s_tx_defines::data_pattern_e RAL_DATA_PATTERN    = ALL_ONES;
    bit CORE_CFG                                       = 1;    // Bit to cinfugure core
    bit AXI_STREAM_DATA_VALID                          = 0;    // Optional if we want to make data valid on stream 
    bit EN_DIS_INT                                     = 0;    // BIT to enable disable interrupt
    bit RD_REGS                                        = 1;    // Bit to READ RAL REGISTERS
    bit RD_REGS_IN_RST                                 = 1;    // BIT to read registers in reset phase
    bit WR_RD_REGS                                     = 0;    // Bit to write and read RAL REGISTERS
endclass
`endif