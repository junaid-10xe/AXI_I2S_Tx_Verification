/*************************************************************************
   > File Name: i2s_tx_tests_lib.sv
   > Description: This file contains Test cases all extended from base test class.
   > Author: Muhammad Junaid Ramzan
   > Modified: Muhammad Junaid Ramzan
   > Mail: muhammad.junaid@10xengineers.ai
   ---------------------------------------------------------------
   Copyright   (c)2024 10xEngineers
   ---------------------------------------------------------------
************************************************************************/
`ifndef I2S_TX_TESTS_LIB
`define I2S_TX_TESTS_LIB


//  Class: sanity_test
class sanity_test extends i2s_tx_base_test;
    `uvm_component_utils(sanity_test);
    ral_rd_seq      read_seq;
    axis_i2s_seq    axis_seq;
    // Constructor: new
    function new(string name = "sanity_test", uvm_component parent);
        super.new(name, parent);
    endfunction: new
    // BUILD PHASE
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        read_seq         = ral_rd_seq::type_id::create("read_seq", this);
        axis_seq         = axis_i2s_seq::type_id::create("axis_seq", this);
        read_seq.rd_regs = cfg.RD_REGS;
    endfunction: build_phase
    // MAIN Phase
    task main_phase(uvm_phase phase);
        phase.raise_objection(this);
        `uvm_info(get_name(), "<run_phase> started, objection raised.", UVM_NONE)
        fork
            begin
                read_seq.reg_blk = env.reg_block;
                read_seq.start(env.axi_agt.axi_sqnr);                   
            end
             axis_seq.start(env.axis_agt.axis_sqnr);
        join
        phase.drop_objection(this);
        `uvm_info(get_name(), "<run_phase> finished, objection dropped.", UVM_NONE)
    endtask: main_phase

endclass: sanity_test

//  Class: ral_test
//
class ral_test extends i2s_tx_base_test;
    `uvm_component_utils(ral_test);
    // HAndle of RAL test seq
    ral_test_seq            ral_seq;
    //  Constructor: new
    function new(string name = "ral_test", uvm_component parent);
        super.new(name, parent);
    endfunction: new
    //BUILD PHASE
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        ral_seq      = ral_test_seq::type_id::create("ral_seq", this);
        ral_seq.cfg             = cfg;
    endfunction: build_phase
    //Run Phase
    task main_phase(uvm_phase phase);
        phase.raise_objection(this);
        if(cfg.RD_REGS_DFT) begin
            axi4_lite_vif.generate_reset();
            cfg.RD_REGS = 1;
        end
        `uvm_info(get_name(), "<run_phase> started, objection raised.", UVM_NONE)   
        ral_seq.reg_blk = env.reg_block;
        ral_seq.start(env.axis_agt.axis_sqnr);
        phase.drop_objection(this);
        `uvm_info(get_name(), "<run_phase> finished, objection dropped.", UVM_NONE)
        phase.phase_done.set_drain_time(this, 100);

    endtask: main_phase

endclass: ral_test

`endif