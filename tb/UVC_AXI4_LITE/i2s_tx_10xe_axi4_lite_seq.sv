/*************************************************************************
   > File Name: i2s_tx_10xe_axi4_lite_seq.sv
   > Description: This file contains sequence class for I2S TX AXI4-Lite interface.
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
//  Description: Base sequence class for I2S TX AXI4-Lite interface
class i2s_tx_10xe_axi4_lite_seq extends uvm_sequence;
    `uvm_object_utils(i2s_tx_10xe_axi4_lite_seq);

    // Constructor: new
    // Description: Initializes the sequence class with the provided name.
    function new(string name = "i2s_tx_10xe_axi4_lite_seq");
        super.new(name);
    endfunction: new

    // Task: pre_body
    // Description: Optional code to execute before the main sequence body.
    virtual task pre_body();
        `uvm_info("BASE_SEQ", $sformatf("Optional code can be placed here in pre_body()"), UVM_MEDIUM)
        
        // Raise objection to indicate the start of the sequence
        if (starting_phase != null) begin
            starting_phase.raise_objection(this);
            `uvm_info(get_name(), "<SEQ> Started, objection raised.", UVM_NONE)
        end
    endtask: pre_body

    // Task: post_body
    // Description: Optional code to execute after the main sequence body.
    virtual task post_body();
        `uvm_info("BASE_SEQ", $sformatf("Optional code can be placed here in post_body()"), UVM_MEDIUM)
        
        // Drop objection to indicate the end of the sequence
        if (starting_phase != null) begin
            starting_phase.drop_objection(this);
            `uvm_info(get_name(), "<SEQ> Finished, objection dropped.", UVM_NONE)
        end
    endtask: post_body
    
endclass: i2s_tx_10xe_axi4_lite_seq


//  Class: read_reg_seq
//  Description: Sequence to read from registers
class read_reg_seq extends i2s_tx_10xe_axi4_lite_seq;
    `uvm_object_utils(read_reg_seq);

    i2s_tx_10xe_axi4_lite_seq_item    axi_seq;  // Sequence item for AXI operations

    // Constructor: new
    // Description: Initializes the read_reg_seq class with the provided name.
    function new(string name = "read_reg_seq");
        super.new(name);
    endfunction: new

    // Task: body
    // Description: Main execution body of the read register sequence.
    task body();
        `uvm_info(get_name(), "Executing Read Register Sequence", UVM_NONE)

        // Repeating the AXI transaction 50 times
        repeat(50) begin
            `uvm_do(axi_seq)  // Execute the AXI sequence
        end
    endtask: body
    
endclass: read_reg_seq


//  Class: axi_rst_seq
//  Description: Sequence to reset signals before driving them in AXI interface
class axi_rst_seq extends i2s_tx_10xe_axi4_lite_seq;
    `uvm_object_utils(axi_rst_seq);

    i2s_tx_10xe_axi4_lite_seq_item    axi_seq;  // Sequence item for AXI operations

    // Constructor: new
    // Description: Initializes the axi_rst_seq class with the provided name.
    function new(string name = "axi_rst_seq");
        super.new(name);
    endfunction: new

    // Task: body
    // Description: Main execution body of the reset sequence.
    task body();
        `uvm_info(get_name(), "Executing AXI Reset Sequence", UVM_NONE)

        // Optional: Turn off constraint to avoid overlapping signals
        // axi_seq.read_reg.constraint_mode(0);  // Uncomment if required

        // Drive signals to reset values using uvm_do_with
        `uvm_do_with(axi_seq, {
            axi_seq.s_axi_ctrl_awaddr   == 0;
            axi_seq.s_axi_ctrl_awvalid  == 0;
            axi_seq.s_axi_ctrl_wdata    == 0;
            axi_seq.s_axi_ctrl_wvalid   == 0;
            axi_seq.s_axi_ctrl_bready   == 0;
            axi_seq.s_axi_ctrl_araddr   == 0;
            axi_seq.s_axi_ctrl_arvalid  == 0;
            axi_seq.s_axi_ctrl_rready   == 0;
        })
    endtask: body
    
endclass: axi_rst_seq

`endif