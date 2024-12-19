/*************************************************************************
   > File Name: i2s_tx_10xe_env.sv
   > Description: This file contains environment class.
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
//
class i2s_tx_10xe_env extends uvm_env;
    `uvm_component_utils(i2s_tx_10xe_env);

    //Handle for axi4-lite agent
    i2s_tx_10xe_axi4_lite_agent         axi_agt;

    //  Constructor: new
    function new(string name = "i2s_tx_10xe_env", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    //Build Phase
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        axi_agt = i2s_tx_10xe_axi4_lite_agent::type_id::create("axi_agt", this);
    endfunction: build_phase
    

endclass: i2s_tx_10xe_env


`endif