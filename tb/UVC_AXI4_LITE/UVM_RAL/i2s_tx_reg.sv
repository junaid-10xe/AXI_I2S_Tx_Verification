/*************************************************************************
   > File Name: i2s_tx_reg.sv
   > Description: This file contains all register classes of register used in I2S transmitter functionality.
   > Author: Muhammad Junaid Ramzan
   > Modified: Muhammad Junaid Ramzan
   > Mail: muhammad.junaid@10xengineers.ai
   ---------------------------------------------------------------
   Copyright   (c)2024 10xEngineers
   ---------------------------------------------------------------
************************************************************************/
`ifndef I2S_TX_REG
`define I2S_TX_REG

// Class Core_version_reg
// Description:: This class contains the register fileds of coreversion class whose base address is 0x00
class core_version_reg extends uvm_reg;
    `uvm_object_utils(core_version_reg)
    //Register fields
    rand uvm_reg_field major_rev;  //This is the IP major revision value. If the IP version is 1.2, then this will return a value of 1.
    rand uvm_reg_field minor_rev;  //This is the IP minor revision value. If the IP version is 1.2, then this will return a value of 2.

    //Constructor
    function new(string name = "core_version_reg");
        super.new(name, 32, build_coverage(UVM_NO_COVERAGE));
    endfunction: new

    //Build function 
    virtual function void build();
        major_rev = uvm_reg_field::type_id::create("major_rev");
        minor_rev = uvm_reg_field::type_id::create("minor_rev");
        //Configure fileds 
        major_rev.configure(this, 16, 16, "RO", 0, 1, 1, 0, 1);
        minor_rev.configure(this, 16, 0,  "RO", 0, 0, 1, 0, 1);

    endfunction
endclass: core_version_reg

// Class core_cfg_reg
// Description:: This class contains the register fields of core configuration reg  whose base address is 0x04
class core_cfg_reg extends uvm_reg;
    `uvm_object_utils(core_cfg_reg)
    //Register fields
    rand uvm_reg_field rsvd;        //[31:17] Reserved
    rand uvm_reg_field data_width;  //[16] I2S Data Width: Indicates the I2S data width of the core  1 = 24-bit    0 = 16-bit
    rand uvm_reg_field rsvd1;       //[15:12] Reserved
    rand uvm_reg_field n_channel;   //[11:8] Number of audio channels: Indicates the number of audio channels supported. Valid values are 2, 4, 6, and 8.
    rand uvm_reg_field rsvd2;       //[7:1] Reserved
    rand uvm_reg_field master;        //[0] I2S master: Indicates if the core has been generated as an I2S master or slave. 1 = I2S master
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
    rand uvm_reg_field lr_just;     //[2] Valid when bit 1 is set. Selects left/right justification 0: Left justification 1: Right justification
    rand uvm_reg_field lr_just_en;  //[1] Enable left/right justification
    rand uvm_reg_field core_en;     //[0] Enable core operations. Setting this bit to '1' will enable the core operations.
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
    rand uvm_reg_field valid;       //[0] 1: The audio input sample is always valid 0: The Validity bit in the incoming stream decides the validity of the sample
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

//Class: intrpt_ctrl_reg
// Description:: This class contains the register fields to that are allowed to generate an interrupt. 
//Writing a ‘1’ to a bit will enable the corresponding interrupt.  whose base address is 0x10
class intrpt_ctrl_reg extends uvm_reg;
    `uvm_object_utils(intrpt_ctrl_reg)
    //Register fields
    rand uvm_reg_field glbl_intrp_en;           //[31] :Global Interrupt Enable: Enables the global interrupt
    rand uvm_reg_field rsvd;                    //[30:4] Reserved
    rand uvm_reg_field undr_flow_intrp_en;      //[3] 1: Underflow Interrupt Enable: Enables the underflow interrupt
    rand uvm_reg_field aes_chan_stat_intrp_en;  //[2] 1: AES Channel Status Updated Interrupt Enable: Enables the AES channel status updated interrupt
    rand uvm_reg_field aes_sync_intrp_en;       //[1] 1: AES Block Sync Error Interrupt Enable: Enables the AES block sync interrupt
    rand uvm_reg_field aes_cmplt_intrp_en;      //[0] 1: AES Block Completed Interrupt Enable: Enables the AES block completed interrupt
    //Constructor
    function new(string name = "intrpt_ctrl_reg");
        super.new(name, 32, build_coverage(UVM_NO_COVERAGE));
    endfunction: new

    //Build function 
    virtual function void build();
        //Create Fields
        glbl_intrp_en = uvm_reg_field::type_id::create("glbl_intrp_en");
        rsvd = uvm_reg_field::type_id::create("rsvd");
        undr_flow_intrp_en = uvm_reg_field::type_id::create("undr_flow_intrp_en");
        aes_chan_stat_intrp_en = uvm_reg_field::type_id::create("aes_chan_stat_intrp_en");
        aes_sync_intrp_en = uvm_reg_field::type_id::create("aes_sync_intrp_en");
        aes_cmplt_intrp_en = uvm_reg_field::type_id::create("aes_cmplt_intrp_en");
        //Configure fileds 
        glbl_intrp_en.configure(this, 1, 31, "RW", 0, 0, 1, 0, 1);
        rsvd.configure(this, 27, 4, "RO", 0, 0, 0, 0, 1);
        undr_flow_intrp_en.configure(this, 1, 3, "RW", 0, 0, 1, 0, 1);
        aes_chan_stat_intrp_en.configure(this, 1, 2, "RW", 0, 0, 1, 0, 1);
        aes_sync_intrp_en.configure(this, 1, 1, "RW", 0, 0, 1, 0, 1);
        aes_cmplt_intrp_en.configure(this, 1, 0, "RW", 0, 0, 1, 0, 1);
    endfunction
endclass: intrpt_ctrl_reg 

//Class: intrpt_stat_reg
// Description:: This class contains the register fields to that returns the status of the interrupt bits. whose base address is 0x14
class intrpt_stat_reg extends uvm_reg;
    `uvm_object_utils(intrpt_stat_reg)
    //Register fields
    rand uvm_reg_field rsvd;                    //[31:4] Reserved
    rand uvm_reg_field undr_flow_intrp;         //[3] 1: Underflow Interrupt: This bit is set when the core did not receive the samples for all channels in time. 
                                                //       This scenario can lead to distortions in the audio that is being played. Write a ‘1’ to clear this bit.
    rand uvm_reg_field aes_chan_stat_intrp;     //[2] 1: AES Channel Status Updated: This bit is set when a change in the captured AES
                                                //       channel status has been detected. Write a ‘1’ to clear this flag.
    rand uvm_reg_field aes_sync_intrp;          //[1] 1: AES Block Sync Error: This bit is set when synchronization with the start of an AES block has been lost. 
                                                //       This occurs if the incoming audio our AXIS does violates the guidelines. Write a ‘1’ to clear this flag.
    rand uvm_reg_field aes_cmplt_intrp;         //[0] 1: AES Block Completed: This bit is set when a complete AES block has been received (192 AES frames). 
                                                //       This bit is set every time the IP receives one block of audio. Write a ‘1’ to clear this flag.
    //Constructor
    function new(string name = "intrpt_stat_reg");
        super.new(name, 32, build_coverage(UVM_NO_COVERAGE));
    endfunction: new

    //Build function 
    virtual function void build();
        //Create Fields
        rsvd = uvm_reg_field::type_id::create("rsvd");
        undr_flow_intrp = uvm_reg_field::type_id::create("undr_flow_intrp");
        aes_chan_stat_intrp = uvm_reg_field::type_id::create("aes_chan_stat_intrp");
        aes_sync_intrp = uvm_reg_field::type_id::create("aes_sync_intrp");
        aes_cmplt_intrp = uvm_reg_field::type_id::create("aes_cmplt_intrp");
        //Configure fileds 
        rsvd.configure(this, 28, 4, "RO", 0, 0, 0, 0, 1);
        undr_flow_intrp.configure(this, 1, 3, "W1C", 0, 0, 1, 0, 1);
        aes_chan_stat_intrp.configure(this, 1, 2, "W1C", 0, 0, 1, 0, 1);
        aes_sync_intrp.configure(this, 1, 1, "W1C", 0, 0, 1, 0, 1);
        aes_cmplt_intrp.configure(this, 1, 0, "W1C", 0, 0, 1, 0, 1);
    endfunction
endclass: intrpt_stat_reg 

//Class: i2s_tim_ctrl_reg
// Description:: This register is used to set the divider value to generate the SCLK. Typically SCLK = 2*24*Fs,
//               where 24 (this value can also be 16) is the I2S data width and Fs is the audio sampling rate. whose base address is 0x20
class i2s_tim_ctrl_reg extends uvm_reg;
    `uvm_object_utils(i2s_tim_ctrl_reg)
    //Register fields
    rand uvm_reg_field rsvd;                    //[31:8] Reserved
    rand uvm_reg_field sclk_div_val;            //[ 7:0] SCLK Out Divider Value: Set a divider value for a generation of SCLK. 
                                                //       The value of the divider should be such that MCLK/SCLK = Divider_value *2.
    //Constructor
    function new(string name = "i2s_tim_ctrl_reg");
        super.new(name, 32, build_coverage(UVM_NO_COVERAGE));
    endfunction: new

    //Build function 
    virtual function void build();
        //Create Fields
        rsvd = uvm_reg_field::type_id::create("rsvd");
        sclk_div_val = uvm_reg_field::type_id::create("sclk_div_val");
        //Configure fileds 
        rsvd.configure(this, 24, 8, "RO", 0, 0, 0, 0, 1);
        sclk_div_val.configure(this, 8, 0, "RW", 0, 0, 1, 0, 1);
    endfunction
endclass: i2s_tim_ctrl_reg 

// Class: chan_01_ctrl_reg
/* Description:: The IP provides a mechanism to route the audio channels onto any I2S output. For example,
                 audio received on channels 2/3 can be routed to the output on any of the four I2S ports.
                 Similarly, audio received on channels 0/1 can be routed to all of the four I2S ports. whose base address is 0x30
                */
class chan_01_ctrl_reg extends uvm_reg;
    `uvm_object_utils(chan_01_ctrl_reg)
    //Register fields
    rand uvm_reg_field rsvd;                    //[31:3] Reserved
    rand uvm_reg_field chan_mux_val;            /*[ 2:0] Channel MUX Value: Specify a value to multiplex the audio channel output.
                                                         0x0: Output on I2S channel 0 is disabled
                                                         0x1: I2S channel 0 outputs the audio received on channel 0 /1
                                                         0x2: I2S channel 0 outputs the audio received on channel 2 /3
                                                         0x3: I2S channel 0 outputs the audio received on channel 4 /5
                                                         0x4: I2S channel 0 outputs the audio received on channel 6 /7
                                                         All other values are reserved.
                                                         */
    // Constructor
    function new(string name = "chan_01_ctrl_reg");
        super.new(name, 32, build_coverage(UVM_NO_COVERAGE));
    endfunction: new

    // Build function 
    virtual function void build();
        // Create Fields
        rsvd = uvm_reg_field::type_id::create("rsvd");
        chan_mux_val = uvm_reg_field::type_id::create("chan_mux_val");
        // Configure fileds 
        rsvd.configure(this, 29, 3, "RO", 0, 0, 0, 0, 1);
        chan_mux_val.configure(this, 3, 0, "RW", 0, 1, 1, 0, 1);
    endfunction
endclass: chan_01_ctrl_reg 

// Class: chan_23_ctrl_reg
/* Description:: The IP provides a mechanism to route the audio channels onto any I2S output. For example,
                 audio received on channels 2/3 can be routed to the output on any of the four I2S ports.
                 Similarly, audio received on channels 0/1 can be routed to all of the four I2S ports. whose base address is 0x34
                  */
class chan_23_ctrl_reg extends uvm_reg;
    `uvm_object_utils(chan_23_ctrl_reg)
    // Register fields
    rand uvm_reg_field rsvd;                    //[31:3] Reserved
    rand uvm_reg_field chan_mux_val;            /*[ 2:0] Channel MUX Value: Specify a value to multiplex the audio channel output.
                                                            0x0: Output on I2S channel 1 is disabled
                                                            0x1: I2S channel 1 outputs the audio received on channel 0 /1
                                                            0x2: I2S channel 1 outputs the audio received on channel 2 /3
                                                            0x3: I2S channel 1 outputs the audio received on channel 4 /5
                                                            0x4: I2S channel 1 outputs the audio received on channel 6 /7
                                                            All other values are reserved.
                                                         */
    //Constructor
    function new(string name = "chan_23_ctrl_reg");
        super.new(name, 32, build_coverage(UVM_NO_COVERAGE));
    endfunction: new

    //Build function 
    virtual function void build();
        //Create Fields
        rsvd = uvm_reg_field::type_id::create("rsvd");
        chan_mux_val = uvm_reg_field::type_id::create("chan_mux_val");
        //Configure fileds 
        rsvd.configure(this, 29, 3, "RO", 0, 0, 0, 0, 1);
        chan_mux_val.configure(this, 3, 0, "RW", 0, 2, 1, 0, 1);
    endfunction
endclass: chan_23_ctrl_reg 

//Class: chan_45_ctrl_reg
/* Description:: The IP provides a mechanism to route the audio channels onto any I2S output. For example,
                 audio received on channels 2/3 can be routed to the output on any of the four I2S ports.
                 Similarly, audio received on channels 0/1 can be routed to all of the four I2S ports. whose base address is 0x38
                  */
class chan_45_ctrl_reg extends uvm_reg;
    `uvm_object_utils(chan_45_ctrl_reg)
    //Register fields
    rand uvm_reg_field rsvd;                    //[31:3] Reserved
    rand uvm_reg_field chan_mux_val;            /*[ 2:0] Channel MUX Value: Specify a value to multiplex the audio channel output.
                                                            0x0: Output on I2S channel 2 is disabled
                                                            0x1: I2S channel 1 outputs the audio received on channel 0 /1
                                                            0x2: I2S channel 1 outputs the audio received on channel 2 /3
                                                            0x3: I2S channel 1 outputs the audio received on channel 4 /5
                                                            0x4: I2S channel 1 outputs the audio received on channel 6 /7
                                                            All other values are reserved.
                                                         */
    //Constructor
    function new(string name = "chan_45_ctrl_reg");
        super.new(name, 32, build_coverage(UVM_NO_COVERAGE));
    endfunction: new

    //Build function 
    virtual function void build();
        //Create Fields
        rsvd = uvm_reg_field::type_id::create("rsvd");
        chan_mux_val = uvm_reg_field::type_id::create("chan_mux_val");
        //Configure fileds 
        rsvd.configure(this, 29, 3, "RO", 0, 0, 0, 0, 1);
        chan_mux_val.configure(this, 3, 0, "RW", 0, 3, 1, 0, 1);
    endfunction
endclass: chan_45_ctrl_reg 

//Class: chan_67_ctrl_reg
/* Description:: The IP provides a mechanism to route the audio channels onto any I2S output. For example,
                 audio received on channels 2/3 can be routed to the output on any of the four I2S ports.
                 Similarly, audio received on channels 0/1 can be routed to all of the four I2S ports. whose base address is 0x3C
                  */
class chan_67_ctrl_reg extends uvm_reg;
    `uvm_object_utils(chan_67_ctrl_reg)
    //Register fields
    rand uvm_reg_field rsvd;                    //[31:3] Reserved
    rand uvm_reg_field chan_mux_val;            /*[ 2:0] Channel MUX Value: Specify a value to multiplex the audio channel output.
                                                            0x0: Output on I2S channel 3 is disabled
                                                            0x1: I2S channel 1 outputs the audio received on channel 0 /1
                                                            0x2: I2S channel 1 outputs the audio received on channel 2 /3
                                                            0x3: I2S channel 1 outputs the audio received on channel 4 /5
                                                            0x4: I2S channel 1 outputs the audio received on channel 6 /7
                                                            All other values are reserved.
                                                         */
    //Constructor
    function new(string name = "chan_67_ctrl_reg");
        super.new(name, 32, build_coverage(UVM_NO_COVERAGE));
    endfunction: new

    //Build function 
    virtual function void build();
        //Create Fields
        rsvd = uvm_reg_field::type_id::create("rsvd");
        chan_mux_val = uvm_reg_field::type_id::create("chan_mux_val");
        //Configure fileds 
        rsvd.configure(this, 29, 3, "RO", 0, 0, 0, 0, 1);
        chan_mux_val.configure(this, 3, 0, "RW", 0, 4, 1, 0, 1);
    endfunction

endclass: chan_67_ctrl_reg 

//AES Channel Status (0x50-0x64)
/* Description:: These 6 registers together give the 192-bit channel status information that is received over the
                 audio block. A write to any of the six registers would restart the process of accumulating the
                 channel status and would result in the AES channel status updated interrupt. The 6 registers give
                 the value in order of LSB to MSB. The register 0x50 returns bits [31:0] of 192-bit channel status,
                 while the register 0x64 returns bits [191:160].
                  */

//Class: aes_chan_stat_reg0 :: Base addr:: 0x50
class aes_chan_stat_reg0 extends uvm_reg;
    `uvm_object_utils(aes_chan_stat_reg0)
    //Register fields
    rand uvm_reg_field aes_val;                    //[31:0] 32-bit AES Value: 32-bit AES Channel Status value.
    //Constructor
    function new(string name = "aes_chan_stat_reg0");
        super.new(name, 32, build_coverage(UVM_NO_COVERAGE));
    endfunction: new

    //Build function 
    virtual function void build();
        //Create Fields
        aes_val = uvm_reg_field::type_id::create("aes_val");
        //Configure fileds 
        aes_val.configure(this, 32, 0, "WC", 0, 0, 1, 0, 1);
    endfunction
endclass: aes_chan_stat_reg0 

//Class: aes_chan_stat_reg1 :: Base addr:: 0x54
class aes_chan_stat_reg1 extends uvm_reg;
    `uvm_object_utils(aes_chan_stat_reg1)
    //Register fields
    rand uvm_reg_field aes_val;                    //[31:0] 32-bit AES Value: 32-bit AES Channel Status value.
    //Constructor
    function new(string name = "aes_chan_stat_reg1");
        super.new(name, 32, build_coverage(UVM_NO_COVERAGE));
    endfunction: new

    //Build function 
    virtual function void build();
        //Create Fields
        aes_val = uvm_reg_field::type_id::create("aes_val");
        //Configure fileds 
        aes_val.configure(this, 32, 0, "WC", 0, 0, 1, 0, 1);
    endfunction
endclass: aes_chan_stat_reg1 

//Class: aes_chan_stat_reg2 :: Base addr:: 0x58
class aes_chan_stat_reg2 extends uvm_reg;
    `uvm_object_utils(aes_chan_stat_reg2)
    //Register fields
    rand uvm_reg_field aes_val;                    //[31:0] 32-bit AES Value: 32-bit AES Channel Status value.
    //Constructor
    function new(string name = "aes_chan_stat_reg2");
        super.new(name, 32, build_coverage(UVM_NO_COVERAGE));
    endfunction: new

    //Build function 
    virtual function void build();
        //Create Fields
        aes_val = uvm_reg_field::type_id::create("aes_val");
        //Configure fileds 
        aes_val.configure(this, 32, 0, "WC", 0, 0, 1, 0, 1);
    endfunction
endclass: aes_chan_stat_reg2 

//Class: aes_chan_stat_reg3 :: Base addr:: 0x5C
class aes_chan_stat_reg3 extends uvm_reg;
    `uvm_object_utils(aes_chan_stat_reg3)
    //Register fields
    rand uvm_reg_field aes_val;                    //[31:0] 32-bit AES Value: 32-bit AES Channel Status value.
    //Constructor
    function new(string name = "aes_chan_stat_reg3");
        super.new(name, 32, build_coverage(UVM_NO_COVERAGE));
    endfunction: new

    //Build function 
    virtual function void build();
        //Create Fields
        aes_val = uvm_reg_field::type_id::create("aes_val");
        //Configure fileds 
        aes_val.configure(this, 32, 0, "WC", 0, 0, 1, 0, 1);
    endfunction
endclass: aes_chan_stat_reg3 

//Class: aes_chan_stat_reg4 :: Base addr:: 0x60
class aes_chan_stat_reg4 extends uvm_reg;
    `uvm_object_utils(aes_chan_stat_reg4)
    //Register fields
    rand uvm_reg_field aes_val;                    //[31:0] 32-bit AES Value: 32-bit AES Channel Status value.
    //Constructor
    function new(string name = "aes_chan_stat_reg4");
        super.new(name, 32, build_coverage(UVM_NO_COVERAGE));
    endfunction: new

    //Build function 
    virtual function void build();
        //Create Fields
        aes_val = uvm_reg_field::type_id::create("aes_val");
        //Configure fileds 
        aes_val.configure(this, 32, 0, "WC", 0, 0, 1, 0, 1);
    endfunction
endclass: aes_chan_stat_reg4

//Class: aes_chan_stat_reg5 :: Base addr:: 0x64
class aes_chan_stat_reg5 extends uvm_reg;
    `uvm_object_utils(aes_chan_stat_reg5)
    //Register fields
    rand uvm_reg_field aes_val;                    //[31:0] 32-bit AES Value: 32-bit AES Channel Status value.
    //Constructor
    function new(string name = "aes_chan_stat_reg5");
        super.new(name, 32, build_coverage(UVM_NO_COVERAGE));
    endfunction: new

    //Build function 
    virtual function void build();
        //Create Fields
        aes_val = uvm_reg_field::type_id::create("aes_val");
        //Configure fileds 
        aes_val.configure(this, 32, 0, "WC", 0, 0, 1, 0, 1);
    endfunction
endclass: aes_chan_stat_reg5 

`endif