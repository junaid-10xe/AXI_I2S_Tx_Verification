/*************************************************************************
   > File Name: i2s_tx_10xe_dut_seq_item.sv
   > Description: This file contains all transaction signals of that are the output of DUT
   > Author: Muhammad Junaid Ramzan
   > Modified: Muhammad Junaid Ramzan
   > Mail: muhammad.junaid@10xengineers.ai
   ---------------------------------------------------------------
   Copyright   (c)2024 10xEngineers
   ---------------------------------------------------------------
************************************************************************/
`ifndef I2S_TX_10XE_DUT_SEQ_ITEM
`define I2S_TX_10XE_DUT_SEQ_ITEM
//Class :: i2s_tx_10xe_dut_seq_item
//Description :: This class contains all transaction signals of that are the output of DUT
class i2s_tx_10xe_dut_seq_item extends uvm_sequence_item;
    `uvm_object_utils_begin(i2s_tx_10xe_dut_seq_item)
        `uvm_field_int(irq, UVM_DEFAULT)
        `uvm_field_int(lrclk_out, UVM_DEFAULT)
        `uvm_field_int(sclk_out, UVM_DEFAULT)
        `uvm_field_int(sdata_0_out, UVM_DEFAULT)
    `uvm_object_utils_end

    //Constructor
    function new(string name = "i2s_tx_10xe_dut_seq_item");
        super.new(name);
    endfunction
    //Signal :: i2s_tx_10xe_dut_seq_item
    
    bit     irq;            // Interrupt signal indicating an event
    bit     lrclk_out;      // Left-right clock signal for audio synchronization
    bit     sclk_out;       // Serial clock output for audio data transmission
    bit     sdata_0_out;    // Serial data output
endclass: i2s_tx_10xe_dut_seq_item

`endif