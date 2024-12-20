/*************************************************************************
   > File Name: i2s_tx_10xe_axis_driver.sv
   > Description: This file drives the signals to dut using axi4-lite specifications.
   > Author: Muhammad Junaid Ramzan
   > Modified: Muhammad Junaid Ramzan
   > Mail: muhammad.junaid@10xengineers.ai
   ---------------------------------------------------------------
   Copyright   (c)2024 10xEngineers
   ---------------------------------------------------------------
************************************************************************/
`ifndef I2S_TX_10XE_AXIS_DRIVER
`define I2S_TX_10XE_AXIS_DRIVER
`define DRV_AXS axis_vif.DRIVER.axi_stream_driver

//  Class: i2s_tx_10xe_axis_driver
//
class i2s_tx_10xe_axis_driver extends uvm_driver#(i2s_tx_10xe_seq_item);
    `uvm_component_utils(i2s_tx_10xe_axis_driver);

    //Handle for transaction 
    i2s_tx_10xe_seq_item            axis_tr;
    //Handle for interface
    virtual i2s_tx_10xe_axi_stream_intf     axis_vif;
    //  Constructor: new
    function new(string name = "i2s_tx_10xe_axis_driver", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    //Build Phase

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(virtual i2s_tx_10xe_axi_stream_intf)::get(this, "*", "axis_vif", axis_vif)) begin
            `uvm_fatal(get_name(), "Failed to get AXI-Stream Interface from Config DB")
        end
    endfunction: build_phase


    //Run phase to drive signals to DUT
    task run_phase(uvm_phase phase);
        forever begin
            
            seq_item_port.get_next_item(axis_tr);
            axis_drive();
            `uvm_info(get_name(),$sformatf(" Data Driven to DUT from Axi-Stream Driver, \n  %s",axis_tr.sprint()),UVM_LOW)
            seq_item_port.item_done();
        end
    endtask: run_phase

    task axis_drive();
        // drive only if we had va;lid signal enabled
        if (axis_tr.s_axis_aud_tvalid) begin
            @(posedge axis_vif.s_axis_aud_aclk);
            `DRV_AXS.s_axis_aud_tvalid <= axis_tr.s_axis_aud_tvalid;
            `DRV_AXS.s_axis_aud_tid    <= axis_tr.s_axis_aud_tid;
            wait(`DRV_AXS.s_axis_aud_tready);
            @(posedge axis_vif.s_axis_aud_aclk);
            `DRV_AXS.s_axis_aud_tdata  <= axis_tr.s_axis_aud_tdata;

        end

    endtask: axis_drive
endclass: i2s_tx_10xe_axis_driver

`endif