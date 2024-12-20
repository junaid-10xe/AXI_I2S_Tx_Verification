/*************************************************************************
   > File Name: i2s_tx_10xe_axis_agent.sv
   > Description: This file contains Agent class to to build driver, monitor and connect sequncer to driver.
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
//
class i2s_tx_10xe_axis_agent extends uvm_component;
    `uvm_component_utils(i2s_tx_10xe_axis_agent);
    //Handles for monitor , Driver and sequencer

    i2s_tx_10xe_axis_driver        axis_driv;
    i2s_tx_10xe_axis_monitor       axis_mon;
    i2s_tx_10xe_axis_sequencer     axis_sqnr;
    
    //  Constructor: new
    function new(string name = "i2s_tx_10xe_axis_agent", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    //Build Phase
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        axis_sqnr = i2s_tx_10xe_axis_sequencer::type_id::create("axis_sqnr", this);
        axis_driv = i2s_tx_10xe_axis_driver::type_id::create("axis_driv", this);
        axis_mon  = i2s_tx_10xe_axis_monitor::type_id::create("axis_mon", this);
        
    endfunction: build_phase
    
    //Connect Phase
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        axis_driv.seq_item_port.connect(axis_sqnr.seq_item_export);  //Connect axis driver with sequencer
    endfunction: connect_phase
    
    
endclass: i2s_tx_10xe_axis_agent


`endif