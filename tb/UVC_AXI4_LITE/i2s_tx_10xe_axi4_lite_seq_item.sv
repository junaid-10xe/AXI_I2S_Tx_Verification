/*************************************************************************
   > File Name: i2s_tx_10xe_axi4_lite_seq_item.sv
   > Description: This file contains all transaction signals of AXI4_Lite required for I2S transmitter functionality.
   > Author: Muhammad Junaid Ramzan
   > Modified: Muhammad Junaid Ramzan
   > Mail: muhammad.junaid@10xengineers.ai
   ---------------------------------------------------------------
   Copyright   (c)2024 10xEngineers
   ---------------------------------------------------------------
************************************************************************/
`ifndef I2S_TX_10XE_AXI4_LITE_SEQ_ITEM
`define I2S_TX_10XE_AXI4_LITE_SEQ_ITEM

// Class: i2s_tx_10xe_axi4_lite_seq_item
// This class defines the AXI4-Lite transaction signals used by the I2S transmitter.
class i2s_tx_10xe_axi4_lite_seq_item extends uvm_sequence_item;

    // Register the sequence item with the UVM factory and define fields for comparison and printing
    `uvm_object_utils_begin(i2s_tx_10xe_axi4_lite_seq_item)
        `uvm_field_int(s_axi_ctrl_awvalid, UVM_DEFAULT) // Address write valid signal
        `uvm_field_int(s_axi_ctrl_awready, UVM_DEFAULT) // Address write ready signal
        `uvm_field_int(s_axi_ctrl_awaddr, UVM_DEFAULT)  // Address write address
        `uvm_field_int(s_axi_ctrl_wvalid, UVM_DEFAULT)  // Write data valid signal
        `uvm_field_int(s_axi_ctrl_wready, UVM_DEFAULT)  // Write data ready signal
        `uvm_field_int(s_axi_ctrl_wdata, UVM_DEFAULT)   // Write data
        `uvm_field_int(s_axi_ctrl_bvalid, UVM_DEFAULT)  // Write response valid signal
        `uvm_field_int(s_axi_ctrl_bready, UVM_DEFAULT)  // Write response ready signal
        `uvm_field_int(s_axi_ctrl_bresp, UVM_DEFAULT)   // Write response
        `uvm_field_int(s_axi_ctrl_arvalid, UVM_DEFAULT) // Read address valid signal
        `uvm_field_int(s_axi_ctrl_arready, UVM_DEFAULT) // Read address ready signal
        `uvm_field_int(s_axi_ctrl_araddr, UVM_DEFAULT)  // Read address
        `uvm_field_int(s_axi_ctrl_rvalid, UVM_DEFAULT)  // Read data valid signal
        `uvm_field_int(s_axi_ctrl_rready, UVM_DEFAULT)  // Read data ready signal
        `uvm_field_int(s_axi_ctrl_rdata, UVM_DEFAULT)   // Read data
        `uvm_field_int(s_axi_ctrl_rresp, UVM_DEFAULT)   // Read response
    `uvm_object_utils_end

    // Constructor: Initializes the sequence item with a default name
    function new(string name = "i2s_tx_10xe_axi4_lite_seq_item");
        super.new(name);
    endfunction: new

    // AXI4-Lite signals for different channels

    // Address Write Channel
    rand bit                    s_axi_ctrl_awvalid;     // Address write valid
    bit                         s_axi_ctrl_awready;     // Address write ready
    randc bit [7:0]              s_axi_ctrl_awaddr;     // Write address

    // Write Data Channel
    rand bit                    s_axi_ctrl_wvalid;      // Write data valid
    bit                         s_axi_ctrl_wready;      // Write data ready
    rand bit [31:0]             s_axi_ctrl_wdata;       // Write data

    // Write Response Channel
    bit                         s_axi_ctrl_bvalid;      // Write response valid
    rand bit                    s_axi_ctrl_bready;      // Write response ready
    bit [1:0]                   s_axi_ctrl_bresp;       // Write response

    // Read Address Channel
    rand bit                    s_axi_ctrl_arvalid;     // Read address valid
    bit                         s_axi_ctrl_arready;     // Read address ready
    randc bit [7:0]              s_axi_ctrl_araddr;     // Read address

    // Read Data Channel
    bit                         s_axi_ctrl_rvalid;      // Read data valid
    rand bit                    s_axi_ctrl_rready;      // Read data ready
    bit [1:0]                   s_axi_ctrl_rresp;       // Read response
    bit [31:0]                  s_axi_ctrl_rdata;       // Read data
    
endclass: i2s_tx_10xe_axi4_lite_seq_item

`endif   //I2S_TX_10XE_AXI4_LITE_SEQ_ITEM