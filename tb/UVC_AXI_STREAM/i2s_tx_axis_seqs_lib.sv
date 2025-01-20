/*************************************************************************
   > File Name: i2s_tx_axis_seqs_lib.sv
   > Description: This file contains sequence classes for AXI-Stream in I2S.
   > Author: Muhammad Junaid Ramzan
   > Modified: Muhammad Junaid Ramzan
   > Mail: muhammad.junaid@10xengineers.ai
   ---------------------------------------------------------------
   Copyright   (c)2024 10xEngineers
   ---------------------------------------------------------------
************************************************************************/
`ifndef I2S_TX_AXIS_SEQS_LIB
`define I2S_TX_AXIS_SEQS_LIB

// Class: axis_i2s_seq
// Description: AXI-Stream transaction sequence for I2S for sanity test
class axis_i2s_seq extends i2s_tx_axis_base_seq;
    `uvm_object_utils(axis_i2s_seq)
    i2s_tx_axis_seq_item axis_seq;

    // Constructor: new
    function new(string name = "axis_i2s_seq");
        super.new(name);
    endfunction: new

    // Task: body
    // Description: Executes the main sequence logic
    task body();
        `uvm_info(get_name(), "Executing axis_i2s Seq", UVM_NONE)
        // firs two transactions with zero data for start of audio block 
        
        `uvm_do_with(axis_seq, {axis_seq.s_axis_aud_tdata[3:0]  == 4'b0001;         // Start of Block
                                axis_seq.s_axis_aud_tdata[27:4] == 24'h0;           // Audio Data
                                axis_seq.s_axis_aud_tdata[28]   == 0;               // Valididty Bit
                                axis_seq.s_axis_aud_tdata[30]   == 1;
                                axis_seq.s_axis_aud_tid         == 3'b000;
                                axis_seq.s_axis_aud_tvalid      == 1;})

        `uvm_do_with(axis_seq, {axis_seq.s_axis_aud_tdata[3:0]      == 4'b0011;
                                axis_seq.s_axis_aud_tdata[27:4]     == 24'h0;
                                axis_seq.s_axis_aud_tdata[28]       == 0;
                                axis_seq.s_axis_aud_tdata[30]       == 1;
                                axis_seq.s_axis_aud_tid             == 3'b001;
                                axis_seq.s_axis_aud_tvalid          == 1;})
        
        repeat (cfg.NUM_TRANS) begin
            `uvm_do_with(axis_seq, {axis_seq.s_axis_aud_tdata[3:0]  == 4'b0010;
                                    axis_seq.s_axis_aud_tdata[28]   == 0;
                                    axis_seq.s_axis_aud_tid         == 3'b000;
                                    axis_seq.s_axis_aud_tvalid      == 1;})

            `uvm_do_with(axis_seq, {axis_seq.s_axis_aud_tdata[3:0]  == 4'b0011;
                                    s_axis_aud_tdata[28]            == 0;
                                    axis_seq.s_axis_aud_tid         == 3'b001;
                                    axis_seq.s_axis_aud_tvalid      == 1;})
        end

    endtask: body

endclass: axis_i2s_seq

// Sequence to test tvalid for handshake of axi-stream 
class axis_tvalid_test_seq extends i2s_tx_axis_base_seq;
    `uvm_object_utils(axis_tvalid_test_seq)
        // Constructor: new
        function new(string name = "axis_tvalid_test_seq");
            super.new(name);
        endfunction: new
    
        // Task: body
        // Description: Executes the main sequence logic
        task body();
            `uvm_info(get_name(), "Executing axis_tvalid_test_seq", UVM_NONE)
            // firs two transactions with zero data for start of audio block 
            // and tvalid is zero for all 
            
            `uvm_do_with(axis_seq, {axis_seq.s_axis_aud_tdata[3:0]  == 4'b0001;
                                    axis_seq.s_axis_aud_tdata[27:4] == 24'h0;
                                    axis_seq.s_axis_aud_tdata[30]   == 1;
                                    axis_seq.s_axis_aud_tdata[28]   == 0;               // Valididty Bit
                                    axis_seq.s_axis_aud_tid         == 3'b000;
                                    axis_seq.s_axis_aud_tvalid      == 0;})
    
            `uvm_do_with(axis_seq, {axis_seq.s_axis_aud_tdata[3:0]      == 4'b0011;
                                    axis_seq.s_axis_aud_tdata[27:4]     == 24'h0;
                                    axis_seq.s_axis_aud_tdata[30]       == 1;
                                    axis_seq.s_axis_aud_tdata[28]       == 0;               // Valididty Bit
                                    axis_seq.s_axis_aud_tid             == 3'b001;
                                    axis_seq.s_axis_aud_tvalid          == 0;})
            
            repeat (cfg.NUM_TRANS) begin
                `uvm_do_with(axis_seq, {axis_seq.s_axis_aud_tdata[3:0]  == 4'b0010;
                                        axis_seq.s_axis_aud_tdata[28]   == 0;               // Valididty Bit
                                        axis_seq.s_axis_aud_tid         == 3'b000;
                                        axis_seq.s_axis_aud_tvalid      == 0;})
    
                `uvm_do_with(axis_seq, {axis_seq.s_axis_aud_tdata[3:0]  == 4'b0011;
                                        axis_seq.s_axis_aud_tdata[28]   == 0;               // Valididty Bit
                                        axis_seq.s_axis_aud_tid         == 3'b001;
                                        axis_seq.s_axis_aud_tvalid      == 0;})
            end
    
        endtask: body
    
endclass: axis_tvalid_test_seq

// Sequence to test valid bit tdata[28] of tdata for testing that dut process that data or not for low tdata[28] 
class axis_valid_bit_low_seq extends i2s_tx_axis_base_seq;
    `uvm_object_utils(axis_valid_bit_low_seq)
        // Constructor: new
        function new(string name = "axis_valid_bit_low_seq");
            super.new(name);
        endfunction: new
    
        // Task: body
        // Description: Executes the main sequence logic
        task body();
            `uvm_info(get_name(), "Executing axis_valid_bit_low_seq", UVM_NONE)
            // firs two transactions with zero data for start of audio block 
            // and tvalid is zero for all 
            
            `uvm_do_with(axis_seq, {axis_seq.s_axis_aud_tdata[3:0]  == 4'b0001;
                                    axis_seq.s_axis_aud_tdata[27:4] == 24'h0;
                                    axis_seq.s_axis_aud_tdata[28]   == 0;               // Valididty Bit
                                    axis_seq.s_axis_aud_tdata[30]   == 1;
                                    axis_seq.s_axis_aud_tid         == 3'b000;
                                    axis_seq.s_axis_aud_tvalid      == 1;})
    
            `uvm_do_with(axis_seq, {axis_seq.s_axis_aud_tdata[3:0]      == 4'b0011;
                                    axis_seq.s_axis_aud_tdata[27:4]     == 24'h0;
                                    axis_seq.s_axis_aud_tdata[28]       == 0;               // Valididty Bit
                                    axis_seq.s_axis_aud_tdata[30]       == 1;
                                    axis_seq.s_axis_aud_tid             == 3'b001;
                                    axis_seq.s_axis_aud_tvalid          == 1;})
            
            repeat (cfg.NUM_TRANS) begin
                `uvm_do_with(axis_seq, {axis_seq.s_axis_aud_tdata[3:0]  == 4'b0010;
                                        axis_seq.s_axis_aud_tdata[28]   == 0;               // Valididty Bit
                                        axis_seq.s_axis_aud_tid         == 3'b000;
                                        axis_seq.s_axis_aud_tvalid      == 1;})
    
                `uvm_do_with(axis_seq, {axis_seq.s_axis_aud_tdata[3:0]  == 4'b0011;
                                        axis_seq.s_axis_aud_tdata[28]   == 0;               // Valididty Bit
                                        axis_seq.s_axis_aud_tid         == 3'b001;
                                        axis_seq.s_axis_aud_tvalid      == 1;})
            end
    
        endtask: body
    
endclass: axis_valid_bit_low_seq

// Sequence to test valid bit tdata[28] of tdata for testing that dut process that data or not for hi tdata[28] 
class axis_valid_bit_hi_seq extends i2s_tx_axis_base_seq;
    `uvm_object_utils(axis_valid_bit_hi_seq)
        // Constructor: new
        function new(string name = "axis_valid_bit_hi_seq");
            super.new(name);
        endfunction: new
    
        // Task: body
        // Description: Executes the main sequence logic
        task body();
            `uvm_info(get_name(), "Executing axis_valid_bit_hi_seq", UVM_NONE)
            // firs two transactions with zero data for start of audio block 
            // and tvalid is zero for all 
            
            `uvm_do_with(axis_seq, {axis_seq.s_axis_aud_tdata[3:0]  == 4'b0001;
                                    axis_seq.s_axis_aud_tdata[27:4] == 24'h0;
                                    axis_seq.s_axis_aud_tdata[28]   == 0;               // Valididty Bit
                                    axis_seq.s_axis_aud_tdata[30]   == 1;
                                    axis_seq.s_axis_aud_tid         == 3'b000;
                                    axis_seq.s_axis_aud_tvalid      == 1;})
    
            `uvm_do_with(axis_seq, {axis_seq.s_axis_aud_tdata[3:0]      == 4'b0011;
                                    axis_seq.s_axis_aud_tdata[27:4]     == 24'h0;
                                    axis_seq.s_axis_aud_tdata[28]       == 0;               // Valididty Bit
                                    axis_seq.s_axis_aud_tdata[30]       == 1;
                                    axis_seq.s_axis_aud_tid             == 3'b001;
                                    axis_seq.s_axis_aud_tvalid          == 1;})
            
            repeat (cfg.NUM_TRANS) begin
                `uvm_do_with(axis_seq, {axis_seq.s_axis_aud_tdata[3:0]  == 4'b0010;
                                        axis_seq.s_axis_aud_tdata[28]   == 1;               // Valididty Bit
                                        axis_seq.s_axis_aud_tid         == 3'b000;
                                        axis_seq.s_axis_aud_tvalid      == 1;})
    
                `uvm_do_with(axis_seq, {axis_seq.s_axis_aud_tdata[3:0]  == 4'b0011;
                                        axis_seq.s_axis_aud_tdata[28]   == 1;               // Valididty Bit
                                        axis_seq.s_axis_aud_tid         == 3'b001;
                                        axis_seq.s_axis_aud_tvalid      == 1;})
            end
    
        endtask: body
    
endclass: axis_valid_bit_hi_seq

// Sequence with constraint mode off to collect coverage for all possible random values 

class axis_rand_seq extends i2s_tx_axis_base_seq;
    `uvm_object_utils(axis_rand_seq)
        // Constructor: new
        function new(string name = "axis_rand_seq");
            super.new(name);
        endfunction: new
        
        // Handle of axis seq
        i2s_tx_axis_seq_item axis_seq; 
    
        // Task: body
        // Description: Executes the main sequence logic
        task body();
            `uvm_info(get_name(), "Executing axis_rand_seq", UVM_NONE)
            // firs two transactions with zero data for start of audio block 
            // and tvalid is zero for all 
            
            // firs two transactions with zero data for start of audio block 
            // and tvalid is zero for all
            axis_seq = i2s_tx_axis_seq_item::type_id::create("axis_seq");
            start_item(axis_seq);
            assert(axis_seq.randomize() with {axis_seq.s_axis_aud_tdata[3:0]  == 4'b0001;
                                    axis_seq.s_axis_aud_tdata[27:4] == 24'h0;
                                    axis_seq.s_axis_aud_tdata[28]   == 0;
                                    axis_seq.s_axis_aud_tid         == 3'b000;
                                    axis_seq.s_axis_aud_tvalid      == 1;});
            finish_item(axis_seq);
    
            start_item(axis_seq);
            assert(axis_seq.randomize() with {axis_seq.s_axis_aud_tdata[3:0]      == 4'b0011;
                                    axis_seq.s_axis_aud_tdata[27:4]     == 24'h0;
                                    axis_seq.s_axis_aud_tdata[28]       == 0;               // Valididty Bit
                                    axis_seq.s_axis_aud_tid             == 3'b001;
                                    axis_seq.s_axis_aud_tvalid          == 1;});
            finish_item(axis_seq);
            
            repeat (cfg.NUM_TRANS) begin
                axis_seq = i2s_tx_axis_seq_item::type_id::create("axis_seq");
                start_item(axis_seq);
                axis_seq.tdata_tid_constraint.constraint_mode(0);
                assert(axis_seq.randomize() with {axis_seq.s_axis_aud_tdata[3:0]  == 4'b0010;
                                        axis_seq.s_axis_aud_tid         == 3'b000;
                                        axis_seq.s_axis_aud_tvalid      == 1;})
                finish_item(axis_seq);
                
                axis_seq = i2s_tx_axis_seq_item::type_id::create("axis_seq");
                axis_seq.tdata_tid_constraint.constraint_mode(0);
                start_item(axis_seq);
                assert(axis_seq.randomize() with {axis_seq.s_axis_aud_tdata[3:0]  == 4'b0011;
                                        axis_seq.s_axis_aud_tid         == 3'b001;
                                        axis_seq.s_axis_aud_tvalid      == 1;});
                finish_item(axis_seq);

            end
        endtask: body
    
endclass: axis_rand_seq

`endif