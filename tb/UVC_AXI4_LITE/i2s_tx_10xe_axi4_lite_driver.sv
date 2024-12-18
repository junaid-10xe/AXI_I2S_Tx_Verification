/*************************************************************************
   > File Name: i2s_tx_10xe_axi4_lite_driver.sv
   > Description: This file drives the signals to dut using axi4-lite specifications.
   > Author: Muhammad Junaid Ramzan
   > Modified: Muhammad Junaid Ramzan
   > Mail: muhammad.junaid@10xengineers.ai
   ---------------------------------------------------------------
   Copyright   (c)2024 10xEngineers
   ---------------------------------------------------------------
************************************************************************/
`ifndef I2S_TX_10XE_AXI4_LITE_DRIVER
`define I2S_TX_10XE_AXI4_LITE_DRIVER
`define DR_AX axi4_lite_vif.DRIVER.axi4_lite_driver

class i2s_tx_10xe_axi4_lite_driver extends uvm_driver #(i2s_tx_10xe_seq_item);
    `uvm_component_utils(i2s_tx_10xe_axi4_lite_driver)

    //Constructor 
    function new(string name = "i2s_tx_10xe_axi4_lite_driver", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    i2s_tx_10xe_axi4_lite_intf axi4_lite_vif;           //Interface handle of axi4-Lite

    //Build Phase

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(virtual i2s_tx_10xe_axi4_lite_intf)::get(this, "*", "axi4_lite_vif", axi4_lite_vif)) begin
            `uvm_fatal(get_name(), "Failed to get AXI4-Lite Interface from Config DB")
        end
    endfunction: build_phase
    
    //Run phase to drive signals to DUT
    task run_phase(uvm_phase phase);
        forever begin
            i2s_tx_10xe_seq_item axi4_tr;
            seq_item_port.get_next_item(axi4_tr);
            fork
                write();
                read();
            join
            seq_item_port.item_done();
        end
    endtask: run_phase

    //task to drive signals for write
    task write();
        DR_AX.s_axi_ctrl_awaddr  <= axi4_tr.s_axi_ctrl_awaddr;      //For Address channel
        if (axi4_tr.s_axi_ctrl_awvalid) begin
            DR_AX.s_axi_ctrl_awvalid <= axi4_tr.s_axi_ctrl_awvalid;
            wait(DR_AX.s_axi_ctrl_awready);                         //Wait to complete handshake
            if (axi4_tr.s_axi_ctrl_wvalid) begin                    //For Write data channel
                DR_AX.s_axi_ctrl_wvalid  <= axi4_tr.s_axi_ctrl_wvalid;
                wait(DR_AX.s_axi_ctrl_wready);                      //Wait to complete Handshake
                DR_AX.s_axi_ctrl_wdata <= axi4_tr.s_axi_ctrl_wdata;
            end
            DR_AX.s_axi_ctrl_bready  <= axi4_tr.s_axi_ctrl_bready;
        end
    endtask

    //task to drive signals for read
    task read();
        DR_AX.s_axi_ctrl_araddr <= axi4_tr.s_axi_ctrl_araddr; //For read address channel
        if (axi4_tr.s_axi_ctrl_arvalid) begin                 //Drive further if valid
            DR_AX.s_axi_ctrl_arvalid <= axi4_tr.s_axi_ctrl_arvalid;
            wait(DR_AX.s_axi_ctrl_arready);                     //wait for ready to complete handshake
            if(axi4_tr.s_axi_ctrl_rready) begin                 
                DR_AX.s_axi_ctrl_rready <= axi4_tr.s_axi_ctrl_rready;
            end

        end    
    endtask


endclass : i2s_tx_10xe_axi4_lite_driver

`endif