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
// Class: i2s_tx_10xe_axi4_lite_seq
// Description: Base sequence class for I2S TX AXI4-Lite interface
class i2s_tx_10xe_axi4_lite_seq extends uvm_sequence;
    `uvm_object_utils(i2s_tx_10xe_axi4_lite_seq);

    // Constructor: new
    // Description: Initializes the sequence class with the provided name.
    function new(string name = "i2s_tx_10xe_axi4_lite_seq");
        super.new(name);
    endfunction: new

endclass: i2s_tx_10xe_axi4_lite_seq

// Class: config_reg_seq
// Description: Sequence to configure core registers
class config_reg_seq extends i2s_tx_10xe_axi4_lite_seq;
    `uvm_object_utils(config_reg_seq);

    i2s_tx_10xe_axi4_lite_seq_item    axi_seq;  // Sequence item for AXI operations

    // Constructor: new
    // Description: Initializes the read_reg_seq class with the provided name.
    function new(string name = "config_reg_seq");
        super.new(name);
    endfunction: new

    // Task: body
    // Description: Main execution body of the read register sequence.
    task body();
        `uvm_info(get_name(), "Executing Config Register Sequence", UVM_NONE)
        axi_seq = i2s_tx_10xe_axi4_lite_seq_item::type_id::create("axi_seq");
        // axi_seq.read_reg.constraint_mode(0);
        repeat(1) begin
        axi_seq = i2s_tx_10xe_axi4_lite_seq_item::type_id::create("axi_seq");
        // axi_seq.read_reg.constraint_mode(0);
        
        `uvm_info(get_name(), "Starting Validity Register Sequence", UVM_NONE)
        // start_item(axi_seq);
        // assert(axi_seq.randomize() with {axi_seq.s_axi_ctrl_awaddr   == 'h0c;
        //                       axi_seq.s_axi_ctrl_awvalid  == 1;
        //                       axi_seq.s_axi_ctrl_wvalid   == 1;
        //                       axi_seq.s_axi_ctrl_wdata    == 0;
        //                       axi_seq.s_axi_ctrl_arvalid  == 0; 
                               

        //                      });
        // `uvm_info(get_name(), "Executing validity Register Sequence", UVM_NONE)
        
        // finish_item(axi_seq);
        // `uvm_info(get_name(), "Executed validity Register Sequence", UVM_NONE)
        // `uvm_info(get_name(), "Starting Validity Register Sequence", UVM_NONE)
        // start_item(axi_seq);
        // assert(axi_seq.randomize() with {
        //                       axi_seq.s_axi_ctrl_awaddr   == 'h10;
        //                       axi_seq.s_axi_ctrl_awvalid  == 1;
        //                       axi_seq.s_axi_ctrl_wvalid   == 1;
        //                       axi_seq.s_axi_ctrl_wdata    == 'h80000000;
        //                       axi_seq.s_axi_ctrl_arvalid  == 0; 

        //                      });
        // `uvm_info(get_name(), "Executing validity Register Sequence", UVM_NONE)
        
        // finish_item(axi_seq);
        // `uvm_info(get_name(), "Starting Validity Register Sequence", UVM_NONE)
        // start_item(axi_seq);
        // assert(axi_seq.randomize() with {axi_seq.s_axi_ctrl_awaddr   == 'h0c;
        //                       axi_seq.s_axi_ctrl_awvalid  == 1;
        //                       axi_seq.s_axi_ctrl_wvalid   == 1;
        //                       axi_seq.s_axi_ctrl_wdata    == 0;
        //                       axi_seq.s_axi_ctrl_arvalid  == 0; 
                               

        //                      });
        // `uvm_info(get_name(), "Executing validity Register Sequence", UVM_NONE)
        
        // finish_item(axi_seq);
        // `uvm_info(get_name(), "Executed validity Register Sequence", UVM_NONE)
        `uvm_info(get_name(), "Starting Validity Register Sequence", UVM_NONE)
        start_item(axi_seq);
        assert(axi_seq.randomize() with {
                              axi_seq.s_axi_ctrl_awaddr   == 'h20;
                              axi_seq.s_axi_ctrl_awvalid  == 1;
                              axi_seq.s_axi_ctrl_wvalid   == 1;
                              axi_seq.s_axi_ctrl_wdata    == 'h02;
                              axi_seq.s_axi_ctrl_arvalid  == 0; 
                             });
        `uvm_info(get_name(), "Executing validity Register Sequence", UVM_NONE)
        
        finish_item(axi_seq);
        // start_item(axi_seq);
        // assert(axi_seq.randomize() with {
        //                       axi_seq.s_axi_ctrl_awaddr   == 'h34;
        //                       axi_seq.s_axi_ctrl_awvalid  == 1;
        //                       axi_seq.s_axi_ctrl_wvalid   == 1;
        //                       axi_seq.s_axi_ctrl_wdata    == 0;
        //                       axi_seq.s_axi_ctrl_arvalid  == 0; 
        //                      });
        // `uvm_info(get_name(), "Executing validity Register Sequence", UVM_NONE)
        
        // finish_item(axi_seq);
        // start_item(axi_seq);
        // assert(axi_seq.randomize() with {
        //                       axi_seq.s_axi_ctrl_awaddr   == 'h38;
        //                       axi_seq.s_axi_ctrl_awvalid  == 1;
        //                       axi_seq.s_axi_ctrl_wvalid   == 1;
        //                       axi_seq.s_axi_ctrl_wdata    == 0;
        //                       axi_seq.s_axi_ctrl_arvalid  == 0; 
        //                      });
        // `uvm_info(get_name(), "Executing validity Register Sequence", UVM_NONE)
        
        // finish_item(axi_seq);
        // start_item(axi_seq);
        // assert(axi_seq.randomize() with {
        //                       axi_seq.s_axi_ctrl_awaddr   == 'h3C;
        //                       axi_seq.s_axi_ctrl_awvalid  == 1;
        //                       axi_seq.s_axi_ctrl_wvalid   == 1;
        //                       axi_seq.s_axi_ctrl_wdata    == 0;
        //                       axi_seq.s_axi_ctrl_arvalid  == 0; 
        //                      });
        // `uvm_info(get_name(), "Executing validity Register Sequence", UVM_NONE)
        
        // finish_item(axi_seq);
        `uvm_info(get_name(), "Executing Control Register Sequence", UVM_NONE)
        start_item(axi_seq);
        assert(axi_seq.randomize() with {axi_seq.s_axi_ctrl_awaddr   == 'h08;
                               axi_seq.s_axi_ctrl_awvalid  == 1;
                               axi_seq.s_axi_ctrl_wvalid   == 1;
                               axi_seq.s_axi_ctrl_wdata    == 1;
                               axi_seq.s_axi_ctrl_arvalid  == 0; 

                              });
        finish_item(axi_seq);
        `uvm_info(get_name(), "Core Enabled", UVM_NONE)
        end
    endtask: body
    
endclass: config_reg_seq

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
        axi_seq = i2s_tx_10xe_axi4_lite_seq_item::type_id::create("axi_seq");

        repeat(34) begin
            start_item(axi_seq);
            // axi_seq.read_reg.constraint_mode(1);
            assert(axi_seq.randomize()with {
                // Allow read address valid signal to be active
                axi_seq.s_axi_ctrl_arvalid == 1;
            
                // Restrict read address to specific register addresses
                axi_seq.s_axi_ctrl_araddr inside {
                    'h00, 'h04, 'h08, 'h0C, 'h10, 'h14, 
                    'h20, 'h30, 'h34, 'h38, 'h3C, 'h50, 
                    'h54, 'h58, 'h5C, 'h60, 'h64
                };

                // Ensure read ready signal is active
                axi_seq.s_axi_ctrl_rready == 1;
            
                // Ensure write operations are not active
                axi_seq.s_axi_ctrl_awvalid == 0;
                axi_seq.s_axi_ctrl_wvalid == 0;
                }); 
        `uvm_info(get_name(), "Executing Sequence", UVM_NONE)
        
        finish_item(axi_seq);
        `uvm_info(get_name(), "Executed Read Sequence", UVM_NONE)

        end
    endtask: body
    
endclass: read_reg_seq




`endif