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

     
    // Parameters to control sequences of RAL
    i2s_tx_defines::data_pattern_e RAL_DATA_PATTERN    = ALL_ONES;
    bit CORE_CFG                                       = 1;    // Bit to cinfugure core
    bit AXI_STREAM_DATA_VALID                          = 0;    // Optional if we want to make data valid on stream 
    bit EN_DIS_INT                                     = 0;    // BIT to enable disable interrupt

    // Configuration for axi-stream
    int NUM_TRANS                                     = 200;
    bit LEFT_JUSTICATION                              = 0;
    bit RIGHT_JUSTICATION                             = 0;

    //bit to control slave sequence in axi4-lite interface by default it will be zero
    bit INTRPT_STAT_TEST                              = 0;
    // Parameters to start corresponding test for RAL
    // Use these Bits when running test ral test  
    bit RD_REGS_IN_RST                                 = 0;    // BIT to read registers in reset phase start reset test
    bit RD_REGS                                        = 0;    // Bit to READ RAL REGISTERS
    bit WR_RD_REGS                                     = 1;    // Bit to write and read RAL REGISTERS Start random write values on registers or 
                                                               // all ones or zeros on registers or random value
    bit CORE_VER_TEST                                  = 0;    // Bit to start test for core version test 
    bit CORE_CFG_TEST                                  = 0;    // Bit to start test for core configuration test
    bit RD_REGS_DFT                                    = 0;    // Bit to start test for read registers default test
    bit REG_RO_FIELDS                                  = 0;
    bit REG_RW_FIELDS                                  = 0;

    // Bits to control test cases for AXI-Stream


endclass
`endif