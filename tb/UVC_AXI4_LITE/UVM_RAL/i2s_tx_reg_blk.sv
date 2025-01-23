/*************************************************************************
   > File Name: i2s_tx_reg_blk.sv
   > Description: This file build and configure all the registers used in I2S transmitter functionality.
   > Author: Muhammad Junaid Ramzan
   > Modified: Muhammad Junaid Ramzan
   > Mail: muhammad.junaid@10xengineers.ai
   ---------------------------------------------------------------
   Copyright   (c)2024 10xEngineers
   ---------------------------------------------------------------
************************************************************************/
`ifndef I2S_TX_REG_BLK
`define I2S_TX_REG_BLK

// Class: i2s_tx_reg_blk
// Description: This class is used to build and configure all the registers used in I2S transmitter functionality.

class i2s_tx_reg_blk extends uvm_reg_block;
    // register with factory
    `uvm_object_utils(i2s_tx_reg_blk)

    // handle of all registers
    core_version_reg        core_version_reg_h;
    core_cfg_reg            core_cfg_reg_h;
    control_reg             control_reg_h;
    validity_reg            validity_reg_h;
    intrpt_ctrl_reg         intrpt_ctrl_reg_h;
    intrpt_stat_reg         intrpt_stat_reg_h;
    i2s_tim_ctrl_reg        i2s_tim_ctrl_reg_h;
    chan_01_ctrl_reg        chan_01_ctrl_reg_h;
    chan_23_ctrl_reg        chan_23_ctrl_reg_h;
    chan_45_ctrl_reg        chan_45_ctrl_reg_h;
    chan_67_ctrl_reg        chan_67_ctrl_reg_h;
    aes_chan_stat_reg0      aes_chan_stat_reg0_h;
    aes_chan_stat_reg1      aes_chan_stat_reg1_h;
    aes_chan_stat_reg2      aes_chan_stat_reg2_h;
    aes_chan_stat_reg3      aes_chan_stat_reg3_h;
    aes_chan_stat_reg4      aes_chan_stat_reg4_h;
    aes_chan_stat_reg5      aes_chan_stat_reg5_h;

    // Constructor
    function new(string name = "i2s_tx_reg_blk");
        super.new(name, build_coverage(UVM_NO_COVERAGE));
    endfunction: new

    // build function
    virtual function void build();
        default_map = create_map("default_map", 0, 4, UVM_LITTLE_ENDIAN, 0);
        `uvm_info(get_name(), "Creating registers", UVM_DEBUG)
        
        // Create build and configure registers
        core_version_reg_h      = core_version_reg::type_id::create("core_version_reg_h");
        core_cfg_reg_h          = core_cfg_reg::type_id::create("core_cfg_reg_h");
        control_reg_h           = control_reg::type_id::create("control_reg_h");
        validity_reg_h          = validity_reg::type_id::create("validity_reg_h");
        intrpt_ctrl_reg_h       = intrpt_ctrl_reg::type_id::create("intrpt_ctrl_reg_h");
        intrpt_stat_reg_h       = intrpt_stat_reg::type_id::create("intrpt_stat_reg_h");
        i2s_tim_ctrl_reg_h      = i2s_tim_ctrl_reg::type_id::create("i2s_tim_ctrl_reg_h");
        chan_01_ctrl_reg_h      = chan_01_ctrl_reg::type_id::create("chan_01_ctrl_reg_h");
        chan_23_ctrl_reg_h      = chan_23_ctrl_reg::type_id::create("chan_23_ctrl_reg_h");
        chan_45_ctrl_reg_h      = chan_45_ctrl_reg::type_id::create("chan_45_ctrl_reg_h");
        chan_67_ctrl_reg_h      = chan_67_ctrl_reg::type_id::create("chan_67_ctrl_reg_h");
        aes_chan_stat_reg0_h    = aes_chan_stat_reg0::type_id::create("aes_chan_stat_reg0_h");
        aes_chan_stat_reg1_h    = aes_chan_stat_reg1::type_id::create("aes_chan_stat_reg1_h");
        aes_chan_stat_reg2_h    = aes_chan_stat_reg2::type_id::create("aes_chan_stat_reg2_h");
        aes_chan_stat_reg3_h    = aes_chan_stat_reg3::type_id::create("aes_chan_stat_reg3_h");
        aes_chan_stat_reg4_h    = aes_chan_stat_reg4::type_id::create("aes_chan_stat_reg4_h");
        aes_chan_stat_reg5_h    = aes_chan_stat_reg5::type_id::create("aes_chan_stat_reg5_h");
        `uvm_info(get_name(), "Built now configuring registers", UVM_DEBUG)

        // Configure registers
        core_version_reg_h.configure(this, null);
        core_cfg_reg_h.configure(this, null);
        control_reg_h.configure(this, null);
        validity_reg_h.configure(this, null);
        intrpt_ctrl_reg_h.configure(this, null);
        intrpt_stat_reg_h.configure(this, null);
        i2s_tim_ctrl_reg_h.configure(this, null);
        chan_01_ctrl_reg_h.configure(this, null);
        chan_23_ctrl_reg_h.configure(this, null);
        chan_45_ctrl_reg_h.configure(this, null);
        chan_67_ctrl_reg_h.configure(this, null);
        aes_chan_stat_reg0_h.configure(this, null);
        aes_chan_stat_reg1_h.configure(this, null);
        aes_chan_stat_reg2_h.configure(this, null);
        aes_chan_stat_reg3_h.configure(this, null);
        aes_chan_stat_reg4_h.configure(this, null);
        aes_chan_stat_reg5_h.configure(this, null);
        `uvm_info(get_name(), "Created now building registers", UVM_DEBUG)

        // build registers
        core_version_reg_h.build();
        core_cfg_reg_h.build();
        control_reg_h.build();
        validity_reg_h.build();
        intrpt_ctrl_reg_h.build();
        intrpt_stat_reg_h.build();
        i2s_tim_ctrl_reg_h.build();
        chan_01_ctrl_reg_h.build();
        chan_23_ctrl_reg_h.build();
        chan_45_ctrl_reg_h.build();
        chan_67_ctrl_reg_h.build();
        aes_chan_stat_reg0_h.build();
        aes_chan_stat_reg1_h.build();
        aes_chan_stat_reg2_h.build();
        aes_chan_stat_reg3_h.build();
        aes_chan_stat_reg4_h.build();
        aes_chan_stat_reg5_h.build();


        // Add addresses of registers to map 
        this.default_map.add_reg(core_version_reg_h, 'h00, "RO");
        this.default_map.add_reg(core_cfg_reg_h, 'h04, "RO");
        this.default_map.add_reg(control_reg_h, 'h08, "RW");
        this.default_map.add_reg(validity_reg_h, 'h0C, "RW");
        this.default_map.add_reg(intrpt_ctrl_reg_h, 'h10, "RW");
        this.default_map.add_reg(intrpt_stat_reg_h, 'h14, "RW");
        this.default_map.add_reg(i2s_tim_ctrl_reg_h, 'h20, "RW");
        this.default_map.add_reg(chan_01_ctrl_reg_h, 'h30, "RW");
        this.default_map.add_reg(chan_23_ctrl_reg_h, 'h34, "RW");
        this.default_map.add_reg(chan_45_ctrl_reg_h, 'h38, "RW");
        this.default_map.add_reg(chan_67_ctrl_reg_h, 'h3C, "RW");
        this.default_map.add_reg(aes_chan_stat_reg0_h, 'h50, "RW");
        this.default_map.add_reg(aes_chan_stat_reg1_h, 'h54, "RW");
        this.default_map.add_reg(aes_chan_stat_reg2_h, 'h58, "RW");
        this.default_map.add_reg(aes_chan_stat_reg3_h, 'h5C, "RW");
        this.default_map.add_reg(aes_chan_stat_reg4_h, 'h60, "RW");
        this.default_map.add_reg(aes_chan_stat_reg5_h, 'h64, "RW");

        default_map.set_auto_predict(1);
        
        // lock the model
        lock_model(); 
    endfunction
endclass

`endif