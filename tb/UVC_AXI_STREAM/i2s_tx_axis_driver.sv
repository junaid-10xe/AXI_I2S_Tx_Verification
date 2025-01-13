/*************************************************************************
   > File Name: i2s_tx_axis_driver.sv
   > Description: This file drives the signals to DUT using AXI4-Stream specifications.
   > Author: Muhammad Junaid Ramzan
   > Modified: Muhammad Junaid Ramzan
   > Mail: muhammad.junaid@10xengineers.ai
   ---------------------------------------------------------------
   Copyright   (c)2024 10xEngineers
   ---------------------------------------------------------------
************************************************************************/
`ifndef I2S_TX_10XE_AXIS_DRIVER
`define I2S_TX_10XE_AXIS_DRIVER
`define DRV_AXS axis_vif.axi_stream_driver

// Class: i2s_tx_axis_driver
class i2s_tx_axis_driver extends uvm_driver#(i2s_tx_axis_seq_item);
    `uvm_component_utils(i2s_tx_axis_driver);

    // Handle for transaction
    i2s_tx_axis_seq_item axis_tr;

    // Handle for interface
    virtual i2s_tx_axi_stream_intf axis_vif;

    // Constructor: new
    function new(string name = "i2s_tx_axis_driver", uvm_component parent);
        super.new(name, parent);
        `uvm_info(get_name(), "i2s_tx_axis_driver created", UVM_DEBUG)
    endfunction: new

    // Build Phase
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db#(virtual i2s_tx_axi_stream_intf)::get(this, "*", "axis_vif", axis_vif)) begin
            `uvm_fatal(get_name(), "Failed to get AXI-Stream Interface from Config DB")
        end else begin
            `uvm_info(get_name(), "AXI-Stream Interface successfully retrieved from Config DB", UVM_DEBUG)
        end
    endfunction: build_phase

    // Run phase to drive signals to DUT
    task run_phase(uvm_phase phase);
        wait(axis_vif.s_axis_aud_aresetn);
        
        forever begin
            `uvm_info(get_name(), "Waiting for next transaction", UVM_DEBUG)
            seq_item_port.get_next_item(axis_tr);

            // Debug message to verify transaction details
            `uvm_info(get_name(), $sformatf("Received transaction: \n%s", axis_tr.sprint()), UVM_HIGH)

            axis_drive();

            `uvm_info(get_name(), $sformatf("Data driven to DUT from AXI-Stream Driver:\n%s", axis_tr.sprint()), UVM_LOW)
            seq_item_port.item_done();
        end
    endtask: run_phase

    // Task to drive the AXI-Stream signals
    task axis_drive();
        // Drive only if tvalid signal is enabled
        // if (axis_tr.s_axis_aud_tvalid) begin
            `uvm_info(get_name(), "Driving AXI-Stream signals", UVM_DEBUG)
            @(posedge axis_vif.s_axis_aud_aclk);
            `DRV_AXS.s_axis_aud_tvalid <= axis_tr.s_axis_aud_tvalid;
            `DRV_AXS.s_axis_aud_tid    <= axis_tr.s_axis_aud_tid;
            `DRV_AXS.s_axis_aud_tdata  <= axis_tr.s_axis_aud_tdata;
            // Debug message before waiting for tready
            `uvm_info(get_name(), "Waiting for tready signal", UVM_DEBUG)

            if(axis_tr.s_axis_aud_tvalid) begin
                wait(`DRV_AXS.s_axis_aud_tready);
                axis_tr.s_axis_aud_tready  <= `DRV_AXS.s_axis_aud_tready;
                // @(posedge axis_vif.s_axis_aud_aclk);
                // `DRV_AXS.s_axis_aud_tvalid <= 0;
                
            end
        // end
        `uvm_info(get_name(), "AXI-Stream data driven successfully", UVM_DEBUG)
        
    endtask: axis_drive
endclass: i2s_tx_axis_driver

`endif