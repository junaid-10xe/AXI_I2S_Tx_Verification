/*************************************************************************
   > File Name: i2s_tx_10xe_axis_monitor.sv
   > Description: This file monitors the signals from DUT using AXI-Stream specifications.
   > Author: Muhammad Junaid Ramzan
   > Modified: Muhammad Junaid Ramzan
   > Mail: muhammad.junaid@10xengineers.ai
   ---------------------------------------------------------------
   Copyright   (c)2024 10xEngineers
   ---------------------------------------------------------------
************************************************************************/

`ifndef I2S_TX_10XE_AXIS_MONITOR
`define I2S_TX_10XE_AXIS_MONITOR
`define MON_AXS axis_vif.MONITOR.axi_stream_monitor

// Class: i2s_tx_10xe_axis_monitor
// Monitors AXI-Stream signals and broadcasts transactions to an analysis port.
class i2s_tx_10xe_axis_monitor extends uvm_monitor;
    `uvm_component_utils(i2s_tx_10xe_axis_monitor)

    // Analysis Port to broadcast transactions to subscribers
    uvm_analysis_port #(i2s_tx_10xe_axis_seq_item) axis_a_port;

    // Virtual interface handle for AXI-Stream signals
    virtual i2s_tx_10xe_axi_stream_intf axis_vif;

    // Handle for the transaction object
    i2s_tx_10xe_axis_seq_item axis_tr;

    // Constructor: Initializes the monitor
    function new(string name = "i2s_tx_10xe_axis_monitor", uvm_component parent);
        super.new(name, parent);
        `uvm_info(get_name(), "i2s_tx_10xe_axis_monitor created", UVM_DEBUG)
    endfunction: new

    // Build Phase: Creates analysis port and transaction object
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        // Initialize analysis port
        axis_a_port = new("axis_a_port", this);
        `uvm_info(get_name(), "Analysis port created", UVM_DEBUG)

        // Create transaction object
        axis_tr = i2s_tx_10xe_axis_seq_item::type_id::create("axis_tr", this);
        `uvm_info(get_name(), "Transaction object created", UVM_DEBUG)

        // Retrieve virtual interface from the UVM configuration database
        if (!uvm_config_db#(virtual i2s_tx_10xe_axi_stream_intf)::get(this, "*", "axis_vif", axis_vif)) begin
            `uvm_fatal(get_name(), "Failed to get AXI-Stream Interface from Config DB")
        end else begin
            `uvm_info(get_name(), "AXI-Stream Interface successfully retrieved from Config DB", UVM_DEBUG)
        end
    endfunction: build_phase

    // Run Phase: Monitors signals and broadcasts transactions
    task run_phase(uvm_phase phase);
        forever begin
            // Wait for two positive edges of the clock to stabilize signals
            repeat (2) @(posedge axis_vif.s_axis_aud_aclk);
            `uvm_info(get_name(), "Clock edge detected", UVM_DEBUG)

            // Capture AXI-Stream signals into transaction object
            axis_tr.s_axis_aud_tvalid = `MON_AXS.s_axis_aud_tvalid;
            axis_tr.s_axis_aud_tready = `MON_AXS.s_axis_aud_tready;
            axis_tr.s_axis_aud_tid    = `MON_AXS.s_axis_aud_tid;
            axis_tr.s_axis_aud_tdata  = `MON_AXS.s_axis_aud_tdata;
            `uvm_info(get_name(), "AXI-Stream signals captured into transaction object", UVM_DEBUG)

            // Broadcast transaction to analysis port
            axis_a_port.write(axis_tr);

            // Log transaction at the configured verbosity level
            `uvm_info(get_name(), $sformatf("Printing transaction in AXI-Stream Monitor,\n%s", axis_tr.sprint()), UVM_LOW)
        end
    endtask: run_phase

endclass: i2s_tx_10xe_axis_monitor

`endif