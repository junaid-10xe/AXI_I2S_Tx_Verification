/*************************************************************************
   > File Name: i2s_tx_10xe_axis_sequencer.sv
   > Description: This file contains sequencer class to send sequences to driver.
   > Author: Muhammad Junaid Ramzan
   > Modified: Muhammad Junaid Ramzan
   > Mail: muhammad.junaid@10xengineers.ai
   ---------------------------------------------------------------
   Copyright   (c)2024 10xEngineers
   ---------------------------------------------------------------
************************************************************************/
`ifndef I2S_TX_10XE_AXIS_SEQUENCER
`define I2S_TX_10XE_AXIS_SEQUENCER
//  Class: i2s_tx_10xe_axis_sequencer
//
class i2s_tx_10xe_axis_sequencer extends uvm_sequencer #(i2s_tx_10xe_axis_seq_item);
    `uvm_component_utils(i2s_tx_10xe_axis_sequencer);
    
    //  Constructor: new
    function new(string name = "i2s_tx_10xe_axis_sequencer", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    
endclass: i2s_tx_10xe_axis_sequencer


`endif