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
        read_reg_in_reset(rd_regs_in_rst);
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
        configure_core(core_cfg);
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
        read_registers(rd_regs);
    endtask
endclass: ral_rd_seq

// RAL Sequence to Only read registers or write read registers or both first read then write read based on configuration bits 
class ral_rd_wr_seq extends i2s_tx_reg_base_seq;
    `uvm_object_utils(ral_rd_wr_seq)

    // Constructor
    function new (string name = "ral_rd_wr_seq");
        super.new(name);
    endfunction

    task body();
        // Read registers
        read_registers(rd_regs);
        // Write then read write value base on pattern
        wr_rd_reg_seq(wr_rd_regs);
    endtask
endclass: ral_rd_wr_seq

`endif