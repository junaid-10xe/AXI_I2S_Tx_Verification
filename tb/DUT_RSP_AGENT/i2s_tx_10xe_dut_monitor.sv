/*************************************************************************
   > File Name: i2s_tx_10xe_dut_monitor.sv
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
// Class :: i2s_tx_10xe_dut_monitor
// Description :: This class monitors the output signals from DUT.
class i2s_tx_10xe_dut_monitor extends uvm_monitor;
    `uvm_component_utils(i2s_tx_10xe_dut_monitor)
    // Analysis Port to broadcast transactions to subscribers
    uvm_analysis_port #(i2s_tx_10xe_dut_seq_item) dut_a_port;

    // Virtual interface handle for DUT signals
    virtual i2s_tx_10xe_dut_intf    dut_vif;

    // Handle for the transaction object
    i2s_tx_10xe_dut_seq_item        dut_tr;

    // Constructor: Initializes the monitor
    function new(string name = "i2s_tx_10xe_dut_monitor", uvm_component parent);
        super.new(name, parent);
        `uvm_info(get_name(), "i2s_tx_10xe_dut_monitor created", UVM_DEBUG)
    endfunction: new

    // Build Phase: Creates analysis port and transaction object
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        // Initialize analysis port
        dut_a_port = new("dut_a_port", this);
        `uvm_info(get_name(), "Analysis port created", UVM_DEBUG)

        // Create transaction object
        dut_tr = i2s_tx_10xe_dut_seq_item::type_id::create("dut_tr", this);
        `uvm_info(get_name(), "Transaction object created", UVM_DEBUG)

        // Retrieve virtual interface from the UVM configuration database
        if (!uvm_config_db#(virtual i2s_tx_10xe_dut_intf)::get(this, "*", "dut_vif", dut_vif)) begin
            `uvm_fatal(get_name(), "Failed to get DUT Interface from Config DB")
        end else begin
            `uvm_info(get_name(), "DUT Interface successfully retrieved from Config DB", UVM_DEBUG)
        end
    endfunction: build_phase

    // Run Phase: Monitors signals and broadcasts transactions
    task run_phase(uvm_phase phase);
        
        forever begin
            
            @(posedge dut_vif.aud_mclk);
            `uvm_info(get_name(), "Clock edge detected", UVM_DEBUG)

            // Capture DUT signals into transaction object
            dut_tr.irq              = dut_vif.irq;
            dut_tr.lrclk_out        = dut_vif.lrclk_out;
            dut_tr.sclk_out         = dut_vif.sclk_out;
            dut_tr.sdata_0_out      = dut_vif.sdata_0_out;
            `uvm_info(get_name(), "DUT signals captured into transaction object", UVM_DEBUG)
                
            dut_a_port.write(dut_tr);
            // Log transaction at the configured verbosity level
            `uvm_info(get_name(), $sformatf("Printing transaction in DUT Monitor,\n%s", dut_tr.sprint()), UVM_LOW)
        end
    endtask: run_phase

endclass: i2s_tx_10xe_dut_monitor

`endif