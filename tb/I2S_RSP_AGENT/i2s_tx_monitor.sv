/*************************************************************************
   > File Name: i2s_tx_monitor.sv
   > Description: This file monitors the output signals from DUT.
   > Author: Muhammad Junaid Ramzan
   > Modified: Muhammad Junaid Ramzan
   > Mail: muhammad.junaid@10xengineers.ai
   ---------------------------------------------------------------
   Copyright   (c)2024 10xEngineers
   ---------------------------------------------------------------
************************************************************************/
`ifndef I2S_TX_10XE_DUT_MONITOR
`define I2S_TX_10XE_DUT_MONITOR
// Class :: i2s_tx_monitor
// Description :: This class monitors the output signals from DUT.
class i2s_tx_monitor extends uvm_monitor;
    `uvm_component_utils(i2s_tx_monitor)
    // Analysis Port to broadcast transactions to subscribers
    uvm_analysis_port #(i2s_tx_seq_item) i2s_a_port;

    // Virtual interface handle for DUT/I2s output signals signals
    virtual i2s_tx_intf    i2s_vif;

    // Handle for the transaction object
    i2s_tx_seq_item        i2s_tr;

    // Constructor: Initializes the monitor
    function new(string name = "i2s_tx_monitor", uvm_component parent);
        super.new(name, parent);
        `uvm_info(get_name(), "i2s_tx_monitor created", UVM_DEBUG)
    endfunction: new

    // Build Phase: Creates analysis port and transaction object
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        // Initialize analysis port
        i2s_a_port = new("i2s_a_port", this);
        `uvm_info(get_name(), "Analysis port created", UVM_DEBUG)

        // Retrieve virtual interface from the UVM configuration database
        if (!uvm_config_db#(virtual i2s_tx_intf)::get(this, "*", "i2s_vif", i2s_vif)) begin
            `uvm_fatal(get_name(), "Failed to get DUT Interface from Config DB")
        end else begin
            `uvm_info(get_name(), "DUT Interface successfully retrieved from Config DB", UVM_DEBUG)
        end
    endfunction: build_phase

    // Run Phase: Monitors signals and broadcasts transactions
    task run_phase(uvm_phase phase);
        repeat(3) @(posedge i2s_vif.lrclk_out);
        @(negedge i2s_vif.lrclk_out);
        @(posedge i2s_vif.sclk_out);
        
        forever begin
            // Create transaction object
            i2s_tr = i2s_tx_seq_item::type_id::create("i2s_tr", this);
            `uvm_info(get_name(), "Transaction object created", UVM_DEBUG)
            for (int i=0; i<24; ++i) begin
                @(posedge i2s_vif.sclk_out);
                `uvm_info(get_name(), "Clock edge detected", UVM_DEBUG)

                // Capture DUT signals into transaction object
                i2s_tr.irq                      = i2s_vif.irq;
                i2s_tr.lrclk_out                = i2s_vif.lrclk_out;
                i2s_tr.sclk_out                 = i2s_vif.sclk_out;
                i2s_tr.sdata_0_out[23-i]        = i2s_vif.sdata_0_out;
            end
            `uvm_info(get_name(), "DUT signals captured into transaction object", UVM_LOW)
            `uvm_info(get_name(), $sformatf("Printing transaction in DUT Monitor,\n%s", i2s_tr.sprint()), UVM_LOW)    
            i2s_a_port.write(i2s_tr);
            // Log transaction at the configured verbosity level
        end
    endtask: run_phase

endclass: i2s_tx_monitor

`endif