/*************************************************************************
   > File Name: i2s_tx_10xe_axi4_lite_sequencer.sv
   > Description: This file contains sequencer class to send sequences to driver.
   > Author: Muhammad Junaid Ramzan
   > Modified: Muhammad Junaid Ramzan
   > Mail: muhammad.junaid@10xengineers.ai
   ---------------------------------------------------------------
   Copyright   (c)2024 10xEngineers
   ---------------------------------------------------------------
************************************************************************/
`ifndef I2S_TX_10XE_AXI4_LITE_SEQUENCER
`define I2S_TX_10XE_AXI4_LITE_SEQUENCER
// Class: i2s_tx_10xe_axi4_lite_sequencer
class i2s_tx_10xe_axi4_lite_sequencer extends uvm_sequencer #(i2s_tx_10xe_axi4_lite_seq_item);
    `uvm_component_utils(i2s_tx_10xe_axi4_lite_sequencer);
    
    // Constructor: new
    function new(string name = "i2s_tx_10xe_axi4_lite_sequencer", uvm_component parent);
        super.new(name, parent);
    endfunction: new
endclass: i2s_tx_10xe_axi4_lite_sequencer

`endif