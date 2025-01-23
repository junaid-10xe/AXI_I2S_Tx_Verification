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
        // Write address coverage (valid)
        valid_waddr: coverpoint axi4_tr.s_axi_ctrl_awaddr {                           // Register addresses
            bins core_ver_reg       = {'h00};
            bins core_config_reg    = {'h04};
            bins core_ctrl_reg      = {'h08};
            bins validity_reg       = {'h0C};
            bins itrpt_ctrl_reg     = {'h10};
            bins itrpt_status_reg   = {'h14};
            bins i2s_reg            = {'h20};
            bins chan_01_reg        = {'h30};
            bins chan_23_reg        = {'h34};
            bins chan_45_reg        = {'h38};
            bins chan_67_reg        = {'h3C};
            bins aes_chan_stat0     = {'h50};
            bins aes_chan_stat1     = {'h54};
            bins aes_chan_stat2     = {'h58};
            bins aes_chan_stat3     = {'h5C};
            bins aes_chan_stat4     = {'h60};
            bins aes_chan_stat5     = {'h64};
        }
        rand_waddr: coverpoint axi4_tr.s_axi_ctrl_awaddr {                          // Random addresses
            bins rand_addr          = {[0:$]};
            }
        // Write data coverage (specific patterns and random values)
        wdata: coverpoint axi4_tr.s_axi_ctrl_wdata {                            
            bins all_ones   = {'hFFFFFFFF};
            bins all_zeros  = {'h00000000};
            bins rand_val   = {[0:$]};
        }
        sck_div: coverpoint axi4_tr.s_axi_ctrl_wdata[7:0] {
            bins sck_val_1    = {1};
            bins sck_val_2    = {2};
            bins sck_val_3    = {3};
            bins sck_val_4    = {4};
        }
        // Write response coverage (valid and invalid responses)
        wresp: coverpoint axi4_tr.s_axi_ctrl_bresp {                             // Write response
            bins ok_resp = {2'b00};
            bins slv_err = {2'b10};
        }
        // Cross coverage for address, data, and response
        addr_x_wdata_x_resp: cross valid_waddr, wdata, wresp{
            bins core_ver_allone_ok         = binsof(valid_waddr.core_ver_reg)    && binsof(wdata.all_ones) && binsof(wresp.ok_resp);
            bins core_config_allone_ok      = binsof(valid_waddr.core_config_reg) && binsof(wdata.all_ones) && binsof(wresp.slv_err);
            bins core_ctrl_allone_ok        = binsof(valid_waddr.core_ctrl_reg)   && binsof(wdata.all_ones) && binsof(wresp.ok_resp);
            bins validity_allone_ok         = binsof(valid_waddr.validity_reg)    && binsof(wdata.all_ones) && binsof(wresp.ok_resp);
            bins itrpt_ctrl_allone_ok       = binsof(valid_waddr.itrpt_ctrl_reg)  && binsof(wdata.all_ones) && binsof(wresp.ok_resp);
            bins itrpt_status_allone_ok     = binsof(valid_waddr.itrpt_status_reg) && binsof(wdata.all_ones) && binsof(wresp.ok_resp);
            bins i2s_allone_ok              = binsof(valid_waddr.i2s_reg)         && binsof(wdata.all_ones) && binsof(wresp.ok_resp);
            bins chan_01_allone_ok          = binsof(valid_waddr.chan_01_reg)     && binsof(wdata.all_ones) && binsof(wresp.ok_resp);
            bins chan_23_allone_ok          = binsof(valid_waddr.chan_23_reg)     && binsof(wdata.all_ones) && binsof(wresp.ok_resp);
            bins chan_45_allone_ok          = binsof(valid_waddr.chan_45_reg)     && binsof(wdata.all_ones) && binsof(wresp.ok_resp);
            bins chan_67_allone_ok          = binsof(valid_waddr.chan_67_reg)     && binsof(wdata.all_ones) && binsof(wresp.ok_resp);
            bins aes_chan_stat0_allone_ok   = binsof(valid_waddr.aes_chan_stat0) && binsof(wdata.all_ones) && binsof(wresp.ok_resp);
            bins aes_chan_stat1_allone_ok   = binsof(valid_waddr.aes_chan_stat1) && binsof(wdata.all_ones) && binsof(wresp.ok_resp);
            bins aes_chan_stat2_allone_ok   = binsof(valid_waddr.aes_chan_stat2) && binsof(wdata.all_ones) && binsof(wresp.ok_resp);
            bins aes_chan_stat3_allone_ok   = binsof(valid_waddr.aes_chan_stat3) && binsof(wdata.all_ones) && binsof(wresp.ok_resp);
            bins aes_chan_stat4_allone_ok   = binsof(valid_waddr.aes_chan_stat4) && binsof(wdata.all_ones) && binsof(wresp.ok_resp);
            bins aes_chan_stat5_allone_ok   = binsof(valid_waddr.aes_chan_stat5) && binsof(wdata.all_ones) && binsof(wresp.ok_resp);
            
            bins core_ver_allzero_ok        = binsof(valid_waddr.core_ver_reg)    && binsof(wdata.all_zeros) && binsof(wresp.ok_resp);
            bins core_config_allzero_ok     = binsof(valid_waddr.core_config_reg) && binsof(wdata.all_zeros) && binsof(wresp.slv_err);
            bins core_ctrl_allzero_ok       = binsof(valid_waddr.core_ctrl_reg)   && binsof(wdata.all_zeros) && binsof(wresp.ok_resp);
            bins validity_allzero_ok        = binsof(valid_waddr.validity_reg)    && binsof(wdata.all_zeros) && binsof(wresp.ok_resp);
            bins itrpt_ctrl_allzero_ok      = binsof(valid_waddr.itrpt_ctrl_reg)  && binsof(wdata.all_zeros) && binsof(wresp.ok_resp);
            bins itrpt_status_allzero_ok    = binsof(valid_waddr.itrpt_status_reg) && binsof(wdata.all_zeros) && binsof(wresp.ok_resp);
            bins i2s_allzero_ok             = binsof(valid_waddr.i2s_reg)         && binsof(wdata.all_zeros) && binsof(wresp.ok_resp);
            bins chan_01_allzero_ok         = binsof(valid_waddr.chan_01_reg)     && binsof(wdata.all_zeros) && binsof(wresp.ok_resp);
            bins chan_23_allzero_ok         = binsof(valid_waddr.chan_23_reg)     && binsof(wdata.all_zeros) && binsof(wresp.ok_resp);
            bins chan_45_allzero_ok         = binsof(valid_waddr.chan_45_reg)     && binsof(wdata.all_zeros) && binsof(wresp.ok_resp);
            bins chan_67_allzero_ok         = binsof(valid_waddr.chan_67_reg)     && binsof(wdata.all_zeros) && binsof(wresp.ok_resp);
            bins aes_chan_stat0_allzero_ok  = binsof(valid_waddr.aes_chan_stat0) && binsof(wdata.all_zeros) && binsof(wresp.ok_resp);
            bins aes_chan_stat1_allzero_ok  = binsof(valid_waddr.aes_chan_stat1) && binsof(wdata.all_zeros) && binsof(wresp.ok_resp);
            bins aes_chan_stat2_allzero_ok  = binsof(valid_waddr.aes_chan_stat2) && binsof(wdata.all_zeros) && binsof(wresp.ok_resp);
            bins aes_chan_stat3_allzero_ok  = binsof(valid_waddr.aes_chan_stat3) && binsof(wdata.all_zeros) && binsof(wresp.ok_resp);
            bins aes_chan_stat4_allzero_ok  = binsof(valid_waddr.aes_chan_stat4) && binsof(wdata.all_zeros) && binsof(wresp.ok_resp);
            bins aes_chan_stat5_allzero_ok  = binsof(valid_waddr.aes_chan_stat5) && binsof(wdata.all_zeros) && binsof(wresp.ok_resp);

            // Ignore bins
            ignore_bins ignore_0            = binsof(wresp.slv_err) && ( binsof(valid_waddr) intersect {'h00, 'h08, 'h0C, 'h10, 'h14, 
                                                                                'h20, 'h30, 'h34, 'h38, 'h3C, 'h50, 
                                                                                'h54, 'h58, 'h5C, 'h60, 'h64});
            ignore_bins ignore_1            = binsof(valid_waddr.core_config_reg) && binsof(wresp.ok_resp);
            ignore_bins ignore_2            = binsof(wdata.rand_val);
        }
            

        rand_addr_x_wdata_x_resp: cross rand_waddr, wdata, wresp{
            bins rand_addr_rresp_err    = binsof(rand_waddr.rand_addr) && binsof(wresp.slv_err);
            // Ignore bins
            ignore_bins ignore_0        = binsof(wresp.ok_resp);
            ignore_bins ignore_1        = binsof(wdata.all_ones);
            ignore_bins ignore_2        = binsof(wdata.all_zeros);
        }

        // Cross coverage of i2s timing register with different values
        i2s_timing_reg_x_SCK_VAL: cross sck_div, valid_waddr{
            bins i2s_timing_reg_sck_val_1 = binsof(valid_waddr.i2s_reg) && binsof(sck_div.sck_val_1);
            bins i2s_timing_reg_sck_val_2 = binsof(valid_waddr.i2s_reg) && binsof(sck_div.sck_val_2);
            bins i2s_timing_reg_sck_val_3 = binsof(valid_waddr.i2s_reg) && binsof(sck_div.sck_val_3);
            bins i2s_timing_reg_sck_val_4 = binsof(valid_waddr.i2s_reg) && binsof(sck_div.sck_val_4);

            ignore_bins ignore_0          = (binsof(valid_waddr) intersect {'h00, 'h04, 'h08, 'h0C, 'h10, 'h14, 
                                                                            'h30, 'h34, 'h38, 'h3C, 'h50, 
                                                                            'h54, 'h58, 'h5C, 'h60, 'h64});
        }
    endgroup : axi4lite_write_cg

    // Covergroup for Read transactions
    covergroup axi4lite_read_cg;
        // Read address coverage (valid addresses)
        valid_raddr: coverpoint axi4_tr.s_axi_ctrl_araddr {                           // Register addresses
            
            bins core_ver_reg       = {'h00};
            bins core_config_reg    = {'h04};
            bins core_ctrl_reg      = {'h08};
            bins validity_reg       = {'h0C};
            bins itrpt_ctrl_reg     = {'h10};
            bins itrpt_status_reg   = {'h14};
            bins i2s_reg            = {'h20};
            bins chan_01_reg        = {'h30};
            bins chan_23_reg        = {'h34};
            bins chan_45_reg        = {'h38};
            bins chan_67_reg        = {'h3C};
            bins aes_chan_stat0     = {'h50};
            bins aes_chan_stat1     = {'h54};
            bins aes_chan_stat2     = {'h58};
            bins aes_chan_stat3     = {'h5C};
            bins aes_chan_stat4     = {'h60};
            bins aes_chan_stat5     = {'h64};
        }
        // Read data coverage (Random Addresses)
        rand_raddr: coverpoint axi4_tr.s_axi_ctrl_araddr {
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
        raddr_x_rresp: cross valid_raddr, rresp{
                    bins core_ver_rsp_ok         = binsof(valid_raddr.core_ver_reg)    && binsof(rresp.ok_resp);
                    bins core_config_rsp_ok      = binsof(valid_raddr.core_config_reg) && binsof(rresp.ok_resp);
                    bins core_ctrl_rsp_ok        = binsof(valid_raddr.core_ctrl_reg)   && binsof(rresp.ok_resp);
                    bins validity_rsp_ok         = binsof(valid_raddr.validity_reg)    && binsof(rresp.ok_resp);
                    bins itrpt_ctrl_rsp_ok       = binsof(valid_raddr.itrpt_ctrl_reg)  && binsof(rresp.ok_resp);
                    bins itrpt_status_rsp_ok     = binsof(valid_raddr.itrpt_status_reg) && binsof(rresp.ok_resp);
                    bins i2s_rsp_ok              = binsof(valid_raddr.i2s_reg)         && binsof(rresp.ok_resp);
                    bins chan_01_rsp_ok          = binsof(valid_raddr.chan_01_reg)     && binsof(rresp.ok_resp);
                    bins chan_23_rsp_ok          = binsof(valid_raddr.chan_23_reg)     && binsof(rresp.ok_resp);
                    bins chan_45_rsp_ok          = binsof(valid_raddr.chan_45_reg)     && binsof(rresp.ok_resp);
                    bins chan_67_rsp_ok          = binsof(valid_raddr.chan_67_reg)     && binsof(rresp.ok_resp);
                    bins aes_chan_stat0_rsp_ok   = binsof(valid_raddr.aes_chan_stat0) && binsof(rresp.ok_resp);
                    bins aes_chan_stat1_rsp_ok   = binsof(valid_raddr.aes_chan_stat1) && binsof(rresp.ok_resp);
                    bins aes_chan_stat2_rsp_ok   = binsof(valid_raddr.aes_chan_stat2) && binsof(rresp.ok_resp);
                    bins aes_chan_stat3_rsp_ok   = binsof(valid_raddr.aes_chan_stat3) && binsof(rresp.ok_resp);
                    bins aes_chan_stat4_rsp_ok   = binsof(valid_raddr.aes_chan_stat4) && binsof(rresp.ok_resp);
                    bins aes_chan_stat5_rsp_ok   = binsof(valid_raddr.aes_chan_stat5) && binsof(rresp.ok_resp);
        
                    // Ignore bins
                    ignore_bins ignore_0 = binsof(rresp.slv_err);
        }
        rand_raddr_x_rresp: cross rand_raddr, rresp{
            bins rand_addr_rresp_err = binsof(rand_raddr.rand_addr) && binsof(rresp.slv_err);            
            // Ignore bins which are part of ok resp
            ignore_bins ignore_0  = binsof(rresp.ok_resp); 
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
            bins all_ones   = {24'hFFFFFF};
            bins all_zeros  = {24'h000000};
            bins rand_data  = {[0:$]};                                  
        }
        // Coverage for parity bit
        parity: coverpoint axis_tr.s_axis_aud_tdata[31] {               // Parity bit
            bins parity_val_lo = {1'b0};
            bins parity_val_hi = {1'b1};
        }
        // Coverage for channel status bit
        chan_stat: coverpoint axis_tr.s_axis_aud_tdata[30] {            // Channel Status bit
            bins channel_status_0 = {1'b0};
            bins channel_status_1 = {1'b1};
        }
        // Coverage for valid bit
        valid_bit: coverpoint axis_tr.s_axis_aud_tdata[28] {            // Validity bit
            bins validity_bit_lo = {1'b0};
            bins validity_bit_hi = {1'b1};
        }
        // Coverage for user bit
        user_bit :coverpoint axis_tr.s_axis_aud_tdata[29] {             // User bit
            bins user_bit[] = {1'b0, 1'b1};
        }
        // Coverage for preamble (4-bit values)
        preamble: coverpoint axis_tr.s_axis_aud_tdata[3:0] {            // Preamble
            bins preamble_start = {4'b0001};
            bins preamble_left  = {4'b0010};
            bins preamble_right = {4'b0011};
        }
        // Cross-coverage for preamble and control bits
        cross preamble, parity, chan_stat, valid_bit {
            ignore_bins ignore_0 = binsof(preamble.preamble_start) && (binsof(chan_stat.channel_status_0) || binsof(valid_bit.validity_bit_hi) || binsof(parity.parity_val_hi));
        }                   
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