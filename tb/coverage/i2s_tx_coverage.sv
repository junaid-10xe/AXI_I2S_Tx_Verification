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
class axi4_coverage extends uvm_subscriber #(i2s_tx_axi4_lite_seq_item);
    `uvm_component_utils(axi4_coverage)

    // Handel of axi4-lite transaction
    i2s_tx_axi4_lite_seq_item   axi4_tr;

    // Covergroup Write 
    covergroup axi4lite_write_cg;
        waddr: coverpoint axi4_tr.s_axi_ctrl_awaddr {                           // Register addresses
            bins addr_all[] = {'h00, 'h04, 'h08, 'h0C, 'h10, 'h14, 
                               'h20, 'h30, 'h34, 'h38, 'h3C, 'h50, 
                               'h54, 'h58, 'h5C, 'h60, 'h64};
            // Define an invalid address that is not in the valid address set
            bins rand_addr  = {[0:$]};
        }
        wdata: coverpoint axi4_tr.s_axi_ctrl_wdata {                            // Data values written
            bins all_ones  = {'hFFFFFFFF};
            bins all_zeros = {'h00000000};
            bins rand_val   = {[0:$]};
        }
        wresp: coverpoint axi4_tr.s_axi_ctrl_bresp {                                              // Write response
            bins ok_resp = {2'b00};
            bins slv_err = {2'b10};
        }
        addr_x_wdata_x_resp: cross waddr, wdata, wresp{
            bins addr_wdata_allone = binsof(waddr.addr_all)  && binsof(wdata.all_ones) && binsof(wresp.ok_resp);
            bins addr_wdata_allzer = binsof(waddr.addr_all)  && binsof(wdata.all_zeros) && binsof(wresp.ok_resp);
            bins addr_wdata_rand   = binsof(waddr.addr_all)  && binsof(wdata.rand_val) && binsof(wresp.ok_resp);
            bins rand_add_err      = binsof(waddr.rand_addr) && binsof(wresp.slv_err)  && binsof(wdata.rand_val);
            // bins rand_add_err      = (!binsof(waddr.rand_addr) intersect {'h00, 'h04, 'h08, 'h0C, 'h10,
                                                                                // 'h14,'h20, 'h30, 'h34, 'h38, 'h3C,
                                                                                // 'h50,'h54, 'h58, 'h5C, 'h60, 'h64}) && binsof(wresp.slv_err)  && binsof(wdata.rand_val);
            ignore_bins ignore_0   = binsof(waddr.rand_addr) intersect {'h00, 'h04, 'h08, 'h0C, 'h10,
                                                                        'h14,'h20, 'h30, 'h34, 'h38, 'h3C,
                                                                        'h50,'h54, 'h58, 'h5C, 'h60, 'h64};
            ignore_bins ignore_1   = binsof(waddr.addr_all) && binsof(wresp.slv_err);
        } 
    endgroup : axi4lite_write_cg

    // Covergroup for READ
    covergroup axi4lite_read_cg;
        raddr: coverpoint axi4_tr.s_axi_ctrl_araddr {                           // Register addresses
            bins addr_all[] = {'h00, 'h04, 'h08, 'h0C, 'h10, 'h14, 
                                'h20, 'h30, 'h34, 'h38, 'h3C, 'h50, 
                                'h54, 'h58, 'h5C, 'h60, 'h64};
            // Define an invalid address that is not in the valid address set
           bins rand_addr  = {[0:$]};
        }
        rdata: coverpoint axi4_tr.s_axi_ctrl_rdata {                            // Data values read
            bins all_values = {[0:$]};
        }
        rresp: coverpoint axi4_tr.s_axi_ctrl_rresp {                            // Read response
            bins ok_resp = {2'b00};
            bins slv_err = {2'b10};
        }
        raddr_x_rresp: cross raddr, rresp{
                    bins addr_rresp_ok  = binsof(raddr.addr_all) && binsof(rresp.ok_resp);

                    ignore_bins ignore_1  = binsof(raddr.addr_all) && binsof(rresp.slv_err);
                    ignore_bins ignore_2  = binsof(raddr.rand_addr) && binsof(rresp.slv_err);

        }
        rand_raddr_x_rresp: cross raddr, rresp{
            bins addr_rresp_err = binsof(raddr.rand_addr) && binsof(rresp.slv_err);
            // bins addr_rresp_err = (!binsof(raddr.rand_addr) intersect {'h00, 'h04, 'h08, 'h0C, 'h10,
                                                                        // 'h14,'h20, 'h30, 'h34, 'h38, 'h3C,
                                                                        //  'h50,'h54, 'h58, 'h5C, 'h60, 'h64}) && binsof(rresp.slv_err);
            ignore_bins ignore_0  = binsof(raddr.rand_addr) intersect {'h00, 'h04, 'h08, 'h0C, 'h10,
                                                                        'h14,'h20, 'h30, 'h34, 'h38, 'h3C,
                                                                        'h50,'h54, 'h58, 'h5C, 'h60, 'h64};
            ignore_bins ignore_1  = binsof(raddr.rand_addr) && binsof(rresp.ok_resp);
            ignore_bins ignore_2  = binsof(raddr.addr_all) && binsof(rresp.slv_err);
            ignore_bins ignore_3  = binsof(raddr.addr_all) && binsof(rresp.ok_resp);
}
    endgroup : axi4lite_read_cg

    // Covergroup handshake signals

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
    // Write Method
    function void write(i2s_tx_axi4_lite_seq_item t);
        axi4_tr = t;
        axi4lite_write_cg.sample();
        axi4lite_protocol_cg.sample();
        axi4lite_read_cg.sample();
    endfunction

endclass: axi4_coverage

// Class :: AXI-Stream Coverage
class axi_stream_coverage extends uvm_subscriber #(i2s_tx_axis_seq_item);
    `uvm_component_utils(axi_stream_coverage)

    // Handle of axi-stream transaction
    i2s_tx_axis_seq_item        axis_tr;

    // Covergroup for bits of tdata
    covergroup axi_stream_data_cg;
        coverpoint axis_tr.s_axis_aud_tdata[27:4] {                     // Audio sample data range
            bins valid_data = {[0:$]}; // 24-bit signed range
        }
        parity: coverpoint axis_tr.s_axis_aud_tdata[31] {                       // Parity bit
            bins parity_values[] = {1'b0, 1'b1};
        }
        chan_stat: coverpoint axis_tr.s_axis_aud_tdata[30] {                       // Channel Status bit
            bins channel_status[] = {1'b0, 1'b1};
        }
        valid_bit: coverpoint axis_tr.s_axis_aud_tdata[28] {                       // Validity bit
            bins validity_bit[] = {1'b0, 1'b1};
        }
        user_bit :coverpoint axis_tr.s_axis_aud_tdata[29] {                       // User bit
            bins user_bit[] = {1'b0, 1'b1};
        }
        preamble: coverpoint axis_tr.s_axis_aud_tdata[3:0] {                      // Preamble
            bins preamble_all[] = {4'b0001, 4'b0010, 4'b0011};
        }
        cross preamble, parity, chan_stat, valid_bit; // Cross-coverage of preamble and control bits
    endgroup : axi_stream_data_cg

    // Cover group for handshake
    covergroup axi_stream_protocol_cg;
        axis_valid: coverpoint axis_tr.s_axis_aud_tvalid;                           // Valid signal
        axis_ready: coverpoint axis_tr.s_axis_aud_tready;                           // Ready signal
        cross axis_valid, axis_ready;                       // Handshake cross-coverage
    endgroup : axi_stream_protocol_cg

    // Cover group for tid
    covergroup axi_stream_tid_cg;
        coverpoint axis_tr.s_axis_aud_tid {                             // Transaction ID for multi-channel
            bins channel_ids[] = {3'b000, 3'b001};
        }
    endgroup : axi_stream_tid_cg

    // Constructor
    function new( string name , uvm_component parent);
        super.new( name , parent );
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