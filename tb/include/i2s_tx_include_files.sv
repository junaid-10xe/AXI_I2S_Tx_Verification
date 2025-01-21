/*************************************************************************
   > File Name: i2s_tx_include_files.sv
   > Description: This file include the all necessary files and import packages required for test bench environment.
   > Author: Muhammad Junaid Ramzan
   > Modified: Muhammad Junaid Ramzan
   > Mail: muhammad.junaid@10xengineers.ai
   ---------------------------------------------------------------
   Copyright   (c)2024 10xEngineers
   ---------------------------------------------------------------
************************************************************************/
`ifndef I2S_TX_FILES
`define I2S_TX_FILES

// include the UVM macros
`include "uvm_macros.svh"
// import the UVM library
 import uvm_pkg::*;

// Import defines
import i2s_tx_defines::*;
// Include Interfaces
`include "../UVC_AXI4_LITE/i2s_tx_axi4_lite_intf.sv"
`include "../UVC_AXI_STREAM/i2s_tx_axi_stream_intf.sv"
`include "../I2S_RSP_AGENT/i2s_tx_intf.sv"


// Import AXI4-LITE UVC PKG to include files
import i2s_tx_axi4_lite_pkg::*;

// Import AXI-STream PKG to include files
import i2s_tx_axis_pkg::*;
// Import DUT PKG to include files
import i2s_tx_rsp_pkg::*;

// Include files
`include "../scoreboard/i2s_tx_scoreboard.sv"
`include "../coverage/i2s_tx_coverage.sv"
`include "../env/i2s_tx_env.sv"
`include "../test_top/i2s_tx_base_test.sv"
`include "../test_top/i2s_tx_tests_lib.sv"

`endif