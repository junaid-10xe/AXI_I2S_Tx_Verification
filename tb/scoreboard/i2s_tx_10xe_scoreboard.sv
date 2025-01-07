/*************************************************************************
   > File Name: i2s_tx_10xe_scoreboard.sv
   > Description: This file defines scoreboard class to recieve responses from monitors and compare them with expected using reference model function.
   > Author: Muhammad Junaid Ramzan
   > Modified: Muhammad Junaid Ramzan
   > Mail: muhammad.junaid@10xengineers.ai
   ---------------------------------------------------------------
   Copyright   (c)2024 10xEngineers
   ---------------------------------------------------------------
************************************************************************/
`ifndef I2S_TX_10XE_SCOREBOARD
`define I2S_TX_10XE_SCOREBOARD
// Class :: Scoreboard
class i2s_tx_10xe_scoreboard extends uvm_scoreboard;
   `uvm_component_utils(i2s_tx_10xe_scoreboard)
   `uvm_analysis_imp_decl(_axis_port)
   `uvm_analysis_imp_decl(_axi_port)
   `uvm_analysis_imp_decl(_dut_port)

   // Declaration of analysis imp ports
   uvm_analysis_imp_axis_port #(i2s_tx_10xe_axis_seq_item, i2s_tx_10xe_scoreboard)           axis_imp;
   uvm_analysis_imp_axi_port #(i2s_tx_10xe_axi_seq_item, i2s_tx_10xe_scoreboard)             axi_imp;   
   uvm_analysis_imp_dut_port #(i2s_tx_10xe_dut_seq_item, i2s_tx_10xe_scoreboard)             dut_imp;

   
   // Handles of all interface transactions
   i2s_tx_10xe_axis_seq_item     axis_tr;
   i2s_tx_10xe_axis_seq          axi_tr;
   i2s_tx_10xe_dut_seq_item      dut_tr;
 
   // Constructor
   function new(string name = "i2s_tx_10xe_scoreboard", uvm_component parent);
      super.new(name, parent);
      axis_imp = new("axis_imp", this);
      axi_imp = new("axi_imp", this);
      dut_imp = new("dut_imp", this);
   endfunction: new
   // Write method for axi-stream imp port
   virtual function void write_axis_port(i2s_tx_10xe_axis_seq_item axis_tr);
      // TODO Logic 
   endfunction

   // Write method for axi imp port
   virtual function void write_axi_port(i2s_tx_10xe_axi_seq_item axi_tr);
      // TODO Logic
   endfunction

   // Write method for dut imp port
   virtual function void write_dut_port(i2s_tx_10xe_dut_seq_item dut_tr);
      // TODO Logic
   endfunction

   
   
   

endclass

`endif