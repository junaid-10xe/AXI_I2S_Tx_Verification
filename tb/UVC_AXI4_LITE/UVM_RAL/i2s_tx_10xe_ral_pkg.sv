/*************************************************************************
   > File Name: i2s_tx_10xe_ral_pkg.sv
   > Description: This file defines the RAL Package to include necsaary files required for RAL.
   > Author: Muhammad Junaid Ramzan
   > Modified: Muhammad Junaid Ramzan
   > Mail: muhammad.junaid@10xengineers.ai
   ---------------------------------------------------------------
   Copyright   (c)2024 10xEngineers
   ---------------------------------------------------------------
************************************************************************/
`ifndef I2S_TX_10XE_RAL_PKG
`define I2S_TX_10XE_RAL_PKG
package i2s_tx_10xe_ral_pkg;
    // import the UVM library
  	import uvm_pkg::*;

  	// include the UVM macros
  	`include "uvm_macros.svh"

    //TODO import param package
    //

    //include UVC files
    `include "../UVC_AXI4_LITE/i2s_tx_10xe_axi4_lite_seq_item.sv"
    `include "i2s_tx_10xe_reg_seqs.sv"
    `include "i2s_tx_10xe_reg.sv"
    `include "i2s_tx_10xe_reg_blk.sv"
    `include "i2s_tx_10xe_adapter.sv"
endpackage

`endif