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
    i2s_tx_10xe_env     env;
    //Handle for AXI-Stream interface
    virtual i2s_tx_10xe_axi_stream_intf     axis_vif;
     //Interface handle of axi4-Lite
    virtual i2s_tx_10xe_axi4_lite_intf      axi4_lite_vif;
    //Handle of sut interface
    virtual i2s_tx_10xe_dut_intf            dut_vif;

    //handle for reg configuration seq
    config_reg_seq                              config_seq;

    //  Constructor: new
    function new(string name = "i2s_tx_10xe_base_test", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        env     = i2s_tx_10xe_env::type_id::create("env", this);
        config_seq = config_reg_seq::type_id::create("config_seq", this);
        if(!uvm_config_db#(virtual i2s_tx_10xe_axi4_lite_intf)::get(this, "*", "axi4_lite_vif", axi4_lite_vif)) begin
            `uvm_fatal(get_name(), "Failed to get AXI4-Lite Interface from Config DB")
        end
        if(!uvm_config_db#(virtual i2s_tx_10xe_axi_stream_intf)::get(this, "*", "axis_vif", axis_vif)) begin
            `uvm_fatal(get_name(), "Failed to get AXI-Stream Interface from Config DB")
        end
        if(!uvm_config_db#(virtual i2s_tx_10xe_dut_intf)::get(this, "*", "dut_vif", dut_vif)) begin
            `uvm_fatal(get_name(), "Failed to get DUT Interface from Config DB")
        end
       // env.set_report_verbosity_level(500);
    endfunction: build_phase

    //To print topology

    function void end_of_elaboration_phase(uvm_phase phase);
        uvm_top.print_topology();
    endfunction: end_of_elaboration_phase

    //Reset Phase to reset signals before driving 
    task reset_phase(uvm_phase phase);
        phase.raise_objection(this);
        `uvm_info(get_name(), "<reset_phase> started, objection raised.", UVM_NONE)
         //Run reset sequnces in fork join to reset signals of both axi and axi-stream
        fork
            axis_vif.reset();
            axi4_lite_vif.reset();
        join

        phase.drop_objection(this);
        `uvm_info(get_name(), "<reset_phase> finished, objection dropped.", UVM_NONE)
    endtask: reset_phase

    task configure_phase(uvm_phase phase);
        phase.raise_objection(this);
        `uvm_info(get_name(), "<configure_phase> started, objection raised.", UVM_NONE)
        config_seq.start(env.axi_agt.axi_sqnr);
        phase.drop_objection(this);
        `uvm_info(get_name(), "<configure_phase> finished, objection dropped.", UVM_NONE)
        phase.phase_done.set_drain_time(this, 100);
    endtask: configure_phase

    
endclass: i2s_tx_10xe_base_test

//  Class: read_reg_test
//
class read_reg_test extends i2s_tx_10xe_base_test;
    `uvm_component_utils(read_reg_test);
    read_reg_seq read_seq;

    //  Constructor: new
    function new(string name = "read_reg_test", uvm_component parent);
        super.new(name, parent);
    endfunction: new
    //BUILD PHASE
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        read_seq     = read_reg_seq::type_id::create("read_seq", this);
    endfunction: build_phase
    //Run Phase
    task main_phase(uvm_phase phase);
        phase.raise_objection(this);
        `uvm_info(get_name(), "<run_phase> started, objection raised.", UVM_NONE)
        fork
             read_seq.start(env.axi_agt.axi_sqnr);
             `uvm_info(get_name(), "<run_phase> started, Sequence started on Sequencer.", UVM_NONE)

        join
        phase.drop_objection(this);
        `uvm_info(get_name(), "<run_phase> finished, objection dropped.", UVM_NONE)
        phase.phase_done.set_drain_time(this, 100);
    endtask: main_phase

endclass: read_reg_test

//  Class: sanity_test
//
class sanity_test extends i2s_tx_10xe_base_test;
    `uvm_component_utils(sanity_test);
    read_reg_seq read_seq;
    axis_i2s_seq axis_seq;
    //  Constructor: new
    function new(string name = "sanity_test", uvm_component parent);
        super.new(name, parent);
    endfunction: new
    //BUILD PHASE
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        read_seq     = read_reg_seq::type_id::create("read_seq", this);
        axis_seq     = axis_i2s_seq::type_id::create("axis_seq", this);
        
    endfunction: build_phase
    //Run Phase
    task main_phase(uvm_phase phase);
        phase.raise_objection(this);
        `uvm_info(get_name(), "<run_phase> started, objection raised.", UVM_NONE)
        fork
             read_seq.start(env.axi_agt.axi_sqnr);
             axis_seq.start(env.axis_agt.axis_sqnr);
        join
        phase.drop_objection(this);
        `uvm_info(get_name(), "<run_phase> finished, objection dropped.", UVM_NONE)
    endtask: main_phase

endclass: sanity_test


`endif