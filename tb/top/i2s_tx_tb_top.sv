/*************************************************************************
   > File Name: i2s_tx_tb_top.sv
   > Description: This file defines the AXI-Stream interface signals and associated clocking blocks for I2S transmitter functionality.
   > Author: Muhammad Junaid Ramzan
   > Modified: Muhammad Junaid Ramzan
   > Mail: muhammad.junaid@10xengineers.ai
   ---------------------------------------------------------------
   Copyright   (c)2024 10xEngineers
   ---------------------------------------------------------------
************************************************************************/
`ifndef I2S_TX_TB_TOP
`define I2S_TX_TB_TOP
    `timescale 1ns/1ns
    // include the UVM macros
    `include "uvm_macros.svh"
    // import the UVM library
  	import uvm_pkg::*;

    // Import defines
    import i2s_tx_defines::*;
    // Include Interfaces
    `include "../UVC_AXI4_LITE/i2s_tx_axi4_lite_intf.sv"
    `include "../UVC_AXI_STREAM/i2s_tx_axi_stream_intf.sv"
    `include "../I2S_RSP_AGENT/i2s_tx_intf.sv"

    
    // Import AXI4-LITE UVC PKG to include files
    import i2s_tx_axi4_lite_pkg::*;
    
    // Import AXI-STream PKG to include files
    import i2s_tx_axis_pkg::*;
    // Import DUT PKG to include files
    import i2s_tx_rsp_pkg::*;
    
    // Include files
    `include "../scoreboard/i2s_tx_scoreboard.sv"
    `include "../env/i2s_tx_env.sv"
    `include "../test_top/i2s_tx_base_test.sv"
    `include "../test_top/i2s_tx_tests_lib.sv"

 
module i2s_tx_tb_top;

    // axi4 lite interface handle
    i2s_tx_axi4_lite_intf axi4_lite_intf();
    // axi stream interface handle
    i2s_tx_axi_stream_intf axis_intf();
    // Dut Interface handle
    i2s_tx_intf i2s_intf();


    // DUT instantiation 
i2s_transmitter_0 DUT (
  .s_axi_ctrl_aclk(axi4_lite_intf.s_axi_ctrl_aclk),         // input wire s_axi_ctrl_aclk
  .s_axi_ctrl_aresetn(axi4_lite_intf.s_axi_ctrl_aresetn),   // input wire s_axi_ctrl_aresetn
  .aud_mclk(i2s_intf.aud_mclk),                             // input wire aud_mclk
  .aud_mrst(i2s_intf.aud_mrst),                             // input wire aud_mrst
  .s_axis_aud_aclk(axis_intf.s_axis_aud_aclk),              // input wire s_axis_aud_aclk
  .s_axis_aud_aresetn(axis_intf.s_axis_aud_aresetn),        // input wire s_axis_aud_aresetn
  .s_axi_ctrl_awvalid(axi4_lite_intf.s_axi_ctrl_awvalid),   // input wire s_axi_ctrl_awvalid
  .s_axi_ctrl_awready(axi4_lite_intf.s_axi_ctrl_awready),   // output wire s_axi_ctrl_awready
  .s_axi_ctrl_awaddr(axi4_lite_intf.s_axi_ctrl_awaddr),     // input wire [7 : 0] s_axi_ctrl_awaddr
  .s_axi_ctrl_wvalid(axi4_lite_intf.s_axi_ctrl_wvalid),     // input wire s_axi_ctrl_wvalid
  .s_axi_ctrl_wready(axi4_lite_intf.s_axi_ctrl_wready),     // output wire s_axi_ctrl_wready
  .s_axi_ctrl_wdata(axi4_lite_intf.s_axi_ctrl_wdata),       // input wire [31 : 0] s_axi_ctrl_wdata
  .s_axi_ctrl_bvalid(axi4_lite_intf.s_axi_ctrl_bvalid),     // output wire s_axi_ctrl_bvalid
  .s_axi_ctrl_bready(axi4_lite_intf.s_axi_ctrl_bready),     // input wire s_axi_ctrl_bready
  .s_axi_ctrl_bresp(axi4_lite_intf.s_axi_ctrl_bresp),       // output wire [1 : 0] s_axi_ctrl_bresp
  .s_axi_ctrl_arvalid(axi4_lite_intf.s_axi_ctrl_arvalid),   // input wire s_axi_ctrl_arvalid
  .s_axi_ctrl_arready(axi4_lite_intf.s_axi_ctrl_arready),   // output wire s_axi_ctrl_arready
  .s_axi_ctrl_araddr(axi4_lite_intf.s_axi_ctrl_araddr),     // input wire [7 : 0] s_axi_ctrl_araddr
  .s_axi_ctrl_rvalid(axi4_lite_intf.s_axi_ctrl_rvalid),     // output wire s_axi_ctrl_rvalid
  .s_axi_ctrl_rready(axi4_lite_intf.s_axi_ctrl_rready),     // input wire s_axi_ctrl_rready
  .s_axi_ctrl_rdata(axi4_lite_intf.s_axi_ctrl_rdata),       // output wire [31 : 0] s_axi_ctrl_rdata
  .s_axi_ctrl_rresp(axi4_lite_intf.s_axi_ctrl_rresp),       // output wire [1 : 0] s_axi_ctrl_rresp
  .irq(i2s_intf.irq),                                       // output wire irq
  .lrclk_out(i2s_intf.lrclk_out),                           // output wire lrclk_out
  .sclk_out(i2s_intf.sclk_out),                             // output wire sclk_out
  .sdata_0_out(i2s_intf.sdata_0_out),                       // output wire sdata_0_out
  .s_axis_aud_tdata(axis_intf.s_axis_aud_tdata),            // input wire [31 : 0] s_axis_aud_tdata
  .s_axis_aud_tid(axis_intf.s_axis_aud_tid),                // input wire [2 : 0] s_axis_aud_tid
  .s_axis_aud_tvalid(axis_intf.s_axis_aud_tvalid),          // input wire s_axis_aud_tvalid
  .s_axis_aud_tready(axis_intf.s_axis_aud_tready),           // output wire s_axis_aud_tready
  .fifo_wrdata_count(i2s_intf.fifo_wrdata_count),
  .fifo_rdata_count(i2s_intf.fifo_rdata_count)
);

// Set interfaces in config db and start test
initial begin
    `uvm_info("tb_top", "Setting Interfaces", UVM_NONE)
    uvm_config_db#(virtual i2s_tx_axi4_lite_intf) :: set(null, "*", "axi4_lite_vif", axi4_lite_intf);
    uvm_config_db#(virtual i2s_tx_axi_stream_intf):: set(null, "*", "axis_vif", axis_intf);
    uvm_config_db#(virtual i2s_tx_intf) :: set(null, "*", "i2s_vif", i2s_intf);
    `uvm_info("tb_top", "Starting test", UVM_NONE)
    run_test("sanity_test");
end


// Dump waveform
initial begin 
    $dumpvars;
    $dumpfile("dump.vcd");
end

endmodule
`endif