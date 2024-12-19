/*************************************************************************
   > File Name: i2s_tx_10xe_axi4_lite_seq.sv
   > Description: This file contains sequence class.
   > Author: Muhammad Junaid Ramzan
   > Modified: Muhammad Junaid Ramzan
   > Mail: muhammad.junaid@10xengineers.ai
   ---------------------------------------------------------------
   Copyright   (c)2024 10xEngineers
   ---------------------------------------------------------------
************************************************************************/
`ifndef I2S_TX_10XE_AXI4_LITE_SEQ
`define I2S_TX_10XE_AXI4_LITE_SEQ
//  Class: i2s_tx_10xe_axi4_lite_seq
//
class i2s_tx_10xe_axi4_lite_seq extends uvm_sequence;
    `uvm_object_utils(i2s_tx_10xe_axi4_lite_seq);

    

    //  Constructor: new
    function new(string name = "i2s_tx_10xe_axi4_lite_seq");
        super.new(name);
    endfunction: new

    
    
    // task pre_body();
    //     uvm_phase phase;
    //     `ifdef UVM_VERSION_1_2
    //       // in UVM1.2, get starting phase from method
    //       phase = get_starting_phase();
    //     `else
    //       phase = starting_phase;
    //     `endif
    //     if (phase != null) begin
    //       phase.raise_objection(this, get_type_name());
    //       `uvm_info(get_type_name(), "raise objection", UVM_MEDIUM)
    //     end
    //   endtask : pre_body
    
    // task post_body();
    //     uvm_phase phase;
    //     `ifdef UVM_VERSION_1_2
    //       // in UVM1.2, get starting phase from method
    //       phase = get_starting_phase();
    //     `else
    //       phase = starting_phase;
    //     `endif
    //     if (phase != null) begin
    //       phase.drop_objection(this, get_type_name());
    //       `uvm_info(get_type_name(), "drop objection", UVM_MEDIUM)
    //     end
    //   endtask : post_body
    
    
    
endclass: i2s_tx_10xe_axi4_lite_seq


//  Class: read_reg_seq
//
class read_reg_seq extends i2s_tx_10xe_axi4_lite_seq;
    `uvm_object_utils(read_reg_seq);

    i2s_tx_10xe_seq_item    axi_seq;

    //  Constructor: new
    function new(string name = "read_reg_seq");
        super.new(name);
    endfunction: new

    //task body
    task body();
        `uvm_info(get_name(), "Executing Simple Seq", UVM_NONE)
        repeat(50) begin
            `uvm_do(axi_seq)
        end
    endtask: body
    
endclass: read_reg_seq

`endif