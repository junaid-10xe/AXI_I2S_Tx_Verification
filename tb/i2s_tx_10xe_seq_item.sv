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
        `uvm_field_int(s_axi_ctrl_awvalid)
        `uvm_field_int(s_axi_ctrl_awready)
        `uvm_field_int(s_axi_ctrl_awaddr)
        `uvm_field_int(s_axi_ctrl_wvalid)
        `uvm_field_int(s_axi_ctrl_wready)
        `uvm_field_int(s_axi_ctrl_wdata)
        `uvm_field_int(s_axi_ctrl_bvalid)
        `uvm_field_int(s_axi_ctrl_bready)
        `uvm_field_int(s_axi_ctrl_bresp)
        `uvm_field_int(s_axi_ctrl_arvalid)
        `uvm_field_int(s_axi_ctrl_arready)
        `uvm_field_int(s_axi_ctrl_araddr)
        `uvm_field_int(s_axi_ctrl_rvalid)
        `uvm_field_int(s_axi_ctrl_rready)
        `uvm_field_int(s_axi_ctrl_rdata)
        `uvm_field_int(s_axi_ctrl_rresp)
        `uvm_field_int(s_axis_aud_tdata)
        `uvm_field_int(s_axis_aud_tvalid)
        `uvm_field_int(s_axis_aud_tready)
        `uvm_field_int(s_axis_aud_tid)
        `uvm_field_int(irq)
        `uvm_field_int(lrclk_out)
        `uvm_field_int(sclk_out)
        `uvm_field_int(sdata_0_out)
    `uvm_object_utils_end

    //Constructor 
    function new(string name = "i2s_tx_10xe_seq_item");
        super.new(name)
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

endclass : i2s_tx_10xe_seq_item

`endif
