/*************************************************************************
   > File Name: i2s_tx_10xe_axis_seq_item.sv
   > Description: This file contains all transaction signals of AXI-Stream 
   >              required for I2S transmitter functionality.
   > Author: Muhammad Junaid Ramzan
   > Modified: Muhammad Junaid Ramzan
   > Mail: muhammad.junaid@10xengineers.ai
   ---------------------------------------------------------------
   Copyright   (c)2024 10xEngineers
   ---------------------------------------------------------------
************************************************************************/
`ifndef I2S_TX_10XE_AXIS_SEQ_ITEM
`define I2S_TX_10XE_AXIS_SEQ_ITEM

// Class: i2s_tx_10xe_axis_seq_item
// Purpose: Defines transaction signals for AXI-Stream in I2S transmitter

class i2s_tx_10xe_axis_seq_item extends uvm_sequence_item;
    
    // Register the class with UVM factory
    `uvm_object_utils_begin(i2s_tx_10xe_axis_seq_item)
        `uvm_field_int(s_axis_aud_tdata, UVM_DEFAULT)
        `uvm_field_int(s_axis_aud_tvalid, UVM_DEFAULT)
        `uvm_field_int(s_axis_aud_tready, UVM_DEFAULT)
        `uvm_field_int(s_axis_aud_tid, UVM_DEFAULT)
    `uvm_object_utils_end

    //Constructor 
    function new(string name = "i2s_tx_10xe_axis_seq_item");
        super.new(name);
    endfunction: new

    // AXI-Stream signals for audio data transfer
    rand i2s_tx_10xe_defines::axi_stream_data s_axis_aud_tdata;       // Audio data
    rand i2s_tx_10xe_defines::axi_stream_tid  s_axis_aud_tid;         // Transaction ID
    rand bit                                  s_axis_aud_tvalid;      // Valid signal
    bit                                       s_axis_aud_tready;      // Ready signal

// Constraint for valid TDATA and TID
    constraint data_tid {
        s_axis_aud_tvalid       == 1;
        s_axis_aud_tdata[31]    == 1;  // Parity
        s_axis_aud_tdata[30]    == 1;  // Channel Status
        s_axis_aud_tdata[29]    == 0;  // USER bit
        s_axis_aud_tdata[28]    == 1;  // Validity Bit
        s_axis_aud_tdata[3:0]   == 4'b0010  ;//, 4'b0011};  // Specific valid values
        s_axis_aud_tid inside {3'b000, 3'b0001};
        s_axis_aud_tdata inside {[-8388608 : 8388607]};
    
        // Solve precedence
        // solve s_axis_aud_tdata before s_axis_aud_tid;
    
        // // Conditional TID assignment
        // if (s_axis_aud_tdata[3:0] == 4'b0001 )//|| s_axis_aud_tdata[3:0] == 4'b0010)
        //     s_axis_aud_tid == 3'b000;
        // else
        //     s_axis_aud_tid == 3'b001;
    }

endclass : i2s_tx_10xe_axis_seq_item

`endif // I2S_TX_10XE_AXIS_SEQ_ITEM