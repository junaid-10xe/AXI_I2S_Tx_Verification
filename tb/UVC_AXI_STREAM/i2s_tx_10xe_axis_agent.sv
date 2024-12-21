/*************************************************************************
   > File Name: i2s_tx_10xe_axis_agent.sv
   > Description: This file contains the Agent class to build driver, monitor, and connect sequencer to driver.
   > Author: Muhammad Junaid Ramzan
   > Modified: Muhammad Junaid Ramzan
   > Mail: muhammad.junaid@10xengineers.ai
   ---------------------------------------------------------------
   Copyright   (c)2024 10xEngineers
   ---------------------------------------------------------------
************************************************************************/
`ifndef I2S_TX_10XE_AXIS_AGENT
`define I2S_TX_10XE_AXIS_AGENT

//  Class: i2s_tx_10xe_axis_agent
//  This class represents the agent in UVM, responsible for creating and 
//  connecting the driver, monitor, and sequencer components.
class i2s_tx_10xe_axis_agent extends uvm_component;
    `uvm_component_utils(i2s_tx_10xe_axis_agent);

    // Handles for monitor, driver, and sequencer
    i2s_tx_10xe_axis_driver        axis_driv;  // Driver for driving transactions
    i2s_tx_10xe_axis_monitor       axis_mon;   // Monitor for observing DUT signals
    i2s_tx_10xe_axis_sequencer     axis_sqnr;  // Sequencer for sequencing transactions

    // Constructor: Initializes the agent
    function new(string name = "i2s_tx_10xe_axis_agent", uvm_component parent);
        super.new(name, parent);
        `uvm_info(get_name(), "Agent created", UVM_DEBUG)
    endfunction: new

    // Build Phase
    // Creates and instantiates the sequencer, driver, and monitor components.
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        `uvm_info(get_name(), "Building sequencer, driver, and monitor", UVM_DEBUG)

        // Create sequencer
        axis_sqnr = i2s_tx_10xe_axis_sequencer::type_id::create("axis_sqnr", this);
        `uvm_info(get_name(), "Sequencer created", UVM_DEBUG)

        // Create driver
        axis_driv = i2s_tx_10xe_axis_driver::type_id::create("axis_driv", this);
        `uvm_info(get_name(), "Driver created", UVM_DEBUG)

        // Create monitor
        axis_mon  = i2s_tx_10xe_axis_monitor::type_id::create("axis_mon", this);
        `uvm_info(get_name(), "Monitor created", UVM_DEBUG)
    endfunction: build_phase

    // Connect Phase
    // Connects the sequencer's port to the driver's export to enable communication.
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);

        `uvm_info(get_name(), "Connecting sequencer to driver", UVM_DEBUG)

        // Connect sequencer and driver
        axis_driv.seq_item_port.connect(axis_sqnr.seq_item_export);

        `uvm_info(get_name(), "Sequencer successfully connected to driver", UVM_DEBUG)
    endfunction: connect_phase

endclass: i2s_tx_10xe_axis_agent

`endif