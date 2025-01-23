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
   i2s_tx_axis_seq_item                axis_tr;
   i2s_tx_axi4_lite_seq_item           axi_tr;
   i2s_tx_seq_item                     i2s_tr;
   //Handle of configure class
   i2s_tx_config                        cfg;

   //Variable to store previous tdata
   i2s_tx_defines::axi_stream_data     prev_tdata;
   // variable to store prev TID
   i2s_tx_defines::axi_stream_tid      prev_tid;
   // Control bit to store value in queue or drop
   bit                                 valid_pkt;
   bit                                 invalid_pkt;
   bit                                 drop_pkt;
   // Constructor
   function new(string name = "i2s_tx_scoreboard", uvm_component parent);
      super.new(name, parent);
      axis_imp = new("axis_imp", this);
      axi_imp  = new("axi_imp", this);
      i2s_imp  = new("i2s_imp", this);
   endfunction: new

   // Build Phase to get cfg class
   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if(!uvm_config_db#(i2s_tx_config)::get(this, "*", "cfg", cfg)) begin
         `uvm_fatal(get_name(), "Failed to get Configuration from Config DB")
     end
   endfunction: build_phase
   
   //Queue to capture axi-stream transactions
   i2s_tx_axis_seq_item     axis_pkts[$];
   //Variable to count number of transaction
   int count = 0;
   // Write method for axi-stream imp port
   virtual function void write_axis_port(i2s_tx_axis_seq_item axis_tr);
      // Push axi_transactions in queue to later compare with i2s_transactions
      i2s_tx_axis_seq_item axis_cln;
      // $cast(axis_cln, axis_tr);
      if (!$cast(axis_cln, axis_tr)) begin
         `uvm_error(get_name(), "Failed to cast axis_tr");
      end

      if(axis_cln.s_axis_aud_tready && axis_cln.s_axis_aud_tvalid) begin   
         if(prev_tid == 0 && axis_cln.s_axis_aud_tid == 1) begin
            valid_pkt   = 1;
            invalid_pkt = 0;
            drop_pkt    = 0;
            prev_tid    = axis_cln.s_axis_aud_tid;
         end
         else if (prev_tid == 1 && axis_cln.s_axis_aud_tid == 0 ) begin
            valid_pkt  = 1;
            prev_tid   = axis_cln.s_axis_aud_tid;
         end
         else if (prev_tid == 1 && axis_cln.s_axis_aud_tid == 1) begin
            valid_pkt   = 0;
            drop_pkt    = 1;
            invalid_pkt = 1;
            prev_tid    = axis_cln.s_axis_aud_tid;
         end
         else if (prev_tid == 0 && axis_cln.s_axis_aud_tid == 0) begin
            valid_pkt   = 0;
            prev_tid    = 1;
            invalid_pkt = 0;
         end
            
         if(prev_tdata != axis_cln.s_axis_aud_tdata ) begin
               // Logic to store valid transactions in queue 
            
            if(axis_cln.s_axis_aud_tdata[28]==0 || cfg.AXI_STREAM_DATA_VALID == 1) begin
               if((valid_pkt == 1) || count == 0 ) begin
                  axis_pkts.push_front(axis_cln);
                  prev_tdata = axis_cln.s_axis_aud_tdata;
                  count++;
                  `uvm_info(get_name(), $sformatf("AXI-Stream Transaction stored in Queue \n %s", axis_cln.sprint()), UVM_HIGH)
                  `uvm_info(get_name(), $sformatf("prev_tid %0d count %0d", prev_tid, count), UVM_DEBUG)
               end
               else if (valid_pkt == 0 && invalid_pkt == 0) begin
                  // Handles to pop back invalid transactions
                  // then make it valid and push in the queue
                  i2s_tx_axis_seq_item                axis_tr0;
                  i2s_tx_axis_seq_item                axis_tr1;
      
                  axis_tr1 = axis_pkts.pop_front();
                  axis_tr0 = axis_pkts.pop_front();
      
                  if(axis_tr0.s_axis_aud_tdata[4]==0) axis_tr1.s_axis_aud_tdata[27:4]   = 24'h0;
                  else axis_tr1.s_axis_aud_tdata[27:4]   = 24'h800000;
      
                  axis_cln.s_axis_aud_tdata[27:4]       = 0;
      
                  //push again with valid data 
                  axis_pkts.push_front(axis_tr0);
                  axis_pkts.push_front(axis_tr1);
      
                  if (drop_pkt) axis_pkts.push_front(axis_cln);
                  else repeat(3) axis_pkts.push_front(axis_cln);
      
                  `uvm_info(get_name(), $sformatf("AXI-Stream Transaction stored in Queue \n %s", axis_cln.sprint()), UVM_HIGH)
                  `uvm_info(get_name(), $sformatf("prev_tid %0d count %0d", prev_tid, count), UVM_DEBUG)
               end
            `uvm_info(get_name(), $sformatf("AXI-Stream Transaction  prev_tid %0d count %0d   valid_pkt %0d", prev_tid, count, valid_pkt), UVM_HIGH)
         end
         else begin
            prev_tdata = axis_cln.s_axis_aud_tdata;
            axis_cln.s_axis_aud_tdata[27:4] = 0;
            axis_pkts.push_front(axis_cln);
         end
      end
   end   
      `uvm_info(get_name(), $sformatf("Size of queue is \n %d", axis_pkts.size()), UVM_DEBUG)
   endfunction

   // Write method for axi imp port
   virtual function void write_axi_port(i2s_tx_axi4_lite_seq_item axi_tr);
      if(cfg.RAL_CHECKER) begin
         ral_resp_checker(axi_tr);
      end

   endfunction

   // Write method for i2s imp port
   virtual function void write_i2s_port(i2s_tx_seq_item i2s_tr);
      i2s_tx_axis_seq_item  axis_tr_d;
      if(cfg.EN_CHECKER) begin
         if (axis_pkts.size() == 0) begin
            `uvm_error(get_name(), "Queue is empty! Cannot retrieve transaction.");
         end
         axis_tr_d = axis_pkts.pop_back();
         i2s_output_checker(i2s_tr, axis_tr_d);
         `uvm_info(get_name(), $sformatf("Size of queue is \n %d", axis_pkts.size()), UVM_DEBUG)
         `uvm_info(get_name(), $sformatf("AXI-Stream Transaction Retrived from Queue \n %s", axis_tr_d.sprint()), UVM_HIGH)
      end
   endfunction

   // Checker function for i2s Output
   function void i2s_output_checker(input i2s_tx_seq_item i2s_tr, input i2s_tx_axis_seq_item axis_tr_d);
      if(cfg.RIGHT_JUSTICATION) begin
         if(axis_tr_d.s_axis_aud_tdata[27:4] == i2s_tr.sdata_0_out[23:0]) begin
            `uvm_info(get_name(), $sformatf("TEST PASSED  EXPECTED:: 0x%0h  ACTUAL:: 0x%0h", axis_tr_d.s_axis_aud_tdata[27:4], i2s_tr.sdata_0_out[23:0]), UVM_NONE)
            
         end
         else begin
            `uvm_error(get_name(), $sformatf("TEST FAILED DATA MISMATCHED  EXPECTED:: 0x%0h  ACTUAL:: 0x%0h", axis_tr_d.s_axis_aud_tdata[27:4], i2s_tr.sdata_0_out[23:0]))
            
         end      
      end
      else if (cfg.LEFT_JUSTICATION) begin
         if(axis_tr_d.s_axis_aud_tdata[27:4] == i2s_tr.sdata_0_out[31:8]) begin
            `uvm_info(get_name(), $sformatf("TEST PASSED  EXPECTED:: 0x%0h  ACTUAL:: 0x%0h", axis_tr_d.s_axis_aud_tdata[27:4], i2s_tr.sdata_0_out[31:8]), UVM_NONE)
            
         end
         else begin
            `uvm_error(get_name(), $sformatf("TEST FAILED DATA MISMATCHED  EXPECTED:: 0x%0h  ACTUAL:: 0x%0h", axis_tr_d.s_axis_aud_tdata[27:4], i2s_tr.sdata_0_out[31:8]))
            
         end   
      end
      else begin
         if(axis_tr_d.s_axis_aud_tdata[27:4] == i2s_tr.sdata_0_out) begin
            `uvm_info(get_name(), $sformatf("TEST PASSED  EXPECTED:: 0x%0h  ACTUAL:: 0x%0h", axis_tr_d.s_axis_aud_tdata[27:4], i2s_tr.sdata_0_out), UVM_NONE)
            
         end
         else begin
            `uvm_error(get_name(), $sformatf("TEST FAILED DATA MISMATCHED  EXPECTED:: 0x%0h  ACTUAL:: 0x%0h", axis_tr_d.s_axis_aud_tdata[27:4], i2s_tr.sdata_0_out))
            
         end
      end
   endfunction

   // Function to check reponse of register read write
   function void ral_resp_checker(input i2s_tx_axi4_lite_seq_item axi_tr);
      // Array of valid write addresses
      reg [7:0] write_array [0:15] = {
         8'h00, 8'h08, 8'h0C, 8'h10, 8'h14, 
         8'h20, 8'h30, 8'h34, 8'h38, 8'h3C, 8'h50, 
         8'h54, 8'h58, 8'h5C, 8'h60, 8'h64
      };
      // Array of valid read addresses
      reg [7:0] read_array [0:16] = {
         8'h00, 8'h04, 8'h08, 8'h0C, 8'h10, 8'h14, 
         8'h20, 8'h30, 8'h34, 8'h38, 8'h3C, 8'h50, 
         8'h54, 8'h58, 8'h5C, 8'h60, 8'h64
      };

      bit read_match;
      bit write_match;

      if(axi_tr.s_axi_ctrl_bvalid && axi_tr.s_axi_ctrl_bready) begin
         write_match = 0;
         foreach(write_array[i]) begin
            if(axi_tr.s_axi_ctrl_awaddr == write_array[i]) begin
               write_match = 1;
            end
         end
         if (write_match) begin
            if(axi_tr.s_axi_ctrl_bresp != 'b00) begin
               `uvm_error(get_name(), $sformatf("TEST FAILED EXPECTED RESPONSE 00, GOT %0b for address %0h", axi_tr.s_axi_ctrl_bresp, axi_tr.s_axi_ctrl_awaddr))
            end
            else begin
               `uvm_info(get_name(), $sformatf("TEST PASSED EXPECTED RESPONSE 00, GOT %0b for address %0h", axi_tr.s_axi_ctrl_bresp, axi_tr.s_axi_ctrl_awaddr), UVM_LOW)
            end
         end
         else begin
            if(axi_tr.s_axi_ctrl_bresp != 'b10) begin
               `uvm_error(get_name(), $sformatf("TEST FAILED EXPECTED RESPONSE 10, GOT %0b for address %0h", axi_tr.s_axi_ctrl_bresp, axi_tr.s_axi_ctrl_awaddr))
            end
            else begin
               `uvm_info(get_name(), $sformatf("TEST PASSED EXPECTED RESPONSE 10, GOT %0b for address %0h", axi_tr.s_axi_ctrl_bresp, axi_tr.s_axi_ctrl_awaddr), UVM_LOW)
            end
         end
      end
      // For read
      if(axi_tr.s_axi_ctrl_rvalid && axi_tr.s_axi_ctrl_rready) begin
         read_match = 0;
         foreach(read_array[i]) begin
            if(axi_tr.s_axi_ctrl_araddr == read_array[i]) begin
               read_match = 1;
            end
         end
         if (read_match) begin
            if(axi_tr.s_axi_ctrl_rresp != 'b00) begin
               `uvm_error(get_name(), $sformatf("TEST FAILED EXPECTED RESPONSE 00, GOT %0b for address %0h", axi_tr.s_axi_ctrl_rresp, axi_tr.s_axi_ctrl_araddr))
            end
            else begin
               `uvm_info(get_name(), $sformatf("TEST PASSED EXPECTED RESPONSE 00, GOT %0b for address %0h", axi_tr.s_axi_ctrl_rresp, axi_tr.s_axi_ctrl_araddr), UVM_LOW)
            end
         end
         else begin
            if(axi_tr.s_axi_ctrl_rresp != 'b10) begin
               `uvm_error(get_name(), $sformatf("TEST FAILED EXPECTED RESPONSE 10, GOT %0b for address %0h", axi_tr.s_axi_ctrl_rresp, axi_tr.s_axi_ctrl_araddr))
            end
            else begin
               `uvm_info(get_name(), $sformatf("TEST PASSED EXPECTED RESPONSE 10, GOT %0b for address %0h", axi_tr.s_axi_ctrl_rresp, axi_tr.s_axi_ctrl_araddr), UVM_LOW)
            end
         end         
      end
   endfunction
endclass

`endif