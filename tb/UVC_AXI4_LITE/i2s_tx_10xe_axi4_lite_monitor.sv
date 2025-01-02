/*************************************************************************
   > File Name: i2s_tx_10xe_axi4_lite_monitor.sv
   > Description: This file Monitors the signals from dut using axi4-lite specifications.
   > Author: Muhammad Junaid Ramzan
   > Modified: Muhammad Junaid Ramzan
   > Mail: muhammad.junaid@10xengineers.ai
   ---------------------------------------------------------------
   Copyright   (c)2024 10xEngineers
   ---------------------------------------------------------------
************************************************************************/
`ifndef I2S_TX_10XE_AXI4_LITE_MONITOR
`define I2S_TX_10XE_AXI4_LITE_MONITOR
`define MON_AX axi4_lite_vif.axi4_lite_monitor
//  Class: i2s_tx_10xe_axi4_lite_monitor
class i2s_tx_10xe_axi4_lite_monitor extends uvm_monitor;
    `uvm_component_utils(i2s_tx_10xe_axi4_lite_monitor);

    uvm_analysis_port #(i2s_tx_10xe_axi4_lite_seq_item) axi_a_port;   // Analysis Port
    virtual i2s_tx_10xe_axi4_lite_intf axi4_lite_vif;                 // Interface handle of axi4-lite
    i2s_tx_10xe_axi4_lite_seq_item axi4_tr;                           // Handle of transaction
    
    // Constructor: new
    function new(string name = "i2s_tx_10xe_axi4_lite_monitor", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    // Build phase
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        axi_a_port = new("axi_a_port", this);
        axi4_tr    = i2s_tx_10xe_axi4_lite_seq_item::type_id::create("axi4_tr", this);
        if(!uvm_config_db#(virtual i2s_tx_10xe_axi4_lite_intf)::get(this, "*", "axi4_lite_vif", axi4_lite_vif)) begin
            `uvm_fatal(get_name(), "Failed to get AXI4-Lite Interface from Config DB")
        end
    endfunction: build_phase
    
    // run phase to monitor signals
    task run_phase(uvm_phase phase);
      wait(axi4_lite_vif.s_axi_ctrl_aresetn);
       forever begin
            
            repeat(1) @(posedge axi4_lite_vif.s_axi_ctrl_aclk);
              // For address write channel
              axi4_tr.s_axi_ctrl_awaddr     = `MON_AX.s_axi_ctrl_awaddr;
              axi4_tr.s_axi_ctrl_awvalid    = `MON_AX.s_axi_ctrl_awvalid;
              axi4_tr.s_axi_ctrl_awready    = `MON_AX.s_axi_ctrl_awready;
              
              // For data write channel
              axi4_tr.s_axi_ctrl_wdata      = `MON_AX.s_axi_ctrl_wdata;
              axi4_tr.s_axi_ctrl_wvalid     = `MON_AX.s_axi_ctrl_wvalid; 
              axi4_tr.s_axi_ctrl_wready     = `MON_AX.s_axi_ctrl_wready;
             
              // For write response channel
              axi4_tr.s_axi_ctrl_bready     = `MON_AX.s_axi_ctrl_bready;
              axi4_tr.s_axi_ctrl_bresp      = `MON_AX.s_axi_ctrl_bresp;
              axi4_tr.s_axi_ctrl_bvalid     = `MON_AX.s_axi_ctrl_bvalid;
              
              // For read address channel
              axi4_tr.s_axi_ctrl_araddr     = `MON_AX.s_axi_ctrl_araddr;
              axi4_tr.s_axi_ctrl_arvalid    = `MON_AX.s_axi_ctrl_arvalid;
              axi4_tr.s_axi_ctrl_arready    = `MON_AX.s_axi_ctrl_arready;
              
              // For read data channel
              axi4_tr.s_axi_ctrl_rready     = `MON_AX.s_axi_ctrl_rready;
              axi4_tr.s_axi_ctrl_rdata      = `MON_AX.s_axi_ctrl_rdata;
              axi4_tr.s_axi_ctrl_rresp      = `MON_AX.s_axi_ctrl_rresp;
              axi4_tr.s_axi_ctrl_rvalid     = `MON_AX.s_axi_ctrl_rvalid;
              
              // Broadcast Transaction to analysis port
              axi_a_port.write(axi4_tr);
              `uvm_info(get_name(), $sformatf("Printing transaction in AXI4-Lite Monitor: \n%s", axi4_tr.sprint()), UVM_HIGH);
          end
    endtask: run_phase
endclass: i2s_tx_10xe_axi4_lite_monitor

`endif