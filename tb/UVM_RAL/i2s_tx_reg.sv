/*************************************************************************
   > File Name: i2s_tx_10xe_reg.sv
   > Description: This file contains all register classes of register used in I2S transmitter functionality.
   > Author: Muhammad Junaid Ramzan
   > Modified: Muhammad Junaid Ramzan
   > Mail: muhammad.junaid@10xengineers.ai
   ---------------------------------------------------------------
   Copyright   (c)2024 10xEngineers
   ---------------------------------------------------------------
************************************************************************/
`ifndef I2S_TX_10XE_REG
`define I2S_TX_10XE_REG

//Class Core_ver_reg
// Description:: This class contains the register fileds of coreversion class whose base address is 0x00
class core_ver_reg extends uvm_reg;
    `uvm_object_utils(core_ver_reg)
    //Register fields
    rand uvm_reg_field major_rev;  //This is the IP major revision value. If the IP version is 1.2, then this will return a value of 1.
    rand uvm_reg_field minor_rev;  //This is the IP minor revision value. If the IP version is 1.2, then this will return a value of 2.

    //Constructor
    function new(string name = "core_ver_reg");
        super.new(name, 32, build_coverage(UVM_NO_COVERAGE));
    endfunction: new

    //Build function 
    virtual function void build();
        major_rev = uvm_reg_field::type_id::create("major_rev");
        minor_rev = uvm_reg_field::type_id::create("minor_rev");
        //Configure fileds 
        major_rev.configure(this, 16, 16, "RO", 0, 1, 1, 0, 1);
        major_rev.configure(this, 16, 0,  "RO", 0, 1, 1, 0, 1);

    endfunction


endclass: core_ver_reg


//Class core_cfg_reg
// Description:: This class contains the register fields of core configuration reg  whose base address is 0x04
class core_cfg_reg extends uvm_reg;
    `uvm_object_utils(core_cfg_reg)
    //Register fields
    rand uvm_reg_field rsvd;        //[31:17] Reserved
    rand uvm_reg_field data_width;  //[16] I2S Data Width: Indicates the I2S data width of the core  1 = 24-bit    0 = 16-bit
    rand uvm_reg_field rsvd1:       //[15:12] Reserved
    rand uvm_reg_field n_channel;   //[11:8] Number of audio channels: Indicates the number of audio channels supported. Valid values are 2, 4, 6, and 8.
    rand uvm_reg_field rsvd2:       //[7:1] Reserved
    rand uvm_reg_field master:        //[0] I2S master: Indicates if the core has been generated as an I2S master or slave. 1 = I2S master
    //Constructor
    function new(string name = "core_cfg_reg");
        super.new(name, 32, build_coverage(UVM_NO_COVERAGE));
    endfunction: new

    //Build function 
    virtual function void build();
        //Create Fields
        rsvd = uvm_reg_field::type_id::create("rsvd");
        data_width = uvm_reg_field::type_id::create("data_width");
        rsvd1 = uvm_reg_field::type_id::create("rsvd1");
        n_channel = uvm_reg_field::type_id::create("n_channel");
        rsvd2 = uvm_reg_field::type_id::create("rsvd2");
        master = uvm_reg_field::type_id::create("master");
        //Configure fileds 
        rsvd.configure(this, 15, 17, "RO", 0, 1, 1, 0, 1);
        data_width.configure(this, 1, 16, "RO", 0, 1, 1, 0, 1);
        rsvd1.configure(this, 4, 12, "RO", 0, 0, 1, 0, 1);
        n_channel.configure(this, 4, 8, "RO", 0, 2, 1, 0, 1);
        rsvd2.configure(this, 7, 1, "RO", 0, 0, 1, 0, 1);
        master.configure(this, 1, 0, "RO", 0, 1, 1, 0, 1);

    endfunction


endclass: core_cfg_reg 

//Class control_reg
// Description:: This class contains the register fields to enable disable core functionality  whose base address is 0x08
class control_reg extends uvm_reg;
    `uvm_object_utils(control_reg)
    //Register fields
    rand uvm_reg_field rsvd;        //[31:4] Reserved
    rand uvm_reg_field lr_mode;     //[3] Selected 32-bit LRCLK mode
    rand uvm_reg_field lr_just:     //[2] Valid when bit 1 is set. Selects left/right justification 0: Left justification 1: Right justification
    rand uvm_reg_field lr_just_en;  //[1] Enable left/right justification
    rand uvm_reg_field core_en:     //[0] Enable core operations. Setting this bit to '1' will enable the core operations.
    //Constructor
    function new(string name = "control_reg");
        super.new(name, 32, build_coverage(UVM_NO_COVERAGE));
    endfunction: new

    //Build function 
    virtual function void build();
        //Create Fields
        rsvd = uvm_reg_field::type_id::create("rsvd");
        lr_mode = uvm_reg_field::type_id::create("lr_mode");
        lr_just = uvm_reg_field::type_id::create("lr_just");
        lr_just_en = uvm_reg_field::type_id::create("lr_just_en");
        core_en = uvm_reg_field::type_id::create("core_en");
        //Configure fileds 
        rsvd.configure(this, 28, 4, "RO", 0, 0, 1, 0, 1);
        lr_mode.configure(this, 1, 3, "RO", 0, 0, 1, 0, 1);
        lr_just.configure(this, 1, 2, "RW", 0, 0, 1, 0, 1);
        lr_just_en.configure(this, 1, 1, "RW", 0, 0, 1, 0, 1);
        core_en.configure(this, 1, 0, "RW", 0, 0, 1, 0, 1);

    endfunction


endclass: control_reg 

//Class: validity_reg
// Description:: This class contains the register fields to enable disable validity of data  whose base address is 0x0C
class validity_reg extends uvm_reg;
    `uvm_object_utils(validity_reg)
    //Register fields
    rand uvm_reg_field rsvd;        //[31:1] Reserved
    rand uvm_reg_field valid:      //[0] 1: The audio input sample is always valid 0: The Validity bit in the incoming stream decides the validity of the sample
    //Constructor
    function new(string name = "validity_reg");
        super.new(name, 32, build_coverage(UVM_NO_COVERAGE));
    endfunction: new

    //Build function 
    virtual function void build();
        //Create Fields
        rsvd = uvm_reg_field::type_id::create("rsvd");
        valid = uvm_reg_field::type_id::create("valid");
        //Configure fileds 
        rsvd.configure(this, 30, 1, "RO", 0, 0, 1, 0, 1);
        valid.configure(this, 1, 0, "RW", 0, 0, 1, 0, 1);
    endfunction


endclass: validity_reg 

`endif