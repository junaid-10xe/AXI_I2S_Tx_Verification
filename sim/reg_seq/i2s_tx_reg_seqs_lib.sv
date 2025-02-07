/*************************************************************************
   > File Name: i2s_tx_reg_seqs_lib.sv
   > Description: This file defines the Sequences to test RAL.
   > Author: Muhammad Junaid Ramzan
   > Modified: Muhammad Junaid Ramzan
   > Mail: muhammad.junaid@10xengineers.ai
   ---------------------------------------------------------------
   Copyright   (c)2024 10xEngineers
   ---------------------------------------------------------------
************************************************************************/
`ifndef I2S_TX_REG_SEQS_LIB
`define I2S_TX_REG_SEQS_LIB

// Sequence to read registers in reset 
class ral_rst_rd_seq extends i2s_tx_reg_base_seq;
    `uvm_object_utils(ral_rst_rd_seq)


    // Constructor
    function new (string name = "ral_rst_rd_seq");
        super.new(name);
    endfunction

    task body();
        // Read registers in reset before configuration
        read_reg_in_reset(cfg.RD_REGS_IN_RST);
    endtask
endclass: ral_rst_rd_seq

// RAL Sequence to configure core 
class ral_cfg_seq extends i2s_tx_reg_base_seq;
    `uvm_object_utils(ral_cfg_seq)

    // Constructor
    function new (string name = "ral_cfg_seq");
        super.new(name);
    endfunction

    task body();
        // Configure core
        configure_core(cfg.CORE_CFG);
    endtask
endclass: ral_cfg_seq

// RAL Sequence to Only read registers 
class ral_rd_seq extends i2s_tx_reg_base_seq;
    `uvm_object_utils(ral_rd_seq)

    // Constructor
    function new (string name = "ral_rd_seq");
        super.new(name);
    endfunction

    task body();
        // Read registers
        read_registers(cfg.RD_REGS);
    endtask
endclass: ral_rd_seq


//Class RAL seq 
class ral_test_seq extends i2s_tx_reg_base_seq;
    `uvm_object_utils(ral_test_seq)
    // Constructor 
    function new (string name = "ral_test_seq");
        super.new(name);
    endfunction

    // Task body 
    task body();
        // To generate sequnce to read registers
        if (cfg.RD_REGS && cfg.RD_REGS_DFT) begin
            read_reg_dft();
        end
        else if (cfg.RD_REGS) begin
            read_registers(cfg.RD_REGS);
        end
        // To generate sequence first write then read
        if (cfg.WR_RD_REGS) begin
            wr_rd_reg_seq(cfg.WR_RD_REGS, cfg.RAL_DATA_PATTERN);
        end
        // To generate sequence to read value of core version reg
        if (cfg.CORE_VER_TEST) begin
            i2s_tx_defines::reg_data   actual_val;     // read value
            reg_blk.core_version_reg_h.read(status, actual_val, UVM_FRONTDOOR);
            if(actual_val[31:16]==1 && actual_val[15:0]==0) begin
                `uvm_info(get_name(), "CORE VERSION TEST PASSED", UVM_LOW)
            end
            else begin
                `uvm_error(get_name(), "CORE VERSION TEST FAILED")
            end
        end
        
        // To generate sequence to read value of core config reg
        if (cfg.CORE_CFG_TEST) begin
            i2s_tx_defines::reg_data   actual_val;     // read value
            reg_blk.core_cfg_reg_h.read(status, actual_val, UVM_FRONTDOOR);
            if(actual_val[31:17]==1 && actual_val[16]==1 && actual_val[15:12]==0 && actual_val[11:8]==2 && actual_val[7:1]==0 && actual_val[0]==1) begin
                `uvm_info(get_name(), "CORE Configuration TEST PASSED", UVM_LOW)
            end
            else begin
                `uvm_error(get_name(), $sformatf("CORE CONFIGURATION TEST FAILED Expected :: %0h, Actual ::%0h", 'h30201, actual_val))
            end
        end
        //To generate sequence to test RO fields of registers
        if(cfg.REG_RO_FIELDS) begin
            wr_ro_reg_field_seq(cfg.RAL_DATA_PATTERN);
        end
        // To generate sequence to test RW fields of registers
        if(cfg.REG_RW_FIELDS) begin
            wr_rw_reg_field_seq(cfg.RAL_DATA_PATTERN);
        end

    endtask

endclass

//Class CORE CFG Reg test  seq 
class core_cfg_reg_seq extends i2s_tx_reg_base_seq;
    `uvm_object_utils(core_cfg_reg_seq)
    // Constructor 
    function new (string name = "core_cfg_reg_seq");
        super.new(name);
    endfunction

    // Task body 
    task body();
        
        // To generate sequence to read value of core config reg
        if (cfg.CORE_CFG_TEST) begin
            i2s_tx_defines::reg_data   actual_val;     // read value
            reg_blk.core_cfg_reg_h.read(status, actual_val, UVM_FRONTDOOR);
            if(actual_val[31:17]==1 && actual_val[16]==1 && actual_val[15:12]==0 && actual_val[11:8]==2 && actual_val[7:1]==0 && actual_val[0]==1) begin
                `uvm_info(get_name(), "CORE Configuration READ RESET VALUE TEST PASSED", UVM_LOW)
            end
            else begin
                `uvm_error(get_name(), $sformatf("CORE CONFIGURATION READ RESET VALUE TEST FAILED Expected :: %0h, Actual ::%0h", 'h30201, actual_val))
            end

            reg_blk.core_cfg_reg_h.write(status, 'hFFFFFFFF, UVM_FRONTDOOR);
            write_ro_reg_fields(reg_blk.core_cfg_reg_h,cfg.RAL_DATA_PATTERN);
        end

    endtask

endclass


//Class RAL seq to read interrupt status register forever 
class intrpt_ctrl_test_seq extends i2s_tx_reg_base_seq;
    `uvm_object_utils(intrpt_ctrl_test_seq)
    // Constructor 
    function new (string name = "intrpt_ctrl_test_seq");
        super.new(name);
    endfunction

    // Task body 
    task body();
        forever begin
            i2s_tx_defines::reg_data   actual_val;     // read value
            reg_blk.intrpt_stat_reg_h.read(status, actual_val, UVM_FRONTDOOR);
        end
    endtask

endclass: intrpt_ctrl_test_seq

//Class seq to read interrupt status register in forever and if interrupy occur write with 1 to clear the bit 
class intrpt_stat_test_seq extends i2s_tx_reg_base_seq;
    `uvm_object_utils(intrpt_stat_test_seq)
    // Constructor 
    function new (string name = "intrpt_stat_test_seq");
        super.new(name);
    endfunction

    // Task body 
    task body();
        forever begin
            i2s_tx_axi4_lite_seq_item           req;                     // Transaction handle
            i2s_tx_axi4_lite_seq_item           rsp;                     // Transaction handle
            
            if (cfg.INTRPT_STAT_TEST) begin
                `uvm_do_with(req, {req.s_axi_ctrl_araddr  == 'h14;
                                   req.s_axi_ctrl_arvalid == 1;
                                   req.s_axi_ctrl_awvalid == 0;})
            end
            if(req.s_axi_ctrl_rdata[0] != 0) begin
                `uvm_do_with(rsp, {rsp.s_axi_ctrl_awaddr  == 'h14;
                                   rsp.s_axi_ctrl_awvalid == 1;
                                   rsp.s_axi_ctrl_wdata   == 32'h1;
                                   rsp.s_axi_ctrl_arvalid == 0;})
            end
            if(req.s_axi_ctrl_rdata[1] != 0) begin
                `uvm_do_with(rsp, {rsp.s_axi_ctrl_awaddr  == 'h14;
                                   rsp.s_axi_ctrl_awvalid == 1;
                                   rsp.s_axi_ctrl_wdata   == 32'h2;
                                   rsp.s_axi_ctrl_arvalid == 0;})
            end
            if(req.s_axi_ctrl_rdata[2] != 0) begin
                `uvm_do_with(rsp, {rsp.s_axi_ctrl_awaddr  == 'h14;
                                   rsp.s_axi_ctrl_awvalid == 1;
                                   rsp.s_axi_ctrl_wdata   == 32'h4;
                                   rsp.s_axi_ctrl_arvalid == 0;})
            end
            if(req.s_axi_ctrl_rdata[3] != 0) begin
                `uvm_do_with(rsp, {rsp.s_axi_ctrl_awaddr  == 'h14;
                                   rsp.s_axi_ctrl_awvalid == 1;
                                   rsp.s_axi_ctrl_wdata   == 32'h8;
                                   rsp.s_axi_ctrl_arvalid == 0;})
            end

        end
    endtask

endclass: intrpt_stat_test_seq

//Class seq to generate random sequence with constraint mode off 
class reg_rand_seq extends i2s_tx_reg_base_seq;
    `uvm_object_utils(reg_rand_seq)
    // Constructor 
    function new (string name = "reg_rand_seq");
        super.new(name);
    endfunction
    // Handle of seq item
    i2s_tx_axi4_lite_seq_item           axi_seq;                     // Transaction handle

    // Task body 
    task body();
        repeat (100) begin
            axi_seq = i2s_tx_axi4_lite_seq_item::type_id::create("axi_seq");
            axi_seq.write.constraint_mode(0);
            axi_seq.read.constraint_mode(0);
            axi_seq.addr.constraint_mode(0);
            start_item(axi_seq);
            assert(axi_seq.randomize() with {
                axi_seq.s_axi_ctrl_wvalid  == 1;
                axi_seq.s_axi_ctrl_rready  == 1;
            });
            finish_item(axi_seq);
        end
    endtask

endclass: reg_rand_seq


`endif