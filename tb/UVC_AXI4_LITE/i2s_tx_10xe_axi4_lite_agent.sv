/*************************************************************************
   > File Name: i2s_tx_10xe_axi4_lite_agent.sv
   > Description: This file contains Agent class to build driver, monitor, and connect sequencer to driver.
   > Author: Muhammad Junaid Ramzan
   > Modified: Muhammad Junaid Ramzan
   > Mail: muhammad.junaid@10xengineers.ai
   ---------------------------------------------------------------
   Copyright   (c)2024 10xEngineers
   ---------------------------------------------------------------
************************************************************************/
`ifndef I2S_TX_10XE_AXI4_LITE_AGENT
`define I2S_TX_10XE_AXI4_LITE_AGENT

//  Class: i2s_tx_10xe_axi4_lite_agent
//  This class represents the agent that contains and connects the driver, monitor, and sequencer for the I2S TX AXI4-Lite interface.
class i2s_tx_10xe_axi4_lite_agent extends uvm_component;
    `uvm_component_utils(i2s_tx_10xe_axi4_lite_agent);

    // Handles for monitor, driver, and sequencer components
    i2s_tx_10xe_axi4_lite_driver        axi_driv;    // Driver to send AXI4-Lite transactions to the DUT
    i2s_tx_10xe_axi4_lite_monitor       axi_mon;     // Monitor to observe the AXI4-Lite signals
    i2s_tx_10xe_axi4_lite_sequencer     axi_sqnr;    // Sequencer to generate sequences of AXI4-Lite transactions

    // Constructor: new
    // This constructor initializes the agent with a given name and parent component.
    function new(string name = "i2s_tx_10xe_axi4_lite_agent", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    // Build Phase
    // In this phase, all components (driver, monitor, sequencer) are instantiated.
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        // Create instances of driver, monitor, and sequencer
        axi_sqnr = i2s_tx_10xe_axi4_lite_sequencer::type_id::create("axi_sqnr", this);
        axi_driv = i2s_tx_10xe_axi4_lite_driver::type_id::create("axi_driv", this);
        axi_mon  = i2s_tx_10xe_axi4_lite_monitor::type_id::create("axi_mon", this);
    endfunction: build_phase

    // Connect Phase
    // In this phase, we connect the sequencer to the driver's sequence item port.
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        
        // Connect sequencer's sequence export to driver's sequence item port
        axi_driv.seq_item_port.connect(axi_sqnr.seq_item_export);  
    endfunction: connect_phase
    
endclass: i2s_tx_10xe_axi4_lite_agent

`endif