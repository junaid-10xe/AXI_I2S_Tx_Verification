/*************************************************************************
   > File Name: i2s_tx_reg_base_seq.sv
   > Description: This file defines the base Sequence for RAL from which other seqs are derived in seqs lib file.
   > Author: Muhammad Junaid Ramzan
   > Modified: Muhammad Junaid Ramzan
   > Mail: muhammad.junaid@10xengineers.ai
   ---------------------------------------------------------------
   Copyright   (c)2024 10xEngineers
   ---------------------------------------------------------------
************************************************************************/
`ifndef I2S_TX_REG_BASE_SEQ
`define I2S_TX_REG_BASE_SEQ
// Class :: i2s_tx_reg_base_seq

class i2s_tx_reg_base_seq extends uvm_sequence;
    `uvm_object_utils(i2s_tx_reg_base_seq)
    // Handle of reg block 
    i2s_tx_reg_blk          reg_blk;
    uvm_status_e            status;
    uvm_reg                 reg_h;

    // Handle of config class
    i2s_tx_config           cfg;
    // declaring variable for configuration of sequence
    bit core_cfg;                                                              // Bit to cinfugure core 
    bit axi_stream_data_valid;                                    // Optional if we want to make data valid on stream
    bit en_dis_int;                                                          // BIT to enable disable interrupt
    bit rd_regs;                                                                // Bit to READ RAL REGISTERS
    bit rd_regs_in_rst;                                                  // BIT to read registers in reset phase
    bit wr_rd_regs;                                                          // Bit to write and read RAL REGISTERS 
    i2s_tx_defines::data_pattern_e data_pattern;      // To genrate write data value according to pattern

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
            `uvm_error(get_name(), $sformatf(" for Read GOT status UVM_NOT_OK for register %0s", reg_h.get_name()))
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
            `uvm_error(get_name(), $sformatf(" for Read GOT status UVM_NOT_OK for register %0s", reg_h.get_name()))
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
                `uvm_error(get_name(), $sformatf(" For WRITE GOT status UVM_NOT_OK for register %0s", reg_h.get_name()))
            end
        read_reg(reg_h);
        
    endtask: write_read_reg

    //Task to write and Read on read only fields of registers
    task write_ro_reg_fields(input uvm_reg reg_h,
        input i2s_tx_defines::data_pattern_e data_pattern); 

        i2s_tx_defines::reg_data   actual_val;     // read value
        i2s_tx_defines::reg_data   expected_val;   // desired value
        i2s_tx_defines::reg_data   write_val;
        uvm_reg_field              fields[$];      // Queue to get reg fields
        // get write value according to pattern
        get_write_val(write_val, data_pattern);
        `uvm_info(get_name(), $sformatf("WRITE VAL is %0h :: DATA PATTERN IS :: %0h", write_val, data_pattern), UVM_LOW)
        // write value to register
        reg_h.get_fields(fields);
            foreach(fields[i]) begin
                if(fields[i].get_access() == "RO") begin
                    `uvm_info(get_name(), $sformatf("FIELD %s is RO", fields[i].get_full_name()), UVM_HIGH)
                    fields[i].write(status, write_val, UVM_FRONTDOOR);
                    if(status != UVM_IS_OK) begin   
                        `uvm_error(get_name(), $sformatf(" For WRITE GOT status UVM_NOT_OK for register field %0s", fields[i].get_full_name()))
                    end
                    else begin
                    expected_val = fields[i].get_reset(); 
                    fields[i].read(status, actual_val, UVM_FRONTDOOR);
                    if (expected_val==actual_val) begin
                            `uvm_info(get_name(), $sformatf("RO REG FIELDS TEST PASSED : %s ACTUAL VALUE :: %0h == EXPECTED VALUE :: %0h", fields[i].get_full_name(), actual_val, expected_val), UVM_NONE)
                        end
                        else begin
                            `uvm_error(get_name(), $sformatf("RO REG FIELDS TEST FAILED : %s ACTUAL VALUE :: %0h != EXPECTED VALUE :: %0h", fields[i].get_full_name(), actual_val, expected_val))
                        end
                    end
                end
            end

endtask: write_ro_reg_fields

// Task to write and Read on read only fields of registers
task write_rw_reg_fields(input uvm_reg reg_h,
    input i2s_tx_defines::data_pattern_e data_pattern); 

    i2s_tx_defines::reg_data   actual_val;     // read value
    i2s_tx_defines::reg_data   expected_val;   // desired value
    i2s_tx_defines::reg_data   write_val;
    uvm_reg_field              fields[$];      // Queue to get reg fields
    // get write value according to pattern
    get_write_val(write_val, data_pattern);
    `uvm_info(get_name(), $sformatf("WRITE VAL is %0h :: DATA PATTERN IS :: %0h", write_val, data_pattern), UVM_LOW)
    // write value to register
    reg_h.get_fields(fields);
        foreach(fields[i]) begin
            if (fields[i].get_access() == "RW") begin
                `uvm_info(get_name(), $sformatf("FIELD %s is RW", fields[i].get_full_name()), UVM_HIGH)
                fields[i].write(status, write_val, UVM_FRONTDOOR);
                expected_val = fields[i].get();
                if(status != UVM_IS_OK) begin
                    `uvm_error(get_name(), $sformatf(" For WRITE GOT status UVM_NOT_OK for register field %0s", fields[i].get_full_name()))
                end
                else begin
                    fields[i].read(status, actual_val, UVM_FRONTDOOR);
                    if (expected_val==actual_val) begin
                        `uvm_info(get_name(), $sformatf("RW REG FIELDS TEST PASSED : %s ACTUAL VALUE :: %0h == EXPECTED VALUE :: %0h", fields[i].get_full_name(), actual_val, expected_val), UVM_NONE)
                    end
                    else begin
                        `uvm_error(get_name(), $sformatf("RW REG FIELDS TEST FAILED : %s ACTUAL VALUE :: %0h != EXPECTED VALUE :: %0h", fields[i].get_full_name(), actual_val, expected_val))
                    end
                end
            end
        end

endtask: write_rw_reg_fields

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
            default:                  begin
                                                write_val = 32'b0;
                                           end
        endcase
    endtask: get_write_val

    // task to configure core before starting the main phase 
    task configure_core(input core_cfg);
        if(core_cfg) begin
            // configure core
            `uvm_info(get_name(), "Configuring REGISTERS", UVM_LOW)
            // Optional if we want to make data valid on stream 
            if(cfg.AXI_STREAM_DATA_VALID) begin
                reg_blk.validity_reg_h.write(status, 1, UVM_FRONTDOOR); 
            end
            // Optional if want to enable disable interupts
            if(cfg.EN_DIS_INT) begin
                reg_blk.intrpt_ctrl_reg_h.write(status, 32'h80000007, UVM_FRONTDOOR);                
            end
            //Set value for sclk divider
            reg_blk.i2s_tim_ctrl_reg_h.write(status, i2s_tx_params::SCLK_DIVIDER_VALUE, UVM_FRONTDOOR);
            //Enable core
            if(cfg.LEFT_JUSTICATION) reg_blk.control_reg_h.write(status, 3, UVM_FRONTDOOR);             // Left Justification
            else if(cfg.RIGHT_JUSTICATION) reg_blk.control_reg_h.write(status, 7, UVM_FRONTDOOR);       // Right Justification
            else reg_blk.control_reg_h.write(status, 1, UVM_FRONTDOOR);                                 // Default with no justification
            `uvm_info(get_name(), $sformatf("THE FREQUENCY OF AUD_MCLK IS :: %0d THE PERIOD OF AUD_MCLK IS :: %0d", i2s_tx_params::AUD_MCLK_FREQUENCY, i2s_tx_params::AUD_MCLK_PERIOD), UVM_NONE)
            `uvm_info(get_name(), $sformatf("THE FREQUENCY OF SCLK SHOULD :: %0d THE PERIOD OF SCLK SHOULD :: %0d", i2s_tx_params::SCLK_FREQUENCY, i2s_tx_params::SCLK_PERIOD), UVM_NONE)
            
        end
    endtask: configure_core

    // Task to read register in reset phase 
    task read_reg_in_reset(input rd_regs_in_rst);
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

    // Task to read register Main phase when reset is applied in main phase 
    task read_reg_dft();
        // queue to get registers from reg block
        uvm_reg regs[$];

        `uvm_info(get_name(), "READING REGISTERS After RESET", UVM_LOW)

        // Get registers from reg block
        reg_blk.get_registers(regs);
        // Read registers in reset before configuration
        foreach(regs[i]) begin
            read_rst_reg(regs[i]);
        end
    endtask: read_reg_dft

    // Task to generate sequence to read registers
    task read_registers(input rd_regs);
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
    task wr_rd_reg_seq(input wr_rd_regs, input i2s_tx_defines::data_pattern_e data_pattern);
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

    // Task to write and read registers RO fields
    task wr_ro_reg_field_seq(input i2s_tx_defines::data_pattern_e data_pattern);
        // queue to get registers from reg block
        uvm_reg regs[$];
        // get registers from reg block
        `uvm_info(get_name(), "WRITING AND READING REGISTERS ", UVM_LOW)
        reg_blk.get_registers(regs);
        foreach (regs[i]) begin
            write_ro_reg_fields(regs[i],data_pattern);
        end
    endtask: wr_ro_reg_field_seq

    // Task to write and read registers RW fields
    task wr_rw_reg_field_seq(input i2s_tx_defines::data_pattern_e data_pattern);
        // queue to get registers from reg block
        uvm_reg regs[$];
        // get registers from reg block
        `uvm_info(get_name(), "WRITING AND READING REGISTERS ", UVM_LOW)
        reg_blk.get_registers(regs);
        foreach (regs[i]) begin
            write_rw_reg_fields(regs[i],data_pattern);
        end
    endtask: wr_rw_reg_field_seq


endclass: i2s_tx_reg_base_seq

`endif