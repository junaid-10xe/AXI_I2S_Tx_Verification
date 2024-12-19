/*************************************************************************
   > File Name: i2s_tx_10xe_axis_monitor.sv
   > Description: This file Monitors the signals from dut using axi-Stream specifications.
   > Author: Muhammad Junaid Ramzan
   > Modified: Muhammad Junaid Ramzan
   > Mail: muhammad.junaid@10xengineers.ai
   ---------------------------------------------------------------
   Copyright   (c)2024 10xEngineers
   ---------------------------------------------------------------
************************************************************************/
`ifndef I2S_TX_10XE_AXIS_MONITOR
`define I2S_TX_10XE_AXIS_MONITOR
`define MON_AXS axis_vif.MONITOR.axi_stream_monitor
//  Class: i2s_tx_10xe_axis_monitor
//
class i2s_tx_10xe_axis_monitor extends uvm_monitor;
    `uvm_component_utils(i2s_tx_10xe_axis_monitor);

   //Analysis Port
    uvm_analysis_port #(i2s_tx_10xe_seq_item) axis_a_port;
    //Interface handle of axi4-lite
    virtual i2s_tx_10xe_axis_intf axis_vif;
    //Handle of transaction
    i2s_tx_10xe_seq_item axis_tr;
    //  Constructor: new
    function new(string name = "i2s_tx_10xe_axis_monitor", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    //  Build phase
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        axis_a_port = new("axis_a_port", this);
        axis_tr    = i2s_tx_10xe_seq_item::type_id::create("axis_tr", this);
        if(!uvm_config_db#(virtual i2s_tx_10xe_axi_stream_intf)::get(this, "*", "axis_vif", axis_vif)) begin
            `uvm_fatal(get_name(), "Failed to get AXI-Stream Interface from Config DB")
        end
    endfunction: build_phase
    
    //run phase to monitor signals
    task run_phase(uvm_phase phase);
       forever begin
            
            
            repeat(2) @(posedge axis_vif.s_axis_aud_aclk);
                //For address write channel
              axi4_tr.s_axi_ctrl_awaddr     = `MON_AXS.s_axi_ctrl_awaddr;
              axi4_tr.s_axi_ctrl_awvalid    = `MON_AXS.s_axi_ctrl_awvalid;
              axi4_tr.s_axi_ctrl_awready    = `MON_AXS.s_axi_ctrl_awready;
            //For data write channel
              axi4_tr.s_axi_ctrl_wdata      = `MON_AXS.s_axi_ctrl_wdata;
              axi4_tr.s_axi_ctrl_wvalid     = `MON_AXS.s_axi_ctrl_wvalid; 
              axi4_tr.s_axi_ctrl_wready     = `MON_AXS.s_axi_ctrl_wready;
            //For write response channel
              axi4_tr.s_axi_ctrl_bready     = `MON_AXS.s_axi_ctrl_bready;
              axi4_tr.s_axi_ctrl_bresp      = `MON_AXS.s_axi_ctrl_bresp;
              axi4_tr.s_axi_ctrl_bvalid     = `MON_AXS.s_axi_ctrl_bvalid;
            //For read address channel
              axi4_tr.s_axi_ctrl_araddr     = `MON_AXS.s_axi_ctrl_araddr;
              axi4_tr.s_axi_ctrl_arvalid    = `MON_AXS.s_axi_ctrl_arvalid;
              axi4_tr.s_axi_ctrl_arready    = `MON_AXS.s_axi_ctrl_arready;
            //For read data channel
              axi4_tr.s_axi_ctrl_rready     = `MON_AXS.s_axi_ctrl_rready;
              axi4_tr.s_axi_ctrl_rdata      = `MON_AXS.s_axi_ctrl_rdata;
              axi4_tr.s_axi_ctrl_rresp      = `MON_AXS.s_axi_ctrl_rresp;
              axi4_tr.s_axi_ctrl_rvalid     = `MON_AXS.s_axi_ctrl_rvalid;
            //Broadcast data to analysis port
              axi_a_port.write(axi4_tr);
              `uvm_info(get_name(),$sformatf(" Printing transaction in AXI4-Lite Monitor, \n  %s",axi4_tr.sprint()),UVM_LOW)
       end
    endtask: run_phase
    

    
    
endclass: i2s_tx_10xe_axis_monitor

`endif