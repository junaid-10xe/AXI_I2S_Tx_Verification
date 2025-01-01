/*************************************************************************
   > File Name: i2s_tx_10xe_dut_rsp_pkg.sv
   > Description: This file defines the DUT Package to include necsaary files required for DUT Response agent.
   > Author: Muhammad Junaid Ramzan
   > Modified: Muhammad Junaid Ramzan
   > Mail: muhammad.junaid@10xengineers.ai
   ---------------------------------------------------------------
   Copyright   (c)2024 10xEngineers
   ---------------------------------------------------------------
************************************************************************/
`ifdef  I2S_TX_10XE_DUT_RSP_PKG
`define I2S_TX_10XE_DUT_RSP_PKG
package i2s_tx_10xe_axi4_lite_pkg;
    // import the UVM library
  	import uvm_pkg::*;
  	// include the UVM macros
  	`include "uvm_macros.svh"

    //include  files
    `include "i2s_tx_10xe_dut_seq_item.sv"
    `include "i2s_tx_10xe_dut_monitor.sv"
    `include "i2s_tx_10xe_dut_agent.sv"
endpackage
`endif