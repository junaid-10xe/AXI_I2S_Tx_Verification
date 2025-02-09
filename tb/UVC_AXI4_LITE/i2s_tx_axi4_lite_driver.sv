/*************************************************************************
   > File Name: i2s_tx_axi4_lite_driver.sv
   > Description: This file drives the signals to DUT using AXI4-Lite specifications.
   > Author: Muhammad Junaid Ramzan
   > Modified: Muhammad Junaid Ramzan
   > Mail: muhammad.junaid@10xengineers.ai
   ---------------------------------------------------------------
   Copyright   (c)2024 10xEngineers
   ---------------------------------------------------------------
************************************************************************/
`ifndef I2S_TX_AXI4_LITE_DRIVER
`define I2S_TX_AXI4_LITE_DRIVER
`define DRV_AX axi4_lite_vif.axi4_lite_driver

// Class: i2s_tx_axi4_lite_driver
// This driver class handles the AXI4-Lite transactions, sending write and read operations to the DUT using the AXI4-Lite interface.
class i2s_tx_axi4_lite_driver extends uvm_driver #(i2s_tx_axi4_lite_seq_item);
    `uvm_component_utils(i2s_tx_axi4_lite_driver)

    
    // Handle for configuration Class
    i2s_tx_config       cfg;                          // Configuration handle

    // Constructor: Initializes the driver component with the given name and parent.
    function new(string name = "i2s_tx_axi4_lite_driver", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    // Virtual interface handle for AXI4-Lite
    virtual i2s_tx_axi4_lite_intf       axi4_lite_vif;           // AXI4-Lite interface to the DUT

    // Build Phase: Retrieves the AXI4-Lite virtual interface from the configuration database.
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        // Get AXI4-Lite interface from the configuration database
        if(!uvm_config_db#(virtual i2s_tx_axi4_lite_intf)::get(this, "*", "axi4_lite_vif", axi4_lite_vif)) begin
            `uvm_fatal(get_name(), "Failed to get AXI4-Lite Interface from Config DB")
        end
        // Get the configuration handle from the configuration database
        if(!uvm_config_db#(i2s_tx_config)::get(this, "*", "cfg", cfg)) begin
            `uvm_fatal(get_name(), "Failed to get Configuration from Config DB")
        end
    endfunction: build_phase
    
    // Run Phase: Executes the transaction by calling write and read tasks in parallel.
    task run_phase(uvm_phase phase);
        wait(axi4_lite_vif.s_axi_ctrl_aresetn);
        forever begin
            i2s_tx_axi4_lite_seq_item           req;                     // Transaction handle
            i2s_tx_axi4_lite_seq_item           rsp;                     // Transaction handle
            // Get next transaction item from sequencer
            seq_item_port.get_next_item(rsp);
            // Fork two tasks: write and read to the DUT
            fork
                write(rsp);
                read(rsp);
            join
            // Mark the item as completed
            seq_item_port.item_done();
        end
        
    endtask: run_phase

    // Write task: Sends a write operation to the DUT using the AXI4-Lite
    task write(input i2s_tx_axi4_lite_seq_item axi4_tr);
        `uvm_info(get_name(), "Starting Write Task...", UVM_HIGH)
            `uvm_info(get_name(), "Before Address Channel...", UVM_DEBUG)

            @(posedge axi4_lite_vif.s_axi_ctrl_aclk);
            //Write Address Channel
            `DRV_AX.s_axi_ctrl_awvalid <= axi4_tr.s_axi_ctrl_awvalid;
            `DRV_AX.s_axi_ctrl_awaddr  <= axi4_tr.s_axi_ctrl_awaddr;
            `uvm_info(get_name(), "After Address Channel...", UVM_DEBUG)
        if (axi4_tr.s_axi_ctrl_awvalid) begin

            wait(`DRV_AX.s_axi_ctrl_awready);  
            // Check if AWVALID is set for address write
            // Wait for AWREADY signal (acknowledgment from DUT)
            @(posedge axi4_lite_vif.s_axi_ctrl_aclk);
            `DRV_AX.s_axi_ctrl_awvalid <= 0;
            //Write DATA Channel
            `uvm_info(get_name(), "BEFORE DATA Channel...", UVM_DEBUG)
            `DRV_AX.s_axi_ctrl_wvalid  <= axi4_tr.s_axi_ctrl_wvalid;
            `DRV_AX.s_axi_ctrl_wdata   <= axi4_tr.s_axi_ctrl_wdata;
            // Wait for WREADY (acknowledgment from DUT)
            if (axi4_tr.s_axi_ctrl_wvalid) begin

                wait(`DRV_AX.s_axi_ctrl_wready);
                `uvm_info(get_name(), "After DATA Channel...", UVM_DEBUG)
                // Wait for BVALID (acknowledgment from DUT)
                wait(`DRV_AX.s_axi_ctrl_bvalid);
                `DRV_AX.s_axi_ctrl_bready  <= 1;
                axi4_tr.s_axi_ctrl_bvalid   = `DRV_AX.s_axi_ctrl_bvalid;
                axi4_tr.s_axi_ctrl_bresp    = `DRV_AX.s_axi_ctrl_bresp;
                @(posedge axi4_lite_vif.s_axi_ctrl_aclk);
                `DRV_AX.s_axi_ctrl_bready  <= 0;
                `DRV_AX.s_axi_ctrl_wvalid  <= 0;  
                `uvm_info(get_name(), "After RESP Channel...", UVM_DEBUG)
                `uvm_info(get_name(), $sformatf("Data Driven to DUT IN WRITE, \n%s", axi4_tr.sprint()), UVM_HIGH);               
            end
        end
        `uvm_info(get_name(), "Leaving Write Task...", UVM_HIGH)

        
    endtask: write

    // Read task: Sends a read operation to the DUT using the AXI4-Lit
    task read(input i2s_tx_axi4_lite_seq_item axi4_tr);
        `uvm_info(get_name(), "Starting Read Task...", UVM_HIGH)
        // Read Address Channel
        // Drive the read address signal (ARADDR)
            @(posedge axi4_lite_vif.s_axi_ctrl_aclk);
            `DRV_AX.s_axi_ctrl_araddr  <= axi4_tr.s_axi_ctrl_araddr;
            `DRV_AX.s_axi_ctrl_arvalid <= axi4_tr.s_axi_ctrl_arvalid;
            // Wait for ARREADY (acknowledgment from DUT)
        if (axi4_tr.s_axi_ctrl_arvalid) begin
            wait(`DRV_AX.s_axi_ctrl_arready);  
            @(posedge axi4_lite_vif.s_axi_ctrl_aclk);
            `DRV_AX.s_axi_ctrl_arvalid <= 0;
            //Read Data Channel
            `DRV_AX.s_axi_ctrl_rready <= axi4_tr.s_axi_ctrl_rready;
            // Wait for RVALID signal indicating data is ready
            if (axi4_tr.s_axi_ctrl_rready) begin

                wait(`DRV_AX.s_axi_ctrl_rvalid);
                axi4_tr.s_axi_ctrl_rdata    = `DRV_AX.s_axi_ctrl_rdata; // Capture read data
                axi4_tr.s_axi_ctrl_rvalid   = `DRV_AX.s_axi_ctrl_rvalid;
                axi4_tr.s_axi_ctrl_rresp    = `DRV_AX.s_axi_ctrl_rresp;
                `DRV_AX.s_axi_ctrl_rready   <= 0;
                `uvm_info(get_name(), $sformatf("Data Driven to DUT IN READ, \n%s", axi4_tr.sprint()), UVM_HIGH);               
            end
        end 
        `uvm_info(get_name(), "Leaving Read Task...", UVM_HIGH)


    endtask: read

endclass : i2s_tx_axi4_lite_driver

`endif