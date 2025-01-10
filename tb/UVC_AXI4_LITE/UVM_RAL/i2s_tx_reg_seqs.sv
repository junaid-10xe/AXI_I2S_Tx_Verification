/*************************************************************************
   > File Name: i2s_tx_reg_seqs.sv
   > Description: This file defines the Sequences to test RAL.
   > Author: Muhammad Junaid Ramzan
   > Modified: Muhammad Junaid Ramzan
   > Mail: muhammad.junaid@10xengineers.ai
   ---------------------------------------------------------------
   Copyright   (c)2024 10xEngineers
   ---------------------------------------------------------------
************************************************************************/
`ifndef I2S_TX_REG_SEQS
`define I2S_TX_REG_SEQS
// Class :: i2s_tx_reg_base_seq

class i2s_tx_reg_base_seq extends uvm_sequence;
    `uvm_object_utils(i2s_tx_reg_base_seq)
    // Handle of reg block 
    i2s_tx_reg_blk  reg_blk;
    uvm_status_e         status;
    uvm_reg              reg_h;
    // declaring variable for configuration of sequence
    bit core_cfg                = i2s_tx_defines::CORE_CFG;                // Bit to cinfugure core 
    bit axi_stream_data_valid   = i2s_tx_defines::AXI_STREAM_DATA_VALID;   // Optional if we want to make data valid on stream
    bit en_dis_int              = i2s_tx_defines::EN_DIS_INT;              // BIT to enable disable interrupt
    bit rd_regs                 = i2s_tx_defines::RD_REGS;                 // Bit to READ RAL REGISTERS
    bit rd_regs_in_rst          = i2s_tx_defines::RD_REGS_IN_RST;          // BIT to read registers in reset phase
    bit wr_rd_regs              = i2s_tx_defines::WR_RD_REGS;              // Bit to write and read RAL REGISTERS
    // To genrate write data value according to pattern 
    i2s_tx_defines::data_pattern_e data_pattern  = i2s_tx_defines::RAL_DATA_PATTERN;

    // Constructor
    function new (string name = "i2s_tx_reg_base_seq");
        super.new(name);  
    endfunction

    // task to read register in reset and compare their values with their reset values
    task read_rst_reg(input uvm_reg reg_h);

        i2s_tx_defines::reg_data   actual_val;     // read value
        i2s_tx_defines::reg_data   expected_val;   // desired value
        
        //get reset value of register
        expected_val = reg_h.get_reset();
        reg_h.read(status, actual_val, UVM_FRONTDOOR);
        if(status != UVM_IS_OK) begin   
            `uvm_error(get_name(), "GOT status UVM_NOT_OK")
        end
        else begin
            // get expected val
            // compare with read value
            if (expected_val==actual_val) begin
                `uvm_info(get_name(), $sformatf("TEST PASSED : %s ACTUAL VALUE :: %0h == EXPECTED VALUE :: %0h", reg_h.get_name(), actual_val, expected_val), UVM_NONE)
            end
            else begin
                `uvm_error(get_name(), $sformatf("TEST FAILED : %s ACTUAL VALUE :: %0h != EXPECTED VALUE :: %0h", reg_h.get_name(), actual_val, expected_val))
            end
        end
    endtask: read_rst_reg

    // task to read register and compare it desired and mirrored value
    task read_reg(input uvm_reg reg_h);

        i2s_tx_defines::reg_data   actual_val;     // read value
        i2s_tx_defines::reg_data   expected_val;   // desired value
        
        reg_h.read(status, actual_val, UVM_FRONTDOOR);
        if(status != UVM_IS_OK) begin   
            `uvm_error(get_name(), "GOT status UVM_NOT_OK")
        end
        else begin
            // get expected val
            expected_val = reg_h.get();
            // compare with read value
            if (expected_val==actual_val) begin
                `uvm_info(get_name(), $sformatf("TEST PASSED : %s ACTUAL VALUE :: %0h == EXPECTED VALUE :: %0h", reg_h.get_name(), actual_val, expected_val), UVM_NONE)
            end
            else begin
                `uvm_error(get_name(), $sformatf("TEST FAILED : %s ACTUAL VALUE :: %0h != EXPECTED VALUE :: %0h", reg_h.get_name(), actual_val, expected_val))
            end
        end
    endtask: read_reg

    task write_read_reg(input uvm_reg reg_h,
                        input i2s_tx_defines::data_pattern_e data_pattern); 
        
        i2s_tx_defines::reg_data   actual_val;     // read value
        i2s_tx_defines::reg_data   expected_val;   // desired value
        i2s_tx_defines::reg_data   write_val;
            
            // get write value according to pattern
            get_write_val(write_val, data_pattern);
            `uvm_info(get_name(), $sformatf("WRITE VAL is %0h :: DATA PATTERN IS :: %0h", write_val, data_pattern), UVM_LOW)
            // write value to register
            reg_h.write(status, write_val);
            if(status != UVM_IS_OK) begin   
                `uvm_error(get_name(), "WRITE :: UVM_NOT_OK")
            end
        read_reg(reg_h);
        
    endtask: write_read_reg

    // Task to get write value according to data_pattern want to write on regsiter
    task get_write_val(output i2s_tx_defines::reg_data   write_val, 
                       input i2s_tx_defines::data_pattern_e data_pattern);
        case (i2s_tx_defines::data_pattern_e'(data_pattern))
            i2s_tx_defines::ALL_ZERO: begin
                                                write_val = 32'b0;
                                           end
            i2s_tx_defines::ALL_ONES: begin
                                                write_val = 32'hFFFFFFFF;
                                           end
            i2s_tx_defines::RANDOM:   begin
                                                write_val = $urandom_range(32'hFFFFFFFF, 32'b0);
                                           end
            default:                       begin
                                                write_val = 32'b0;
                                           end
        endcase
    endtask: get_write_val

    // task to configure core before starting the main phase 
    task configure_core();
        if(core_cfg) begin
            // configure core
            `uvm_info(get_name(), "Configuring REGISTERS", UVM_LOW)
            // Optional if we want to make data valid on stream 
            if(axi_stream_data_valid) begin
                reg_blk.validity_reg_h.write(status, 1, UVM_FRONTDOOR); 
            end
            // Optional if want to enable disable interupts
            if(en_dis_int) begin
                reg_blk.intrpt_ctrl_reg_h.write(status, 32'h80000007, UVM_FRONTDOOR);                
            end
            //Set value for sclk divider
            reg_blk.i2s_tim_ctrl_reg_h.write(status, i2s_tx_defines::SCLK_DIVIDER_VALUE, UVM_FRONTDOOR);
            //Enable core
            reg_blk.control_reg_h.write(status, 1, UVM_FRONTDOOR);
            `uvm_info(get_name(), $sformatf("THE FREQUENCY OF AUD_MCLK IS :: %0d THE PERIOD OF AUD_MCLK IS :: %0d", i2s_tx_defines::AUD_MCLK_FREQUENCY, i2s_tx_defines::AUD_MCLK_PERIOD), UVM_NONE)
            `uvm_info(get_name(), $sformatf("THE FREQUENCY OF SCLK SHOULD :: %0d THE PERIOD OF SCLK SHOULD :: %0d", i2s_tx_defines::SCLK_FREQUENCY, i2s_tx_defines::SCLK_PERIOD), UVM_NONE)
            
        end
    endtask: configure_core

    // Task to read register in reset phase 
    task read_reg_in_reset();
        // queue to get registers from reg block
        uvm_reg regs[$];

        if(rd_regs_in_rst) begin
            `uvm_info(get_name(), "READING REGISTERS IN RESET", UVM_LOW)

            // Get registers from reg block
            reg_blk.get_registers(regs);
            // Read registers in reset before configuration
            foreach(regs[i]) begin
                read_rst_reg(regs[i]);
            end
        end
    endtask: read_reg_in_reset

    // Task to generate sequence to read registers
    task read_registers();
        // queue to get registers from reg block
        uvm_reg regs[$];

        if(rd_regs) begin
            // get registers from reg block
            `uvm_info(get_name(), "READING REGISTERS ", UVM_LOW)
            reg_blk.get_registers(regs);
            foreach (regs[i]) begin
                read_reg(regs[i]);
            end
        end
    endtask: read_registers

    // Task to write and read registers
    task wr_rd_reg_seq();
        // queue to get registers from reg block
        uvm_reg regs[$];

        if(wr_rd_regs) begin
            // get registers from reg block
            `uvm_info(get_name(), "WRITING AND READING REGISTERS ", UVM_LOW)
            reg_blk.get_registers(regs);
            
            foreach (regs[i]) begin
                write_read_reg(regs[i],data_pattern);
            end
        end
    endtask: wr_rd_reg_seq

endclass: i2s_tx_reg_base_seq


// Sequence to read registers in reset 
class ral_rst_rd_seq extends i2s_tx_reg_base_seq;
    `uvm_object_utils(ral_rst_rd_seq)

    // Constructor
    function new (string name = "ral_rst_rd_seq");
        super.new(name);
    endfunction

    task body();
        // Read registers in reset before configuration
        read_reg_in_reset();
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
        configure_core();
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
        read_registers();
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
        read_registers();
        // Write then read write value base on pattern
        wr_rd_reg_seq();
    endtask
endclass: ral_rd_wr_seq

`endif