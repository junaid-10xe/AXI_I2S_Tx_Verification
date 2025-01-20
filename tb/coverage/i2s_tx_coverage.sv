/*************************************************************************
   > File Name: i2s_tx_coverage.sv
   > Description: This file defines the coverage classes for both axi4-lite and axi-stream interface.
   > Author: Muhammad Junaid Ramzan
   > Modified: Muhammad Junaid Ramzan
   > Mail: muhammad.junaid@10xengineers.ai
   ---------------------------------------------------------------
   Copyright   (c)2024 10xEngineers
   ---------------------------------------------------------------
************************************************************************/
`ifndef I2S_TX_COVERAGE
`define I2S_TX_COVERAGE

// Class :: axi4_coverage
// Description :: This class is designed to implement coverage for AXI4-Lite protocol transactions, 
//                including write, read, and protocol handshake signals. It extends UVM functionality.
class axi4_coverage extends uvm_subscriber #(i2s_tx_axi4_lite_seq_item);
    `uvm_component_utils(axi4_coverage)

    // Handel of axi4-lite transaction
    i2s_tx_axi4_lite_seq_item   axi4_tr;

    // Covergroup for Write transactions 
    covergroup axi4lite_write_cg;
        // Write address coverage (valid and random addresses)
        waddr: coverpoint axi4_tr.s_axi_ctrl_awaddr {                           // Register addresses
            bins addr_all[] = {'h00, 'h04, 'h08, 'h0C, 'h10, 'h14, 
                               'h20, 'h30, 'h34, 'h38, 'h3C, 'h50, 
                               'h54, 'h58, 'h5C, 'h60, 'h64};
            bins rand_addr  = {[0:$]};
        }
        // Write data coverage (specific patterns and random values)
        wdata: coverpoint axi4_tr.s_axi_ctrl_wdata {                            
            bins all_ones  = {'hFFFFFFFF};
            bins all_zeros = {'h00000000};
            bins rand_val   = {[0:$]};
        }
        // Write response coverage (valid and invalid responses)
        wresp: coverpoint axi4_tr.s_axi_ctrl_bresp {                             // Write response
            bins ok_resp = {2'b00};
            bins slv_err = {2'b10};
        }
        // Cross coverage for address, data, and response
        addr_x_wdata_x_resp: cross waddr, wdata, wresp{
            bins addr_wdata_allone  = binsof(waddr.addr_all)  && binsof(wdata.all_ones) && binsof(wresp.ok_resp);
            bins addr_wdata_allzero = binsof(waddr.addr_all)  && binsof(wdata.all_zeros) && binsof(wresp.ok_resp);
            bins addr_wdata_rand    = binsof(waddr.addr_all)  && binsof(wdata.rand_val) && binsof(wresp.ok_resp);
            bins addr_rresp_err     = binsof(waddr.addr_all)  && binsof(wresp.slv_err);
            
            ignore_bins ignore_1    = !(binsof(waddr.addr_all)); 
        } 

        rand_addr_x_wdata_x_resp: cross waddr, wdata, wresp{
            bins rand_addr_rresp_ok     = binsof(waddr.rand_addr) && binsof(wresp.ok_resp)  && binsof(wdata.rand_val);
            bins rand_addr_rresp_err    = binsof(waddr.rand_addr) && binsof(wresp.slv_err)  && binsof(wdata.rand_val);
            
            ignore_bins ignore_0        = binsof(waddr.addr_all);
            ignore_bins ignore_1        = binsof(wdata.all_zeros);
            ignore_bins ignore_2        = binsof(wdata.all_ones);

        }
    endgroup : axi4lite_write_cg

    // Covergroup for Read transactions
    covergroup axi4lite_read_cg;
        // Read address coverage (valid and random addresses)
        raddr: coverpoint axi4_tr.s_axi_ctrl_araddr {                           // Register addresses
            bins addr_all[] = {'h00, 'h04, 'h08, 'h0C, 'h10, 'h14, 
                                'h20, 'h30, 'h34, 'h38, 'h3C, 'h50, 
                                'h54, 'h58, 'h5C, 'h60, 'h64};
           bins rand_addr  = {[0:$]};
        }
        // Read data coverage
        rdata: coverpoint axi4_tr.s_axi_ctrl_rdata {                            // Data values read
            bins all_values = {[0:$]};
        }
        // Read response coverage (valid and invalid responses)
        rresp: coverpoint axi4_tr.s_axi_ctrl_rresp {                            // Read response
            bins ok_resp = {2'b00};
            bins slv_err = {2'b10};
        }
        // Cross coverage for address, data, and response
        raddr_x_rresp: cross raddr, rresp{
                    bins addr_rresp_ok   = binsof(raddr.addr_all) && binsof(rresp.ok_resp);
                    bins addr_rresp_err  = binsof(raddr.addr_all) && binsof(rresp.slv_err);

                    ignore_bins ignore_0 = !binsof(raddr.addr_all);

        }
        rand_raddr_x_rresp: cross raddr, rresp{
            bins rand_addr_rresp_err = binsof(raddr.rand_addr) && binsof(rresp.slv_err);
            bins rand_addr_rresp_ok  = binsof(raddr.rand_addr) && binsof(rresp.ok_resp);
            
            // Ignore bins which are part of addr_all 
            ignore_bins ignore_0  = binsof(raddr.addr_all); 
}
    endgroup : axi4lite_read_cg

    // Covergroup for handshake signals
    covergroup axi4lite_protocol_cg;
        coverpoint axi4_tr.s_axi_ctrl_awvalid;                           // Write address valid
        coverpoint axi4_tr.s_axi_ctrl_awready;                           // Write address ready
        coverpoint axi4_tr.s_axi_ctrl_wvalid;                            // Write data valid
        coverpoint axi4_tr.s_axi_ctrl_wready;                            // Write data ready
        coverpoint axi4_tr.s_axi_ctrl_arvalid;                           // Read address valid
        coverpoint axi4_tr.s_axi_ctrl_arready;                           // Read address ready
        coverpoint axi4_tr.s_axi_ctrl_rvalid;                            // Read data valid
        coverpoint axi4_tr.s_axi_ctrl_rready;                            // Read data ready
        coverpoint axi4_tr.s_axi_ctrl_bvalid;                            // Write response valid
        coverpoint axi4_tr.s_axi_ctrl_bready;                            // Write response ready
    endgroup : axi4lite_protocol_cg
    // Constructor
    function new( string name , uvm_component parent);
        super.new( name , parent );
        axi4lite_write_cg       = new();
        axi4lite_protocol_cg    = new();
        axi4lite_read_cg        = new();
 
    endfunction
    // Write method to sample coverage
    function void write(i2s_tx_axi4_lite_seq_item t);
        axi4_tr = t;
        axi4lite_write_cg.sample();
        axi4lite_protocol_cg.sample();
        axi4lite_read_cg.sample();
    endfunction

endclass: axi4_coverage

// Class :: AXI-Stream Coverage
// Description :: This class is responsible for collecting and analyzing coverage data 
//                for AXI-Stream transactions in the UVM environment.
class axi_stream_coverage extends uvm_subscriber #(i2s_tx_axis_seq_item);
    `uvm_component_utils(axi_stream_coverage)

    // Handle of axi-stream transaction
    i2s_tx_axis_seq_item        axis_tr;

    // Covergroup for AXI-Stream data fields
    covergroup axi_stream_data_cg;
        // Coverage for audio sample data (24-bit signed range)
        coverpoint axis_tr.s_axis_aud_tdata[27:4] {                     // Audio sample data range
            bins valid_data = {[0:$]};                                  
        }
        // Coverage for parity bit
        parity: coverpoint axis_tr.s_axis_aud_tdata[31] {               // Parity bit
            bins parity_values[] = {1'b0, 1'b1};
        }
        // Coverage for channel status bit
        chan_stat: coverpoint axis_tr.s_axis_aud_tdata[30] {            // Channel Status bit
            bins channel_status[] = {1'b0, 1'b1};
        }
        // Coverage for valid bit
        valid_bit: coverpoint axis_tr.s_axis_aud_tdata[28] {            // Validity bit
            bins validity_bit[] = {1'b0, 1'b1};
        }
        // Coverage for user bit
        user_bit :coverpoint axis_tr.s_axis_aud_tdata[29] {             // User bit
            bins user_bit[] = {1'b0, 1'b1};
        }
        // Coverage for preamble (4-bit values)
        preamble: coverpoint axis_tr.s_axis_aud_tdata[3:0] {            // Preamble
            bins preamble_all[] = {4'b0001, 4'b0010, 4'b0011};
        }
        // Cross-coverage for preamble and control bits
        cross preamble, parity, chan_stat, valid_bit;                   
    endgroup : axi_stream_data_cg

    // Covergroup for handshake signals
    covergroup axi_stream_protocol_cg;
        axis_valid: coverpoint axis_tr.s_axis_aud_tvalid;               // Valid signal
        axis_ready: coverpoint axis_tr.s_axis_aud_tready;               // Ready signal
        cross axis_valid, axis_ready;                                   // Handshake cross-coverage
    endgroup : axi_stream_protocol_cg

    // Covergroup for transaction ID (TID) field
    covergroup axi_stream_tid_cg;
        coverpoint axis_tr.s_axis_aud_tid {                             // Transaction ID for multi-channel
            bins channel_ids[] = {3'b000, 3'b001};
        }
    endgroup : axi_stream_tid_cg

    // Constructor
    function new( string name , uvm_component parent);
        super.new( name , parent);
        axi_stream_data_cg      = new();
        axi_stream_protocol_cg  = new();
        axi_stream_tid_cg       = new();
    endfunction

    // Write Method
    function void write(i2s_tx_axis_seq_item t);
        axis_tr = t;
        axi_stream_data_cg.sample();
        axi_stream_protocol_cg.sample();
        axi_stream_tid_cg.sample();
    endfunction
endclass
`endif