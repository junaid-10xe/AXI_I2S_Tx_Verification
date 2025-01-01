/*************************************************************************
   > File Name: i2s_tx_10xe_dut_agent.sv
   > Description: This file contains the Agent class to build  monitor.
   > Author: Muhammad Junaid Ramzan
   > Modified: Muhammad Junaid Ramzan
   > Mail: muhammad.junaid@10xengineers.ai
   ---------------------------------------------------------------
   Copyright   (c)2024 10xEngineers
   ---------------------------------------------------------------
************************************************************************/
`ifndef I2S_TX_10XE_DUT_AGENT
`define I2S_TX_10XE_DUT_AGENT
//Class:: i2s_tx_10xe_dut_agent
// Description:: This class is used to build the monitor for i2s_tx_10xe_dut.
class i2s_tx_10xe_dut_agent extends uvm_agent;
    `uvm_component_utils(i2s_tx_10xe_dut_agent)
    // Handles for monitor, driver, and sequencer
    i2s_tx_10xe_dut_monitor       dut_mon;   // Monitor for observing DUT signals

    // Constructor: Initializes the agent
    function new(string name = "i2s_tx_10xe_dut_agent", uvm_component parent);
        super.new(name, parent);
        `uvm_info(get_name(), "Agent created", UVM_DEBUG)
    endfunction: new

    // Build Phase
    // Creates monitor.
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info(get_name(), "Building sequencer, driver, and monitor", UVM_DEBUG)
        // Create monitor
        dut_mon  = i2s_tx_10xe_dut_monitor::type_id::create("dut_mon", this);
        `uvm_info(get_name(), "Monitor created", UVM_DEBUG)
    endfunction: build_phase

endclass: i2s_tx_10xe_dut_agent