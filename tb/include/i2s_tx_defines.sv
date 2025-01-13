/*************************************************************************
   > File Name: i2s_tx_defines.sv
   > Description: This file defines the variables to control the testbench environment  
   for I2S transmitter functionality.
   > Author: Muhammad Junaid Ramzan
   > Modified: Muhammad Junaid Ramzan
   > Mail: muhammad.junaid@10xengineers.ai
   ---------------------------------------------------------------
   Copyright   (c)2024 10xEngineers
   ---------------------------------------------------------------
************************************************************************/
`ifndef I2S_TX_DEFINES
`define I2S_TX_DEFINES

package i2s_tx_defines;
    // include the UVM macros
    `include "uvm_macros.svh"
    // import the UVM library
  	import uvm_pkg::*;
    //Import Parameters
    import i2s_tx_params::*;
    // Enum Used in RAL
    typedef enum logic [1:0] { 
        ALL_ZERO = 2'b00,
        ALL_ONES = 2'b01,
        RANDOM   = 2'b10,
        DEFAULT  = 2'b11
     } data_pattern_e;
 
    // Typedefs for RAL and AXI-Lite
    typedef bit [REG_DATA_WIDTH-1:0]        reg_data;
    typedef bit [REG_ADDR_WIDTH-1:0]        reg_addr;
    // Typedes for AXI-Stream
    typedef bit [AXI_STREAM_DATA_WIDTH-1:0] axi_stream_data;
    typedef bit [AXI_STREAM_TID_WIDTH-1:0]  axi_stream_tid;

    //include config class
    `include "i2s_tx_config.sv"
        
endpackage

`endif