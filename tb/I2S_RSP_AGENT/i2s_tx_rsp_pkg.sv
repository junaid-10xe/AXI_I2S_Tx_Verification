/*************************************************************************
   > File Name: i2s_tx_rsp_pkg.sv
   > Description: This file defines the DUT Package to include necsaary files required for DUT Response agent.
   > Author: Muhammad Junaid Ramzan
   > Modified: Muhammad Junaid Ramzan
   > Mail: muhammad.junaid@10xengineers.ai
   ---------------------------------------------------------------
   Copyright   (c)2024 10xEngineers
   ---------------------------------------------------------------
************************************************************************/
`ifndef  I2S_TX__RSP_PKG
`define  I2S_TX__RSP_PKG
package i2s_tx_rsp_pkg;
    // import the UVM library
  	import uvm_pkg::*;
  	// include the UVM macros
  	`include "uvm_macros.svh"
    // Import defines
    import i2s_tx_defines::*;
    // include  files
    `include "i2s_tx_seq_item.sv"
    `include "i2s_tx_monitor.sv"
    `include "i2s_tx_agent.sv"
endpackage
`endif