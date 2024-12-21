/*************************************************************************
   > File Name: i2s_tx_10xe_axi4_lite_driver.sv
   > Description: This file drives the signals to DUT using AXI4-Lite specifications.
   > Author: Muhammad Junaid Ramzan
   > Modified: Muhammad Junaid Ramzan
   > Mail: muhammad.junaid@10xengineers.ai
   ---------------------------------------------------------------
   Copyright   (c)2024 10xEngineers
   ---------------------------------------------------------------
************************************************************************/
`ifndef I2S_TX_10XE_AXI4_LITE_DRIVER
`define I2S_TX_10XE_AXI4_LITE_DRIVER
`define DRV_AX axi4_lite_vif.DRIVER.axi4_lite_driver

// Class: i2s_tx_10xe_axi4_lite_driver
// This driver class handles the AXI4-Lite transactions, sending write and read operations to the DUT using the AXI4-Lite interface.
class i2s_tx_10xe_axi4_lite_driver extends uvm_driver #(i2s_tx_10xe_axi4_lite_seq_item);
    `uvm_component_utils(i2s_tx_10xe_axi4_lite_driver)

    // Transaction handle
    i2s_tx_10xe_axi4_lite_seq_item axi4_tr;

    // Constructor: Initializes the driver component with the given name and parent.
    function new(string name = "i2s_tx_10xe_axi4_lite_driver", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    // Virtual interface handle for AXI4-Lite
    virtual i2s_tx_10xe_axi4_lite_intf axi4_lite_vif;           // AXI4-Lite interface to the DUT

    // Build Phase: Retrieves the AXI4-Lite virtual interface from the configuration database.
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        // Get AXI4-Lite interface from the configuration database
        if(!uvm_config_db#(virtual i2s_tx_10xe_axi4_lite_intf)::get(this, "*", "axi4_lite_vif", axi4_lite_vif)) begin
            `uvm_fatal(get_name(), "Failed to get AXI4-Lite Interface from Config DB")
        end
    endfunction: build_phase
    
    // Run Phase: Executes the transaction by calling write and read tasks in parallel.
    task run_phase(uvm_phase phase);
        forever begin
            // Get next transaction item from sequencer
            seq_item_port.get_next_item(axi4_tr);
            // Fork two tasks: write and read to the DUT
            fork
                write();
                read();
            join

            // Log the transaction data sent to the DUT
            `uvm_info(get_name(), $sformatf("Data Driven to DUT from AXI4-Lite Driver, \n%s", axi4_tr.sprint()), UVM_LOW)
            // Mark the item as completed
            seq_item_port.item_done();
        end
    endtask: run_phase

    // Task: Write operation for AXI4-Lite signals
    task write();
        `uvm_info(get_name(), "Starting Write Task...", UVM_DEBUG)

        // Drive the write address signal (AWADDR)
        `DRV_AX.s_axi_ctrl_awaddr  <= axi4_tr.s_axi_ctrl_awaddr;
        // Check if AWVALID is set for address write
        if (axi4_tr.s_axi_ctrl_awvalid) begin
            @(posedge axi4_lite_vif.s_axi_ctrl_aclk)
            `DRV_AX.s_axi_ctrl_awvalid <= axi4_tr.s_axi_ctrl_awvalid;
            // Wait for AWREADY signal (acknowledgment from DUT)
            wait(`DRV_AX.s_axi_ctrl_awready);  
            `uvm_info(get_name(), $sformatf("Write Address Handshake: AWADDR = %h, AWVALID = %b, AWREADY = %b", 
                axi4_tr.s_axi_ctrl_awaddr, axi4_tr.s_axi_ctrl_awvalid, `DRV_AX.s_axi_ctrl_awready), UVM_DEBUG)

            // If WVALID is set, write the data
            if (axi4_tr.s_axi_ctrl_wvalid) begin
                @(posedge axi4_lite_vif.s_axi_ctrl_aclk)
                `DRV_AX.s_axi_ctrl_wvalid  <= axi4_tr.s_axi_ctrl_wvalid;
                // Wait for WREADY (acknowledgment from DUT)
                wait(`DRV_AX.s_axi_ctrl_wready);  
                `DRV_AX.s_axi_ctrl_wdata <= axi4_tr.s_axi_ctrl_wdata;
                `uvm_info(get_name(), $sformatf("Write Data Channel: WVALID = %b, WDATA = %h", 
                    axi4_tr.s_axi_ctrl_wvalid, axi4_tr.s_axi_ctrl_wdata), UVM_DEBUG)
            end
            // Set the write response ready (BREADY)
            `DRV_AX.s_axi_ctrl_bready  <= axi4_tr.s_axi_ctrl_bready;
        end
    endtask: write

    // Task: Read operation for AXI4-Lite signals
    task read();
        `uvm_info(get_name(), "Starting Read Task...", UVM_DEBUG)

        // Drive the read address signal (ARADDR)
        `DRV_AX.s_axi_ctrl_araddr <= axi4_tr.s_axi_ctrl_araddr;
        // If ARVALID is set, start read operation
        if (axi4_tr.s_axi_ctrl_arvalid) begin
            @(posedge axi4_lite_vif.s_axi_ctrl_aclk)
            `DRV_AX.s_axi_ctrl_arvalid <= axi4_tr.s_axi_ctrl_arvalid;
            // Wait for ARREADY (acknowledgment from DUT)
            wait(`DRV_AX.s_axi_ctrl_arready);  
            `uvm_info(get_name(), $sformatf("Read Address Handshake: ARADDR = %h, ARVALID = %b, ARREADY = %b", 
                axi4_tr.s_axi_ctrl_araddr, axi4_tr.s_axi_ctrl_arvalid, `DRV_AX.s_axi_ctrl_arready), UVM_DEBUG)

            // Wait for RVALID signal indicating data is ready
            wait(`DRV_AX.s_axi_ctrl_rvalid);
            // If RREADY is set, complete the read operation
            if(axi4_tr.s_axi_ctrl_rready) begin
                @(posedge axi4_lite_vif.s_axi_ctrl_aclk)                 
                `DRV_AX.s_axi_ctrl_rready <= axi4_tr.s_axi_ctrl_rready;
                `uvm_info(get_name(), $sformatf("Read Data Channel: RREADY = %b", axi4_tr.s_axi_ctrl_rready), UVM_DEBUG)
            end
        end    
    endtask: read

endclass : i2s_tx_10xe_axi4_lite_driver

`endif