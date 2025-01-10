/*************************************************************************
   > File Name: i2s_tx_scoreboard.sv
   > Description: This file defines scoreboard class to recieve responses from monitors and compare them with expected using reference model function.
   > Author: Muhammad Junaid Ramzan
   > Modified: Muhammad Junaid Ramzan
   > Mail: muhammad.junaid@10xengineers.ai
   ---------------------------------------------------------------
   Copyright   (c)2024 10xEngineers
   ---------------------------------------------------------------
************************************************************************/
`ifndef I2S_TX_SCOREBOARD
`define I2S_TX_SCOREBOARD
// Class :: Scoreboard
class i2s_tx_scoreboard extends uvm_scoreboard;
   `uvm_component_utils(i2s_tx_scoreboard)
   `uvm_analysis_imp_decl(_axis_port)
   `uvm_analysis_imp_decl(_axi_port)
   `uvm_analysis_imp_decl(_i2s_port)

   // Declaration of analysis imp ports
   uvm_analysis_imp_axis_port #(i2s_tx_axis_seq_item, i2s_tx_scoreboard)           axis_imp;
   uvm_analysis_imp_axi_port #(i2s_tx_axi4_lite_seq_item, i2s_tx_scoreboard)       axi_imp;   
   uvm_analysis_imp_i2s_port #(i2s_tx_seq_item, i2s_tx_scoreboard)                 i2s_imp;

   
   // Handles of all interface transactions
   i2s_tx_axis_seq_item     axis_tr;
   i2s_tx_axis_seq          axi_tr;
   i2s_tx_seq_item          i2s_tr;
 
   // Constructor
   function new(string name = "i2s_tx_scoreboard", uvm_component parent);
      super.new(name, parent);
      axis_imp = new("axis_imp", this);
      axi_imp = new("axi_imp", this);
      i2s_imp = new("i2s_imp", this);
   endfunction: new

   //Queue to capture axi-stream transactions
   i2s_tx_axis_seq_item     axis_pkts[$];
   // Write method for axi-stream imp port
   virtual function void write_axis_port(i2s_tx_axis_seq_item axis_tr);
      // TODO Logic 
      //Push axi_transactions in queue to later compare with i2s_transactions
      i2s_tx_axis_seq_item axis_cln;
      // $cast(axis_cln, axis_tr);
      if (!$cast(axis_cln, axis_tr)) begin
         `uvm_error(get_name(), "Failed to cast axis_tr");
      end
      axis_pkts.push_front(axis_cln);
      `uvm_info(get_name(), $sformatf("AXI-Stream Transaction stored in Queue \n %s", axis_cln.sprint()), UVM_NONE)
      `uvm_info(get_name(), $sformatf("Size of queue is \n %d", axis_pkts.size()), UVM_DEBUG)
   endfunction

   // Write method for axi imp port
   virtual function void write_axi_port(i2s_tx_axi4_lite_seq_item axi_tr);
      // TODO Logic
   endfunction

   // Write method for i2s imp port
   virtual function void write_i2s_port(i2s_tx_seq_item i2s_tr);
      // TODO Logic
      i2s_tx_axis_seq_item  axis_tr0;
      if (axis_pkts.size() == 0) begin
          `uvm_error(get_name(), "Queue is empty! Cannot retrieve transaction.");
      end
      axis_tr0 = axis_pkts.pop_back();
      `uvm_info(get_name(), $sformatf("Size of queue is \n %d", axis_pkts.size()), UVM_DEBUG)
      `uvm_info(get_name(), $sformatf("AXI-Stream Transaction Retrived from Queue \n %s", axis_tr0.sprint()), UVM_NONE)
      if(axis_tr0.s_axis_aud_tdata[27:4] == i2s_tr.sdata_0_out) begin
         `uvm_info(get_name(), $sformatf("TEST PASSED  EXPECTED:: 0x%0h  ACTUAL:: 0x%0h", axis_tr0.s_axis_aud_tdata[27:4], i2s_tr.sdata_0_out), UVM_NONE)
         
      end
      else begin
         `uvm_error(get_name(), $sformatf("TEST FAILED DATA MISMATCHED  EXPECTED:: 0x%0h  ACTUAL:: 0x%0h", axis_tr0.s_axis_aud_tdata[27:4], i2s_tr.sdata_0_out))
         
      end
   endfunction
endclass

`endif