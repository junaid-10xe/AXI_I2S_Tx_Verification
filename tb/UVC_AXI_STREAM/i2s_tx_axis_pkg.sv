/*************************************************************************
   > File Name: i2s_tx_axis_pkg.sv
   > Description: This file defines the AXI-Stream Package to include necsaary files required for UVC of AXI-Stream.
   > Author: Muhammad Junaid Ramzan
   > Modified: Muhammad Junaid Ramzan
   > Mail: muhammad.junaid@10xengineers.ai
   ---------------------------------------------------------------
   Copyright   (c)2024 10xEngineers
   ---------------------------------------------------------------
************************************************************************/
`ifndef I2S_TX_AXIS_PKG
`define I2S_TX_AXIS_PKG
package i2s_tx_axis_pkg;
    // import the UVM library
  	import uvm_pkg::*;
  	// include the UVM macros
  	`include "uvm_macros.svh"
    // Import defines
    import i2s_tx_defines::*;
    //include UVC files
    `include "../../sim/axis_seq/i2s_tx_axis_seq_item.sv"
    `include "../../sim/axis_seq/i2s_tx_axis_base_seq.sv"
    `include "../../sim/axis_seq/i2s_tx_axis_seqs_lib.sv"
    `include "i2s_tx_axis_sequencer.sv"
    `include "i2s_tx_axis_monitor.sv"
    `include "i2s_tx_axis_driver.sv"
    `include "i2s_tx_axis_agent.sv"
endpackage

`endif
