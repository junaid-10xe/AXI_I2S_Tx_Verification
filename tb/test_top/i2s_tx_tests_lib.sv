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
        cfg.RD_REGS      = 1;
        read_seq.cfg     = cfg;
        axis_seq.cfg     = cfg;
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
        cfg.CORE_VER_TEST   = 1;
        cfg.CORE_CFG_TEST   = 1;
        cfg.RD_REGS_DFT     = 1;
        cfg.REG_RO_FIELDS   = 1;
        cfg.REG_RW_FIELDS   = 1;
        ral_seq.cfg  = cfg;
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

// Class axis_tvalid_test 
// Description:: To test the handshake of axi-stream by giving the DUT tvalid low and high
class axis_tvalid_test extends i2s_tx_base_test;
    `uvm_component_utils(axis_tvalid_test);
    // Handle of axis tvalid test seq
    axis_tvalid_test_seq    axis_seq;
    // Constructor: new
    function new(string name = "axis_tvalid_test", uvm_component parent);
        super.new(name, parent);
    endfunction: new
    // BUILD PHASE
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        axis_seq         = axis_tvalid_test_seq::type_id::create("axis_seq", this);
        axis_seq.cfg     = cfg;
    endfunction: build_phase
    // MAIN Phase
    task main_phase(uvm_phase phase);
        phase.raise_objection(this);
        `uvm_info(get_name(), "<run_phase> started, objection raised.", UVM_NONE)

        axis_seq.start(env.axis_agt.axis_sqnr);

        phase.drop_objection(this);
        `uvm_info(get_name(), "<run_phase> finished, objection dropped.", UVM_NONE)
    endtask: main_phase

endclass: axis_tvalid_test

// Class axis_valid_bit_low_test 
// Description:: To test the validity of audio data by giving tdata[28] 0 to DUT 
class axis_valid_bit_low_test extends i2s_tx_base_test;
    `uvm_component_utils(axis_valid_bit_low_test);
    // Handle of axis tvalid test seq
    axis_valid_bit_low_seq    axis_seq;
    // Constructor: new
    function new(string name = "axis_valid_bit_low_test", uvm_component parent);
        super.new(name, parent);
    endfunction: new
    // BUILD PHASE
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        axis_seq         = axis_valid_bit_low_seq::type_id::create("axis_seq", this);
        axis_seq.cfg     = cfg;
    endfunction: build_phase
    // MAIN Phase
    task main_phase(uvm_phase phase);
        phase.raise_objection(this);
        `uvm_info(get_name(), "<run_phase> started, objection raised.", UVM_NONE)

        axis_seq.start(env.axis_agt.axis_sqnr);

        phase.drop_objection(this);
        `uvm_info(get_name(), "<run_phase> finished, objection dropped.", UVM_NONE)
    endtask: main_phase

endclass: axis_valid_bit_low_test

// Class axis_valid_bit_hi_test 
// Description:: To test the validity of audio data by giving tdata[28] 0 to DUT 
class axis_valid_bit_hi_test extends i2s_tx_base_test;
    `uvm_component_utils(axis_valid_bit_hi_test);
    // Handle of axis tvalid test seq
    axis_valid_bit_hi_seq    axis_seq;
    // Constructor: new
    function new(string name = "axis_valid_bit_hi_test", uvm_component parent);
        super.new(name, parent);
    endfunction: new
    // BUILD PHASE
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        axis_seq         = axis_valid_bit_hi_seq::type_id::create("axis_seq", this);
        axis_seq.cfg     = cfg;
    endfunction: build_phase
    // MAIN Phase
    task main_phase(uvm_phase phase);
        phase.raise_objection(this);
        `uvm_info(get_name(), "<run_phase> started, objection raised.", UVM_NONE)

        axis_seq.start(env.axis_agt.axis_sqnr);

        phase.drop_objection(this);
        `uvm_info(get_name(), "<run_phase> finished, objection dropped.", UVM_NONE)
    endtask: main_phase

endclass: axis_valid_bit_hi_test

// Class vaidity reg test  
// Description:: To test the validity of audio data by writing 1 to validity register 0x0c to make stream data valid 
class validity_reg_test extends i2s_tx_base_test;
    `uvm_component_utils(validity_reg_test);
    // Handle of axis tvalid test seq
    axis_valid_bit_hi_seq    axis_seq;
    // Hand le of coreconfigure sequence to reconfigure core by writing 1 to 0x0c
    ral_cfg_seq                             cfg_ral_seq;
    // Constructor: new
    function new(string name = "validity_reg_test", uvm_component parent);
        super.new(name, parent);
    endfunction: new
    // BUILD PHASE
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        axis_seq         = axis_valid_bit_hi_seq::type_id::create("axis_seq", this);
        cfg_ral_seq      = ral_cfg_seq::type_id::create("cfg_ral_seq", this);
        cfg.CORE_CFG              = 1;
        cfg.AXI_STREAM_DATA_VALID = 1;
        cfg_ral_seq.cfg  = cfg;
        axis_seq.cfg     = cfg;
    endfunction: build_phase
    // MAIN Phase
    task main_phase(uvm_phase phase);
        phase.raise_objection(this);
        `uvm_info(get_name(), "<run_phase> started, objection raised.", UVM_NONE)
        cfg_ral_seq.reg_blk = env.reg_block;
        cfg_ral_seq.start(env.axi_agt.axi_sqnr);
        axis_seq.start(env.axis_agt.axis_sqnr);
        phase.drop_objection(this);
        `uvm_info(get_name(), "<run_phase> finished, objection dropped.", UVM_NONE)
    endtask: main_phase

endclass: validity_reg_test

//  Class: left_just_test
class left_just_test extends i2s_tx_base_test;
    `uvm_component_utils(left_just_test);
    // Handle of core configuration sequence 
    ral_cfg_seq                             cfg_ral_seq;
    // Handle of Stream Sequence
    axis_i2s_seq                            axis_seq;
    // Constructor: new
    function new(string name = "left_just_test", uvm_component parent);
        super.new(name, parent);
    endfunction: new
    // BUILD PHASE
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        cfg_ral_seq      = ral_cfg_seq::type_id::create("cfg_ral_seq", this);
        axis_seq         = axis_i2s_seq::type_id::create("axis_seq", this);
        // Enable core configuration and left justification
        cfg.CORE_CFG         = 1;
        cfg.LEFT_JUSTICATION = 1;
        cfg_ral_seq.cfg  = cfg;
        axis_seq.cfg     = cfg;
    endfunction: build_phase
    // MAIN Phase
    task main_phase(uvm_phase phase);
        phase.raise_objection(this);
        `uvm_info(get_name(), "<run_phase> started, objection raised.", UVM_NONE)
        // Reconfigure core again by enabling left right justification
        cfg_ral_seq.reg_blk = env.reg_block;
        cfg_ral_seq.start(env.axi_agt.axi_sqnr);                   
        // Start axi-stream sequnce after left right justification is enabled
        axis_seq.start(env.axis_agt.axis_sqnr);
        phase.drop_objection(this);
        `uvm_info(get_name(), "<run_phase> finished, objection dropped.", UVM_NONE)
    endtask: main_phase

endclass: left_just_test

//  Class: right_just_test
class right_just_test extends i2s_tx_base_test;
    `uvm_component_utils(right_just_test);
    // Handle of core configuration sequence 
    ral_cfg_seq                             cfg_ral_seq;
    // Handle of Stream Sequence
    axis_i2s_seq                            axis_seq;
    // Constructor: new
    function new(string name = "right_just_test", uvm_component parent);
        super.new(name, parent);
    endfunction: new
    // BUILD PHASE
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        cfg_ral_seq      = ral_cfg_seq::type_id::create("cfg_ral_seq", this);
        axis_seq         = axis_i2s_seq::type_id::create("axis_seq", this);
        // Enable core configuration and left justification
        cfg.CORE_CFG            = 1;
        cfg.RIGHT_JUSTICATION   = 1;
        cfg_ral_seq.cfg  = cfg;
        axis_seq.cfg     = cfg;
    endfunction: build_phase
    // MAIN Phase
    task main_phase(uvm_phase phase);
        phase.raise_objection(this);
        `uvm_info(get_name(), "<run_phase> started, objection raised.", UVM_NONE)
        // Reconfigure core again by enabling left right justification
        cfg_ral_seq.reg_blk = env.reg_block;
        cfg_ral_seq.start(env.axi_agt.axi_sqnr);                   
        // Start axi-stream sequnce after left right justification is enabled
        axis_seq.start(env.axis_agt.axis_sqnr);
        phase.drop_objection(this);
        `uvm_info(get_name(), "<run_phase> finished, objection dropped.", UVM_NONE)
    endtask: main_phase

endclass: right_just_test


//  Class: intrpt_ctrl_test
class intrpt_ctrl_test extends i2s_tx_base_test;
    `uvm_component_utils(intrpt_ctrl_test);
    // Handle of core configuration sequence 
    ral_cfg_seq                             cfg_ral_seq;
    // Handle of Stream Sequence
    axis_i2s_seq                            axis_seq;
    // Handle of intrpt status which read the value of register
    intrpt_ctrl_test_seq                    intrpt_ctrl_seq;
    // Constructor: new
    function new(string name = "intrpt_ctrl_test", uvm_component parent);
        super.new(name, parent);
    endfunction: new
    // BUILD PHASE
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        cfg_ral_seq      = ral_cfg_seq::type_id::create("cfg_ral_seq", this);
        intrpt_ctrl_seq  = intrpt_ctrl_test_seq::type_id::create("intrpt_ctrl_seq", this);
        axis_seq         = axis_i2s_seq::type_id::create("axis_seq", this);
        // Enable core configuration and interrupts
        cfg.CORE_CFG     = 1;
        cfg.EN_DIS_INT   = 1;
        cfg_ral_seq.cfg  = cfg;
        axis_seq.cfg     = cfg;
    endfunction: build_phase
    // MAIN Phase
    task main_phase(uvm_phase phase);
        phase.raise_objection(this);
        `uvm_info(get_name(), "<run_phase> started, objection raised.", UVM_NONE)
        // Reconfigure core again by enabling interrupts
        cfg_ral_seq.reg_blk = env.reg_block;
        cfg_ral_seq.start(env.axi_agt.axi_sqnr);
        intrpt_ctrl_seq.reg_blk = env.reg_block;
        fork
            intrpt_ctrl_seq.start(env.axi_agt.axi_sqnr);        
            axis_seq.start(env.axis_agt.axis_sqnr);
        join_any
        phase.drop_objection(this);
        `uvm_info(get_name(), "<run_phase> finished, objection dropped.", UVM_NONE)
    endtask: main_phase

endclass: intrpt_ctrl_test

//  Class: intrpt_stat_test
class intrpt_stat_test extends i2s_tx_base_test;
    `uvm_component_utils(intrpt_stat_test);
    // Handle of core configuration sequence 
    ral_cfg_seq                             cfg_ral_seq;
    // Handle of Stream Sequence
    axis_i2s_seq                            axis_seq;
    // Handle of intrpt status which read the value of register
    intrpt_stat_test_seq                    intrpt_stat_seq;
    // Constructor: new
    function new(string name = "intrpt_stat_test", uvm_component parent);
        super.new(name, parent);
    endfunction: new
    // BUILD PHASE
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        cfg_ral_seq      = ral_cfg_seq::type_id::create("cfg_ral_seq", this);
        intrpt_stat_seq  = intrpt_stat_test_seq::type_id::create("intrpt_stat_seq", this);
        axis_seq         = axis_i2s_seq::type_id::create("axis_seq", this);
        // Enable core configuration and interrupts
        cfg.CORE_CFG     = 1;
        cfg.EN_DIS_INT   = 1;
        cfg_ral_seq.cfg  = cfg;
        axis_seq.cfg     = cfg;
    endfunction: build_phase
    // MAIN Phase
    task main_phase(uvm_phase phase);
        phase.raise_objection(this);
        `uvm_info(get_name(), "<run_phase> started, objection raised.", UVM_NONE)
        // Reconfigure core again by enabling interrupts
        cfg_ral_seq.reg_blk = env.reg_block;
        cfg_ral_seq.start(env.axi_agt.axi_sqnr);
        cfg.INTRPT_STAT_TEST = 1;
        intrpt_stat_seq.cfg  = cfg;
        fork
            intrpt_stat_seq.start(env.axi_agt.axi_sqnr);        
            axis_seq.start(env.axis_agt.axis_sqnr);
        join_any
        phase.drop_objection(this);
        `uvm_info(get_name(), "<run_phase> finished, objection dropped.", UVM_NONE)
    endtask: main_phase

endclass: intrpt_stat_test

`endif