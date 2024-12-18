/*************************************************************************
   > File Name: i2s_tx_10xe_axi4_lite_agent.sv
   > Description: This file contains Agent class to to build driver, monitor and connect sequncer to driver.
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
//
class i2s_tx_10xe_axi4_lite_agent extends uvm_component;
    `uvm_component_utils(i2s_tx_10xe_axi4_lite_agent);
    //Handles for monitor , Driver and sequencer

    i2s_tx_10xe_axi4_lite_driver        axi_driv;
    i2s_tx_10xe_axi4_lite_monitor       axi_mon;
    i2s_tx_10xe_axi4_lite_sequencer     axi_sqnr;
    
    //  Constructor: new
    function new(string name = "i2s_tx_10xe_axi4_lite_agent", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    //Build Phase
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        axi_sqnr = i2s_tx_10xe_axi4_lite_sequencer::type_id::create("axi_sqnr", this);
        axi_driv = i2s_tx_10xe_axi4_lite_monitor::type_id::create("axi_driv", this);
        axi_mon  = i2s_tx_10xe_axi4_lite_monitor::type_id::create("axi_mon", this);
        
    endfunction: build_phase
    
    //Connect Phase
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        axi_driv.seq_item_port.connect(axi_sqnr.seq_item_export)  //Connect axi driver with sequencer
    endfunction: connect_phase
    
    
endclass: i2s_tx_10xe_axi4_lite_agent


`endif