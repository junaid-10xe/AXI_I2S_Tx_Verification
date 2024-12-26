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
    // virtual task pre_body();
    //     `uvm_info("BASE_SEQ", $sformatf("Optional code can be placed here in pre_body()"), UVM_MEDIUM)
    //     if (starting_phase != null) begin
    //         starting_phase.raise_objection(this);
    //         `uvm_info(get_name(), "<SEQ> Started, objection raised.", UVM_NONE)
    //     end
    // endtask: pre_body

    // // Task: post_body
    // // Description: Optional code after the main sequence body
    // virtual task post_body();
    //     `uvm_info("BASE_SEQ", $sformatf("Optional code can be placed here in post_body()"), UVM_MEDIUM)
    //     if (starting_phase != null) begin
    //         starting_phase.drop_objection(this);
    //         `uvm_info(get_name(), "<SEQ> Finished, objection dropped.", UVM_NONE)
    //     end
    // endtask: post_body
    
    
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
        axis_seq = i2s_tx_10xe_axis_seq_item::type_id::create("axis_seq");
        axis_seq.data_tid.constraint_mode(0);
        start_item(axis_seq);
        assert(axis_seq.randomize() with {
                                        axis_seq.s_axis_aud_tvalid       == 1;
                                        axis_seq.s_axis_aud_tdata[31]    == 0;  // Parity
                                        axis_seq.s_axis_aud_tdata[30]    == 1;  // Channel Status
                                        axis_seq.s_axis_aud_tdata[29]    == 0;  // USER bit
                                        axis_seq.s_axis_aud_tdata[28]    == 0;  // Validity Bit
                                        axis_seq.s_axis_aud_tdata[27:0]   == 1;//, 4'b0011};  // Specific valid values
                                        axis_seq.s_axis_aud_tid          == 3'b000; 
   
             
                                        });
        finish_item(axis_seq);
        start_item(axis_seq);
        assert(axis_seq.randomize() with {
                                        axis_seq.s_axis_aud_tvalid       == 1;
                                        axis_seq.s_axis_aud_tdata[31]    == 0;  // Parity
                                        axis_seq.s_axis_aud_tdata[30]    == 1;  // Channel Status
                                        axis_seq.s_axis_aud_tdata[29]    == 0;  // USER bit
                                        axis_seq.s_axis_aud_tdata[28]    == 0;  // Validity Bit
                                        axis_seq.s_axis_aud_tdata[27:0]   == 3;//, 4'b0011};  // Specific valid values
                                        axis_seq.s_axis_aud_tid          == 3'b001; 
   
             
                                        });
        finish_item(axis_seq);
        // axis_seq.data_tid.constraint_mode(1);
        repeat (100) begin
            // `uvm_do(axis_seq)

            start_item(axis_seq);
            assert(axis_seq.randomize() with {
                axis_seq.s_axis_aud_tvalid       == 1;
                axis_seq.s_axis_aud_tdata[31]    == 0;  // Parity
                // axis_seq.s_axis_aud_tdata[30]    == 1;  // Channel Status
                axis_seq.s_axis_aud_tdata[29]    == 0;  // USER bit
                // axis_seq.s_axis_aud_tdata[28]    == 1;  // Validity Bit
                axis_seq.s_axis_aud_tdata[3:0]   == 4'b0010;//, 4'b0011};  // Specific valid values
                axis_seq.s_axis_aud_tid          == 3'b000; 


                });
            finish_item(axis_seq);
            start_item(axis_seq);
            assert(axis_seq.randomize() with {
                axis_seq.s_axis_aud_tvalid       == 1;
                axis_seq.s_axis_aud_tdata[31]    == 0;  // Parity
                // axis_seq.s_axis_aud_tdata[30]    == 1;  // Channel Status
                axis_seq.s_axis_aud_tdata[29]    == 0;  // USER bit
                // axis_seq.s_axis_aud_tdata[28]    == 1;  // Validity Bit
                axis_seq.s_axis_aud_tdata[3:0]   == 4'b0011;//, 4'b0011};  // Specific valid values
                axis_seq.s_axis_aud_tid          == 3'b001; 


                });
            finish_item(axis_seq);
        end
    endtask: body

endclass: axis_i2s_seq



`endif // I2S_TX_10XE_AXIS_SEQ