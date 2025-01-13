/*************************************************************************
   > File Name: i2s_tx_base_test.sv
   > Description: This file contains base_test class.
   > Author: Muhammad Junaid Ramzan
   > Modified: Muhammad Junaid Ramzan
   > Mail: muhammad.junaid@10xengineers.ai
   ---------------------------------------------------------------
   Copyright   (c)2024 10xEngineers
   ---------------------------------------------------------------
************************************************************************/
`ifndef I2S_TX_BASE_TEST
`define I2S_TX_BASE_TEST
//  Class: i2s_tx_base_test
class i2s_tx_base_test extends uvm_test;
    `uvm_component_utils(i2s_tx_base_test);

    // environment 
    i2s_tx_env     env;
    // Handle for AXI-Stream interface
    virtual i2s_tx_axi_stream_intf     axis_vif;
    // Interface handle of axi4-Lite
    virtual i2s_tx_axi4_lite_intf      axi4_lite_vif;
    // Handle of dut interface
    virtual i2s_tx_intf                i2s_vif;
    // Handle of config class
    i2s_tx_config                     cfg;
    // Handle for RAl SEQ to read registers in reset 
    ral_rst_rd_seq                          rst_ral_seq;
    // Handle for RAl SEQ to Configure registers
    ral_cfg_seq                             cfg_ral_seq;
    // Constructor: new
    function new(string name = "i2s_tx_base_test", uvm_component parent);
        super.new(name, parent);
    endfunction: new
    // Build_phase
    function void build_phase(uvm_phase phase);
        uvm_factory factory = uvm_factory::get();
        super.build_phase(phase);
        env             = i2s_tx_env::type_id::create("env", this);
        cfg             = i2s_tx_config::type_id::create("cfg", this);
        rst_ral_seq     = ral_rst_rd_seq::type_id::create("rst_ral_seq", this);
        cfg_ral_seq     = ral_cfg_seq::type_id::create("cfg_ral_seq", this);
        if(!uvm_config_db#(virtual i2s_tx_axi4_lite_intf)::get(this, "*", "axi4_lite_vif", axi4_lite_vif)) begin
            `uvm_fatal(get_name(), "Failed to get AXI4-Lite Interface from Config DB")
        end
        if(!uvm_config_db#(virtual i2s_tx_axi_stream_intf)::get(this, "*", "axis_vif", axis_vif)) begin
            `uvm_fatal(get_name(), "Failed to get AXI-Stream Interface from Config DB")
        end
        if(!uvm_config_db#(virtual i2s_tx_intf)::get(this, "*", "i2s_vif", i2s_vif)) begin
            `uvm_fatal(get_name(), "Failed to get DUT Interface from Config DB")
        end

        cfg_ral_seq.core_cfg                = cfg.CORE_CFG;
        cfg_ral_seq.axi_stream_data_valid   = cfg.AXI_STREAM_DATA_VALID;
        cfg_ral_seq.en_dis_int              = cfg.EN_DIS_INT;
        rst_ral_seq.rd_regs_in_rst          = cfg.RD_REGS_IN_RST;
       // env.set_report_verbosity_level(500);
    endfunction: build_phase

    // To print topology
    function void end_of_elaboration_phase(uvm_phase phase);
        uvm_top.print_topology();
    endfunction: end_of_elaboration_phase

    // Reset Phase to reset signals before driving 
    task reset_phase(uvm_phase phase);
        phase.raise_objection(this);
        `uvm_info(get_name(), "<reset_phase> started, objection raised.", UVM_NONE)
        //  Run reset sequnces in fork join to reset signals of both axi and axi-stream
        fork
            axis_vif.reset();
            axi4_lite_vif.reset();
        join
        rst_ral_seq.reg_blk = env.reg_block;
        rst_ral_seq.start(env.axi_agt.axi_sqnr);
        phase.drop_objection(this);
        `uvm_info(get_name(), "<reset_phase> finished, objection dropped.", UVM_NONE)
    endtask: reset_phase
    // Configure Phase to configure core 
    task configure_phase(uvm_phase phase);
        phase.raise_objection(this);
        `uvm_info(get_name(), "<configure_phase> started, objection raised.", UVM_NONE)
        cfg_ral_seq.reg_blk = env.reg_block;
        cfg_ral_seq.start(env.axi_agt.axi_sqnr);
        phase.drop_objection(this);
        `uvm_info(get_name(), "<configure_phase> finished, objection dropped.", UVM_NONE)
        phase.phase_done.set_drain_time(this, 100);
    endtask: configure_phase

    //Report Phase to display result of simulation
    virtual function void report_phase(uvm_phase phase);
		
		uvm_report_server svr;

		super.report_phase(phase);

		svr = uvm_report_server::get_server();

		if(svr.get_severity_count(UVM_FATAL) + svr.get_severity_count(UVM_ERROR) > 0) begin

			`uvm_info(get_type_name(), "--------------------------------------", UVM_NONE)
			`uvm_info(get_type_name(), "-------------- TEST FAIL -------------", UVM_NONE)
			`uvm_info(get_type_name(), "--------------------------------------", UVM_NONE)

		end
		else begin

			`uvm_info(get_type_name(), "--------------------------------------", UVM_NONE)
			`uvm_info(get_type_name(), "-------------- TEST PASS -------------", UVM_NONE)
			`uvm_info(get_type_name(), "--------------------------------------", UVM_NONE)

		end

	endfunction: report_phase
endclass: i2s_tx_base_test

//  Class: read_reg_test
class read_reg_test extends i2s_tx_base_test;
    `uvm_component_utils(read_reg_test);
    ral_rd_seq read_seq;

    // Constructor: new
    function new(string name = "read_reg_test", uvm_component parent);
        super.new(name, parent);
    endfunction: new
    // BUILD PHASE
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        read_seq     = ral_rd_seq::type_id::create("read_seq", this);
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
            `uvm_info(get_name(), "<run_phase> started, Sequence started on Sequencer.", UVM_NONE)
        join
        phase.drop_objection(this);
        `uvm_info(get_name(), "<run_phase> finished, objection dropped.", UVM_NONE)
        phase.phase_done.set_drain_time(this, 100);
    endtask: main_phase

endclass: read_reg_test

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

   //Handle of ral sequence to read and write registers
    ral_rd_wr_seq   rd_wr_seq;
    
    //  Constructor: new
    function new(string name = "ral_test", uvm_component parent);
        super.new(name, parent);
    endfunction: new
    //BUILD PHASE
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        rd_wr_seq    = ral_rd_wr_seq::type_id::create("rd_wr_seq", this);
        rd_wr_seq.wr_rd_regs    = cfg.WR_RD_REGS;
        rd_wr_seq.rd_regs       = cfg.RD_REGS;
        rd_wr_seq.data_pattern  = cfg.RAL_DATA_PATTERN;
    endfunction: build_phase
    //Run Phase
    task main_phase(uvm_phase phase);
        phase.raise_objection(this);
        `uvm_info(get_name(), "<run_phase> started, objection raised.", UVM_NONE)
        rd_wr_seq.reg_blk = env.reg_block;
        rd_wr_seq.start(env.axi_agt.axi_sqnr);
        phase.drop_objection(this);
        `uvm_info(get_name(), "<run_phase> finished, objection dropped.", UVM_NONE)
        phase.phase_done.set_drain_time(this, 100);

    endtask: main_phase

endclass: ral_test


`endif