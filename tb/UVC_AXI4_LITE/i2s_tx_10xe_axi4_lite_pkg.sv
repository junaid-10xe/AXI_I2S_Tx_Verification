/*************************************************************************
   > File Name: i2s_tx_10xe_axi4_lite_pkg.sv
   > Description: This file defines the AXI-Stream Package to include necsaary files required for UVC of AXI-Stream.
   > Author: Muhammad Junaid Ramzan
   > Modified: Muhammad Junaid Ramzan
   > Mail: muhammad.junaid@10xengineers.ai
   ---------------------------------------------------------------
   Copyright   (c)2024 10xEngineers
   ---------------------------------------------------------------
************************************************************************/
`ifndef I2S_TX_10XE_AXI4_LITE_PKG
`define I2S_TX_10XE_AXI4_LITE_PKG
package i2s_tx_10xe_axi4_lite_pkg;
    // import the UVM library
  	import uvm_pkg::*;

  	// include the UVM macros
  	`include "uvm_macros.svh"

    //TODO import param package
    //

    //include UVC files
    `include "i2s_tx_10xe_axi4_lite_seq_item.sv"
    `include "UVM_RAL/i2s_tx_10xe_reg.sv"
    `include "UVM_RAL/i2s_tx_10xe_reg_blk.sv"
    `include "UVM_RAL/i2s_tx_10xe_reg_seqs.sv"
    `include "UVM_RAL/i2s_tx_10xe_adapter.sv"

    `include "i2s_tx_10xe_axi4_lite_seq.sv"
    `include "i2s_tx_10xe_axi4_lite_sequencer.sv"
    `include "i2s_tx_10xe_axi4_lite_monitor.sv"
    `include "i2s_tx_10xe_axi4_lite_driver.sv"
    `include "i2s_tx_10xe_axi4_lite_agent.sv"
endpackage

`endif