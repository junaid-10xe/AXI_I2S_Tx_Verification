/*************************************************************************
   > File Name: i2s_tx_10xe_env.sv
   > Description: This file defines the environment class for the I2S transmitter testbench.
   >              It instantiates and manages the necessary agents for interfacing with
   >              the AXI4-Lite and AXI-Stream interfaces. The environment sets up the
   >              overall testbench structure by creating the appropriate agents and
   >              ensures proper communication with the DUT through these interfaces.
   > Author: Muhammad Junaid Ramzan
   > Modified: Muhammad Junaid Ramzan
   > Mail: muhammad.junaid@10xengineers.ai
   ---------------------------------------------------------------
   Copyright   (c)2024 10xEngineers
   ---------------------------------------------------------------
************************************************************************/
`ifndef I2S_TX_10XE_ENV
`define I2S_TX_10XE_ENV

//  Class: i2s_tx_10xe_env


class i2s_tx_10xe_env extends uvm_env;
    `uvm_component_utils(i2s_tx_10xe_env);

    // Handles for the agents
    i2s_tx_10xe_axi4_lite_agent         axi_agt;  // AXI4-Lite agent handle
    i2s_tx_10xe_axis_agent              axis_agt; // AXI-Stream agent handle

    //  Constructor: new
    //  Initializes the environment component by calling the parent constructor
    function new(string name = "i2s_tx_10xe_env", uvm_component parent);
        super.new(name, parent);
        `uvm_info(get_name(), "I2S TX Environment Constructor Called", UVM_DEBUG);
    endfunction: new

    // Build Phase
    // Creates the instances of the AXI4-Lite and AXI-Stream agents
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        // Create AXI4-Lite agent
        axi_agt = i2s_tx_10xe_axi4_lite_agent::type_id::create("axi_agt", this);
        if (axi_agt == null) begin
            `uvm_fatal(get_name(), "Failed to create AXI4-Lite agent")
        end

        // Create AXI-Stream agent
        axis_agt = i2s_tx_10xe_axis_agent::type_id::create("axis_agt", this);
        if (axis_agt == null) begin
            `uvm_fatal(get_name(), "Failed to create AXI-Stream agent")
        end

        // Log successful creation of agents
        `uvm_info(get_name(), "AXI4-Lite and AXI-Stream agents created successfully", UVM_DEBUG);
    endfunction: build_phase

endclass: i2s_tx_10xe_env

`endif