/*************************************************************************
   > File Name: i2s_tx_10xe_base_test.sv
   > Description: This file contains base_test class.
   > Author: Muhammad Junaid Ramzan
   > Modified: Muhammad Junaid Ramzan
   > Mail: muhammad.junaid@10xengineers.ai
   ---------------------------------------------------------------
   Copyright   (c)2024 10xEngineers
   ---------------------------------------------------------------
************************************************************************/
`ifndef I2S_TX_10XE_BASE_TEST
`define I2S_TX_10XE_BASE_TEST
//  Class: i2s_tx_10xe_base_test
//
class i2s_tx_10xe_base_test extends uvm_test;
    `uvm_component_utils(i2s_tx_10xe_base_test);

    //environment 
    i2s_tx_10xe_env env;

    //Sequence to read register only
    read_reg_seq agt_seq;
    //  Constructor: new
    function new(string name = "i2s_tx_10xe_base_test", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        env = i2s_tx_10xe_env::type_id::create("env", this);
        agt_seq = read_reg_seq::type_id::create("agt_seq", this);
    endfunction: build_phase

    //To print topology

    function void end_of_elaboration_phase(uvm_phase phase);
        uvm_top.print_topology();
    endfunction: end_of_elaboration_phase
    


    


    
endclass: i2s_tx_10xe_base_test

//  Class: read_reg_test
//
class read_reg_test extends i2s_tx_10xe_base_test;
    `uvm_component_utils(read_reg_test);

    //  Constructor: new
    function new(string name = "read_reg_test", uvm_component parent);
        super.new(name, parent);
    endfunction: new
    
    //Run Phase
    task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        `uvm_info(get_name(), "<run_phase> started, objection raised.", UVM_NONE)
        agt_seq.start(env.axi_agt.axi_sqnr);
        phase.drop_objection(this);
        `uvm_info(get_name(), "<run_phase> finished, objection dropped.", UVM_NONE)
    endtask: run_phase

endclass: read_reg_test

`endif