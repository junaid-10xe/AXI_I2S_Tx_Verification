/*************************************************************************
   > File Name: i2s_tx_10xe_seq_item.sv
   > Description: This file contains all transaction signals required for I2S transmitter functionality.
   > Author: Muhammad Junaid Ramzan
   > Modified: Muhammad Junaid Ramzan
   > Mail: muhammad.junaid@10xengineers.ai
   ---------------------------------------------------------------
   Copyright   (c)2024 10xEngineers
   ---------------------------------------------------------------
************************************************************************/
`ifndef I2S_TX_10XE_SEQ_ITEM
`define I2S_TX_10XE_SEQ_ITEM
class i2s_tx_10xe_seq_item extends uvm_sequence_item;
    `uvm_object_utils_begin(i2s_tx_10xe_seq_item)
        `uvm_field_int(s_axi_ctrl_awvalid, UVM_DEFAULT)
        `uvm_field_int(s_axi_ctrl_awready, UVM_DEFAULT)
        `uvm_field_int(s_axi_ctrl_awaddr, UVM_DEFAULT)
        `uvm_field_int(s_axi_ctrl_wvalid, UVM_DEFAULT)
        `uvm_field_int(s_axi_ctrl_wready, UVM_DEFAULT)
        `uvm_field_int(s_axi_ctrl_wdata, UVM_DEFAULT)
        `uvm_field_int(s_axi_ctrl_bvalid, UVM_DEFAULT)
        `uvm_field_int(s_axi_ctrl_bready, UVM_DEFAULT)
        `uvm_field_int(s_axi_ctrl_bresp, UVM_DEFAULT)
        `uvm_field_int(s_axi_ctrl_arvalid, UVM_DEFAULT)
        `uvm_field_int(s_axi_ctrl_arready, UVM_DEFAULT)
        `uvm_field_int(s_axi_ctrl_araddr, UVM_DEFAULT)
        `uvm_field_int(s_axi_ctrl_rvalid, UVM_DEFAULT)
        `uvm_field_int(s_axi_ctrl_rready, UVM_DEFAULT)
        `uvm_field_int(s_axi_ctrl_rdata, UVM_DEFAULT)
        `uvm_field_int(s_axi_ctrl_rresp, UVM_DEFAULT)
        `uvm_field_int(s_axis_aud_tdata, UVM_DEFAULT)
        `uvm_field_int(s_axis_aud_tvalid, UVM_DEFAULT)
        `uvm_field_int(s_axis_aud_tready, UVM_DEFAULT)
        `uvm_field_int(s_axis_aud_tid, UVM_DEFAULT)
        `uvm_field_int(irq, UVM_DEFAULT)
        `uvm_field_int(lrclk_out, UVM_DEFAULT)
        `uvm_field_int(sclk_out, UVM_DEFAULT)
        `uvm_field_int(sdata_0_out, UVM_DEFAULT)
    `uvm_object_utils_end

    //Constructor 
    function new(string name = "i2s_tx_10xe_seq_item");
        super.new(name);
    endfunction: new

//Signals for AXI4 Lite 
//for address write channel 
    rand bit                    s_axi_ctrl_awvalid;
    bit                         s_axi_ctrl_awready;
    rand bit [7:0]              s_axi_ctrl_awaddr;
    //for write data channel
    rand bit                    s_axi_ctrl_wvalid;
    bit                         s_axi_ctrl_wready;
    rand bit [31:0]             s_axi_ctrl_wdata;
    //for write response channel
    bit                         s_axi_ctrl_bvalid;
    rand bit                    s_axi_ctrl_bready;
    bit [1:0]                   s_axi_ctrl_bresp;
    //for read address channel
    rand bit                    s_axi_ctrl_arvalid;
    bit                         s_axi_ctrl_arready;
    rand bit [7:0]              s_axi_ctrl_araddr;
    //for read data channel
    bit                         s_axi_ctrl_rvalid;
    rand bit                    s_axi_ctrl_rready;
    bit [1:0]                   s_axi_ctrl_rresp;
    bit [31:0]                  s_axi_ctrl_rdata;

//Signals for AXI Stream
// AXI-Stream signals for audio data transfer
    rand bit [31:0]             s_axis_aud_tdata;
    rand bit [2:0]              s_axis_aud_tid;
    rand bit                    s_axis_aud_tvalid;
    bit                         s_axis_aud_tready;

//DUT Signals other than AXI4-Lite and Stream
    // Interrupt signal indicating an event
    bit irq;

    // Left-right clock signal for audio synchronization
    bit lrclk_out;

    // Serial clock output for audio data transmission
    bit sclk_out;

    // Serial data output
    bit sdata_0_out;


    //Constraints 
    // Constraint to ensure only relevant registers are read during AXI transactions
    // constraint read_reg {
    //     // Allow read address valid signal to be active
    //     s_axi_ctrl_arvalid == 1;
    
    //     // Restrict read address to specific register addresses
    //     s_axi_ctrl_araddr inside {
    //         'h00, 'h04, 'h08, 'h0C, 'h10, 'h14, 
    //         'h20, 'h30, 'h34, 'h38, 'h3C, 'h50, 
    //         'h54, 'h58, 'h5C, 'h60, 'h64
    //     };
    
    //     // Ensure read ready signal is active
    //     s_axi_ctrl_rready == 1;
    
    //     // Ensure write operations are not active
    //     s_axi_ctrl_awvalid == 0;
    //     s_axi_ctrl_wvalid == 0;
    // }
    //TODO (later) add constraint for write transaction so that wdata should be alligned with the given address and also write solves before constraints to make sure that one register is written before another 
    

endclass : i2s_tx_10xe_seq_item

`endif
