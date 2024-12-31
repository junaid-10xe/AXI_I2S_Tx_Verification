/*************************************************************************
   > File Name: i2s_tx_10xe_tb_top.sv
   > Description: This file defines the AXI-Stream interface signals and associated clocking blocks for I2S transmitter functionality.
   > Author: Muhammad Junaid Ramzan
   > Modified: Muhammad Junaid Ramzan
   > Mail: muhammad.junaid@10xengineers.ai
   ---------------------------------------------------------------
   Copyright   (c)2024 10xEngineers
   ---------------------------------------------------------------
************************************************************************/
`ifndef I2S_TX_10XE_TB_TOP
`define I2S_TX_10XE_TB_TOP
`timescale 1ns/1ns
// include the UVM macros
    `include "uvm_macros.svh"
// import the UVM library
  	import uvm_pkg::*;



    //Include Interface 
    `include "../UVC_AXI4_LITE/i2s_tx_10xe_axi4_lite_intf.sv"
    `include "../UVC_AXI_STREAM/i2s_tx_10xe_axi_stream_intf.sv"
    
    //Import AXI4-LITE UVC PKG to include files
    import i2s_tx_10xe_axi4_lite_pkg::*;
    //Import AXI-STream PKG to include files
    import i2s_tx_10xe_axis_pkg::*;
    //Import RAL PKG to include files
    // import i2s_tx_10xe_ral_pkg::*;
    `include "../UVM_RAL/i2s_tx_10xe_reg.sv"
    `include "../UVM_RAL/i2s_tx_10xe_reg_blk.sv"
    `include "../UVM_RAL/i2s_tx_10xe_adapter.sv"

    //Include files 
    `include "../env/i2s_tx_10xe_seq_item.sv"

    `include "../env/i2s_tx_10xe_env.sv"
    `include "../test_top/i2s_tx_10xe_base_test.sv"

 
module i2s_tx_10xe_tb_top;
    bit clk;
    bit rst;
    bit rst_n;
    bit m_clk;

    bit [31:0] CLK_PERIOD;
    bit [31:0] CLK_FREQ;

    //axi4 lite interface handle
    i2s_tx_10xe_axi4_lite_intf axi4_lite_intf(clk, rst_n);
    //axi stream interface handle
    i2s_tx_10xe_axi_stream_intf axis_intf(clk, rst_n);
    //Dut Interface handle
    i2s_tx_10xe_dut_intf dut_intf(m_clk, rst);


    //DUT instantiation 
i2s_transmitter_0 DUT (
  .s_axi_ctrl_aclk(axi4_lite_intf.s_axi_ctrl_aclk),        // input wire s_axi_ctrl_aclk
  .s_axi_ctrl_aresetn(axi4_lite_intf.s_axi_ctrl_aresetn),  // input wire s_axi_ctrl_aresetn
  .aud_mclk(dut_intf.aud_mclk),                      // input wire aud_mclk
  .aud_mrst(dut_intf.aud_mrst),                      // input wire aud_mrst
  .s_axis_aud_aclk(axis_intf.s_axis_aud_aclk),        // input wire s_axis_aud_aclk
  .s_axis_aud_aresetn(axis_intf.s_axis_aud_aresetn),  // input wire s_axis_aud_aresetn
  .s_axi_ctrl_awvalid(axi4_lite_intf.s_axi_ctrl_awvalid),  // input wire s_axi_ctrl_awvalid
  .s_axi_ctrl_awready(axi4_lite_intf.s_axi_ctrl_awready),  // output wire s_axi_ctrl_awready
  .s_axi_ctrl_awaddr(axi4_lite_intf.s_axi_ctrl_awaddr),    // input wire [7 : 0] s_axi_ctrl_awaddr
  .s_axi_ctrl_wvalid(axi4_lite_intf.s_axi_ctrl_wvalid),    // input wire s_axi_ctrl_wvalid
  .s_axi_ctrl_wready(axi4_lite_intf.s_axi_ctrl_wready),    // output wire s_axi_ctrl_wready
  .s_axi_ctrl_wdata(axi4_lite_intf.s_axi_ctrl_wdata),      // input wire [31 : 0] s_axi_ctrl_wdata
  .s_axi_ctrl_bvalid(axi4_lite_intf.s_axi_ctrl_bvalid),    // output wire s_axi_ctrl_bvalid
  .s_axi_ctrl_bready(axi4_lite_intf.s_axi_ctrl_bready),    // input wire s_axi_ctrl_bready
  .s_axi_ctrl_bresp(axi4_lite_intf.s_axi_ctrl_bresp),      // output wire [1 : 0] s_axi_ctrl_bresp
  .s_axi_ctrl_arvalid(axi4_lite_intf.s_axi_ctrl_arvalid),  // input wire s_axi_ctrl_arvalid
  .s_axi_ctrl_arready(axi4_lite_intf.s_axi_ctrl_arready),  // output wire s_axi_ctrl_arready
  .s_axi_ctrl_araddr(axi4_lite_intf.s_axi_ctrl_araddr),    // input wire [7 : 0] s_axi_ctrl_araddr
  .s_axi_ctrl_rvalid(axi4_lite_intf.s_axi_ctrl_rvalid),    // output wire s_axi_ctrl_rvalid
  .s_axi_ctrl_rready(axi4_lite_intf.s_axi_ctrl_rready),    // input wire s_axi_ctrl_rready
  .s_axi_ctrl_rdata(axi4_lite_intf.s_axi_ctrl_rdata),      // output wire [31 : 0] s_axi_ctrl_rdata
  .s_axi_ctrl_rresp(axi4_lite_intf.s_axi_ctrl_rresp),      // output wire [1 : 0] s_axi_ctrl_rresp
  .irq(dut_intf.irq),                                // output wire irq
  .lrclk_out(dut_intf.lrclk_out),                    // output wire lrclk_out
  .sclk_out(dut_intf.sclk_out),                      // output wire sclk_out
  .sdata_0_out(dut_intf.sdata_0_out),                // output wire sdata_0_out
  .s_axis_aud_tdata(axis_intf.s_axis_aud_tdata),      // input wire [31 : 0] s_axis_aud_tdata
  .s_axis_aud_tid(axis_intf.s_axis_aud_tid),          // input wire [2 : 0] s_axis_aud_tid
  .s_axis_aud_tvalid(axis_intf.s_axis_aud_tvalid),    // input wire s_axis_aud_tvalid
  .s_axis_aud_tready(axis_intf.s_axis_aud_tready)    // output wire s_axis_aud_tready
//   .fifo_wrdata_count(dut_intf.fifo_wrdata_count),
//   .fifo_rdata_count(dut_intf.fifo_rdata_count)
);

initial begin
    clk = 0;
    forever #10 clk = ~clk;
end

initial begin
    rst_n = 0;
    rst   = 1;
    #100;
    rst_n = 1;
    rst   = 0;
end

initial begin
    CLK_FREQ = 96;
    m_clk_gen();
end

task m_clk_gen ();
     CLK_PERIOD = 1/(CLK_FREQ*1000);
     forever #14 m_clk = ~m_clk;
endtask
//Set interfaces in config db and start test
initial begin
    `uvm_info("tb_top", "Setting Interfaces", UVM_NONE)
    uvm_config_db#(virtual i2s_tx_10xe_axi4_lite_intf) :: set(null, "*", "axi4_lite_vif", axi4_lite_intf);
    uvm_config_db#(virtual i2s_tx_10xe_axi_stream_intf):: set(null, "*", "axis_vif", axis_intf);
    uvm_config_db#(virtual i2s_tx_10xe_dut_intf) :: set(null, "*", "dut_vif", dut_intf);
    `uvm_info("tb_top", "Starting test", UVM_NONE)
    run_test("reset_reg_test");
end

initial begin 
    $dumpvars;
    $dumpfile("dump.vcd");
end

endmodule

`endif