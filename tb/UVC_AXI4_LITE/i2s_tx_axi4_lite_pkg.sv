/*************************************************************************
   > File Name: i2s_tx_axi4_lite_pkg.sv
   > Description: This file defines the AXI-Stream Package to include necsaary files required for UVC of AXI-Stream.
   > Author: Muhammad Junaid Ramzan
   > Modified: Muhammad Junaid Ramzan
   > Mail: muhammad.junaid@10xengineers.ai
   ---------------------------------------------------------------
   Copyright   (c)2024 10xEngineers
   ---------------------------------------------------------------
************************************************************************/
`ifndef I2S_TX_AXI4_LITE_PKG
`define I2S_TX_AXI4_LITE_PKG
package i2s_tx_axi4_lite_pkg;
    // import the UVM library
  	import uvm_pkg::*;

  	// include the UVM macros
  	`include "uvm_macros.svh"
        // Import defines
    import i2s_tx_defines::*;

    //include UVC files
    `include "../../sim/reg_seq/i2s_tx_axi4_lite_seq_item.sv"
    `include "UVM_RAL/i2s_tx_reg.sv"
    `include "UVM_RAL/i2s_tx_reg_blk.sv"
    `include "../../sim/reg_seq/i2s_tx_reg_base_seq.sv"
    `include "../../sim/reg_seq/i2s_tx_reg_seqs_lib.sv"
    `include "UVM_RAL/i2s_tx_adapter.sv"

    `include "i2s_tx_axi4_lite_sequencer.sv"
    `include "i2s_tx_axi4_lite_monitor.sv"
    `include "i2s_tx_axi4_lite_driver.sv"
    `include "i2s_tx_axi4_lite_agent.sv"
endpackage

`endif
