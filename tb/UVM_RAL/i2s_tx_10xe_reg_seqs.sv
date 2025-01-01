/*************************************************************************
   > File Name: i2s_tx_10xe_reg_seqs.sv
   > Description: This file defines the Sequences to test RAL.
   > Author: Muhammad Junaid Ramzan
   > Modified: Muhammad Junaid Ramzan
   > Mail: muhammad.junaid@10xengineers.ai
   ---------------------------------------------------------------
   Copyright   (c)2024 10xEngineers
   ---------------------------------------------------------------
************************************************************************/
`ifndef I2S_TX_10XE_REG_SEQS
`define I2S_TX_10XE_REG_SEQS
//Class :: i2s_tx_reg_base_seq

class i2s_tx_reg_base_seq extends uvm_sequence;
    `uvm_object_utils(i2s_tx_reg_base_seq)
    // Handle of reg block 
    i2s_tx_10xe_reg_blk  reg_blk;
    uvm_status_e         status;
    uvm_reg              reg_h;

    //Constructor
    function new (string name = "i2s_tx_reg_base_seq");
        super.new(name);  
    endfunction

    //task to read register and compare it desired and mirrored value
    task read_reg(input uvm_reg reg_h);

        i2s_tx_10xe_defines::reg_data   actual_val; //read value
        i2s_tx_10xe_defines::reg_data   expected_val; //desired value

        reg_h.read(status, actual_val, UVM_FRONTDOOR);
        if(status != UVM_IS_OK) begin   
            `uvm_error(get_name(), "GOT status UVM_NOT_OK")
        end
        else begin
            //get expected val
            expected_val = reg_h.get();
            //compare with read value
            if (expected_val==actual_val) begin
                `uvm_info(get_name(), $sformatf("TEST PASSED : %s ACTUAL VALUE :: %0h == EXPECTED VALUE :: %0h", reg_h.get_name(), actual_val, expected_val), UVM_NONE)
            end
            else begin
                `uvm_error(get_name(), $sformatf("TEST FAILED : %s ACTUAL VALUE :: %0h != EXPECTED VALUE :: %0h", reg_h.get_name(), actual_val, expected_val))
            end
        end
    endtask

    task write_read_reg(input uvm_reg reg_h,
                        input i2s_tx_10xe_defines::reg_data   write_val, 
                        input bit configure,
                        input i2s_tx_10xe_defines::data_pattern_e data_pattern); 
        
        i2s_tx_10xe_defines::reg_data   actual_val; //read value
        i2s_tx_10xe_defines::reg_data   expected_val; //desired value

        if(configure) begin
            reg_h.write(status, write_val, UVM_FRONTDOOR);
            if(status != UVM_IS_OK) begin   
                `uvm_error(get_name(), "WRITE :: UVM_NOT_OK")
            end
        end
        else begin
            get_write_val(write_val, data_pattern);
            `uvm_info(get_name(), $sformatf("WRITE VAL is %0h :: DATA PATTERN IS :: %0h", write_val, data_pattern), UVM_LOW)
            reg_h.write(status, write_val);
            if(status != UVM_IS_OK) begin   
                `uvm_error(get_name(), "WRITE :: UVM_NOT_OK")
            end
        end
        read_reg(reg_h);
        
    endtask

    task get_write_val(output i2s_tx_10xe_defines::reg_data   write_val, 
                       input i2s_tx_10xe_defines::data_pattern_e data_pattern);
        case (i2s_tx_10xe_defines::data_pattern_e'(data_pattern))
            i2s_tx_10xe_defines::ALL_ZERO: begin
                                                write_val = 32'b0;
                                           end
            i2s_tx_10xe_defines::ALL_ONES: begin
                                                write_val = 32'hFFFFFFFF;
                                           end
            i2s_tx_10xe_defines::RANDOM:   begin
                                                write_val = $urandom_range(32'hFFFFFFFF, 32'b0);
                                           end
            i2s_tx_10xe_defines::DEFAULT:  begin
                                                write_val = 32'b0;
                                           end
            
        endcase
    endtask
endclass: i2s_tx_reg_base_seq

//Class :: read_ral_seq
class read_ral_seq extends i2s_tx_reg_base_seq;
    `uvm_object_utils(read_ral_seq)
    //Constructor
    function new (string name = "read_ral_seq");
        super.new(name);
    endfunction

    //queue to get registers from reg block
    uvm_reg regs[$];

    task body();
        //get registers from reg block
        reg_blk.get_registers(regs);
        foreach (regs[i]) begin
            read_reg(regs[i]);
        end
    endtask
endclass: read_ral_seq

class wr_rd_reg_seq extends i2s_tx_reg_base_seq;
    `uvm_object_utils(wr_rd_reg_seq)
    i2s_tx_10xe_reg_blk  reg_blk;

    //Constructor
    function new (string name = "wr_rd_reg_seq");
        super.new(name);
    endfunction

    //queue to get registers from reg block
    uvm_reg regs[$];

    task body();
        //get registers from reg block
        reg_blk.get_registers(regs);
        
        foreach (regs[i]) begin
            write_read_reg(regs[i],
                        0, 
                        0,
                        i2s_tx_10xe_defines::data_pattern_e'(2'b01));
        end
    endtask
endclass: wr_rd_reg_seq

`endif