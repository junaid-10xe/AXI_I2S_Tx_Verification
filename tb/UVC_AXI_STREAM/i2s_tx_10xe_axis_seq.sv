/*************************************************************************
   > File Name: i2s_tx_10xe_axis_seq.sv
   > Description: This file contains sequence classes for AXI-Stream in I2S.
   > Author: Muhammad Junaid Ramzan
   > Modified: Muhammad Junaid Ramzan
   > Mail: muhammad.junaid@10xengineers.ai
   ---------------------------------------------------------------
   Copyright   (c)2024 10xEngineers
   ---------------------------------------------------------------
************************************************************************/
`ifndef I2S_TX_10XE_AXIS_SEQ
`define I2S_TX_10XE_AXIS_SEQ
// Class: i2s_tx_10xe_axis_seq
// Description: Base sequence for AXI-Stream
class i2s_tx_10xe_axis_seq extends uvm_sequence;
    `uvm_object_utils(i2s_tx_10xe_axis_seq);

    //  Constructor: new
    function new(string name = "i2s_tx_10xe_axis_seq");
        super.new(name);
    endfunction: new

    
    // Task: pre_body
    // Description: Optional code before the main sequence body
    virtual task pre_body();
        `uvm_info("BASE_SEQ", $sformatf("Optional code can be placed here in pre_body()"), UVM_MEDIUM)
        if (starting_phase != null) begin
            starting_phase.raise_objection(this);
            `uvm_info(get_name(), "<SEQ> Started, objection raised.", UVM_NONE)
        end
    endtask: pre_body

    // Task: post_body
    // Description: Optional code after the main sequence body
    virtual task post_body();
        `uvm_info("BASE_SEQ", $sformatf("Optional code can be placed here in post_body()"), UVM_MEDIUM)
        if (starting_phase != null) begin
            starting_phase.drop_objection(this);
            `uvm_info(get_name(), "<SEQ> Finished, objection dropped.", UVM_NONE)
        end
    endtask: post_body
    
    
endclass: i2s_tx_10xe_axis_seq


// Class: axis_i2s_seq
// Description: AXI-Stream transaction sequence for I2S
class axis_i2s_seq extends i2s_tx_10xe_axis_seq;
    `uvm_object_utils(axis_i2s_seq)

    i2s_tx_10xe_axis_seq_item axis_seq;

    // Constructor: new
    function new(string name = "axis_i2s_seq");
        super.new(name);
    endfunction: new

    // Task: body
    // Description: Executes the main sequence logic
    task body();
        `uvm_info(get_name(), "Executing axis_i2s Seq", UVM_NONE)
        repeat (50) begin
            start_item(axis_seq);
            assert(axis_seq.randomize());
            finish_item(axis_seq);
        end
    endtask: body

endclass: axis_i2s_seq

// Class: axis_rst_seq
// Description: AXI-Stream reset sequence
class axis_rst_seq extends i2s_tx_10xe_axis_seq;
    `uvm_object_utils(axis_rst_seq)

    i2s_tx_10xe_axis_seq_item axis_seq;

    // Constructor: new
    function new(string name = "axis_rst_seq");
        super.new(name);
    endfunction: new

    // Task: body
    // Description: Executes the reset sequence
    task body();
        `uvm_info(get_name(), "Executing axis_rst Seq", UVM_NONE)
        repeat (40) begin
            start_item(axis_seq);
            assert(axis_seq.randomize() with {
                axis_seq.s_axis_aud_tdata  == 0;
                axis_seq.s_axis_aud_tvalid == 0;
                axis_seq.s_axis_aud_tid    == 0;
            });
            finish_item(axis_seq);
        end
    endtask: body

endclass: axis_rst_seq

`endif // I2S_TX_10XE_AXIS_SEQ