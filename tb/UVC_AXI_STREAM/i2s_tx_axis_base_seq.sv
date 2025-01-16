/*************************************************************************
   > File Name: i2s_tx_axis_base_seq.sv
   > Description: This file contains sequence classes for AXI-Stream in I2S.
   > Author: Muhammad Junaid Ramzan
   > Modified: Muhammad Junaid Ramzan
   > Mail: muhammad.junaid@10xengineers.ai
   ---------------------------------------------------------------
   Copyright   (c)2024 10xEngineers
   ---------------------------------------------------------------
************************************************************************/
`ifndef I2S_TX_AXIS_BASE_SEQ
`define I2S_TX_AXIS_BASE_SEQ
// Class: i2s_tx_axis_base_seq
// Description: Base sequence for AXI-Stream
class i2s_tx_axis_base_seq extends uvm_sequence;
    `uvm_object_utils(i2s_tx_axis_base_seq);
    
    // Handle of Transaction Item
    i2s_tx_axis_seq_item axis_seq;
    // Handle of config class
    i2s_tx_config cfg;

    //  Constructor: new
    function new(string name = "i2s_tx_axis_base_seq");
        super.new(name);
    endfunction: new


endclass: i2s_tx_axis_base_seq

`endif // I2S_TX_AXIS_SEQ