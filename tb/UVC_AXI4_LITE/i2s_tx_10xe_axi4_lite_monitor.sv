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
`define MON_AX axi4_lite_vif.MONITOR.axi4_lite_monitor
//  Class: i2s_tx_10xe_axi4_lite_monitor
//
class i2s_tx_10xe_axi4_lite_monitor extends uvm_monitor;
    `uvm_component_utils(i2s_tx_10xe_axi4_lite_monitor);

   //Analysis Port
    uvm_analysis_port #(i2s_tx_10xe_axi4_lite_seq_item) axi_a_port;
    //Interface handle of axi4-lite
    virtual i2s_tx_10xe_axi4_lite_intf axi4_lite_vif;
    //Handle of transaction
    i2s_tx_10xe_axi4_lite_seq_item axi4_tr;
    //  Constructor: new
    function new(string name = "i2s_tx_10xe_axi4_lite_monitor", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    //  Build phase
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        axi_a_port = new("axi_a_port", this);
        axi4_tr    = i2s_tx_10xe_axi4_lite_seq_item::type_id::create("axi4_tr", this);
        if(!uvm_config_db#(virtual i2s_tx_10xe_axi4_lite_intf)::get(this, "*", "axi4_lite_vif", axi4_lite_vif)) begin
            `uvm_fatal(get_name(), "Failed to get AXI4-Lite Interface from Config DB")
        end
    endfunction: build_phase
    
    //run phase to monitor signals
    task run_phase(uvm_phase phase);
       forever begin
            
            repeat(2) @(posedge axi4_lite_vif.s_axi_ctrl_aclk);
                //For address write channel
              axi4_tr.s_axi_ctrl_awaddr     = `MON_AX.s_axi_ctrl_awaddr;
              axi4_tr.s_axi_ctrl_awvalid    = `MON_AX.s_axi_ctrl_awvalid;
              axi4_tr.s_axi_ctrl_awready    = `MON_AX.s_axi_ctrl_awready;
              `uvm_info(get_name(), $sformatf("Address Write Channel: AWADDR = %h, AWVALID = %b, AWREADY = %b", 
                axi4_tr.s_axi_ctrl_awaddr, axi4_tr.s_axi_ctrl_awvalid, axi4_tr.s_axi_ctrl_awready), UVM_DEBUG);
              
            //For data write channel
              axi4_tr.s_axi_ctrl_wdata      = `MON_AX.s_axi_ctrl_wdata;
              axi4_tr.s_axi_ctrl_wvalid     = `MON_AX.s_axi_ctrl_wvalid; 
              axi4_tr.s_axi_ctrl_wready     = `MON_AX.s_axi_ctrl_wready;
              `uvm_info(get_name(), $sformatf("Data Write Channel: WDATA = %h, WVALID = %b, WREADY = %b", 
                axi4_tr.s_axi_ctrl_wdata, axi4_tr.s_axi_ctrl_wvalid, axi4_tr.s_axi_ctrl_wready), UVM_DEBUG);

            //For write response channel
              axi4_tr.s_axi_ctrl_bready     = `MON_AX.s_axi_ctrl_bready;
              axi4_tr.s_axi_ctrl_bresp      = `MON_AX.s_axi_ctrl_bresp;
              axi4_tr.s_axi_ctrl_bvalid     = `MON_AX.s_axi_ctrl_bvalid;
              `uvm_info(get_name(), $sformatf("Write Response Channel: BREADY = %b, BRESP = %b, BVALID = %b", 
                axi4_tr.s_axi_ctrl_bready, axi4_tr.s_axi_ctrl_bresp, axi4_tr.s_axi_ctrl_bvalid), UVM_DEBUG);

            //For read address channel
              axi4_tr.s_axi_ctrl_araddr     = `MON_AX.s_axi_ctrl_araddr;
              axi4_tr.s_axi_ctrl_arvalid    = `MON_AX.s_axi_ctrl_arvalid;
              axi4_tr.s_axi_ctrl_arready    = `MON_AX.s_axi_ctrl_arready;
              `uvm_info(get_name(), $sformatf("Read Address Channel: ARADDR = %h, ARVALID = %b, ARREADY = %b", 
                axi4_tr.s_axi_ctrl_araddr, axi4_tr.s_axi_ctrl_arvalid, axi4_tr.s_axi_ctrl_arready), UVM_DEBUG);

            //For read data channel
              axi4_tr.s_axi_ctrl_rready     = `MON_AX.s_axi_ctrl_rready;
              axi4_tr.s_axi_ctrl_rdata      = `MON_AX.s_axi_ctrl_rdata;
              axi4_tr.s_axi_ctrl_rresp      = `MON_AX.s_axi_ctrl_rresp;
              axi4_tr.s_axi_ctrl_rvalid     = `MON_AX.s_axi_ctrl_rvalid;
              `uvm_info(get_name(), $sformatf("Read Data Channel: RREADY = %b, RDATA = %h, RRESP = %b, RVALID = %b", 
                axi4_tr.s_axi_ctrl_rready, axi4_tr.s_axi_ctrl_rdata, axi4_tr.s_axi_ctrl_rresp, axi4_tr.s_axi_ctrl_rvalid), UVM_DEBUG);
              
            //Broadcast data to analysis port
              axi_a_port.write(axi4_tr);
              `uvm_info(get_name(), $sformatf("Printing transaction in AXI4-Lite Monitor: \n%s", axi4_tr.sprint()), UVM_LOW);
       end
    endtask: run_phase
endclass: i2s_tx_10xe_axi4_lite_monitor

`endif