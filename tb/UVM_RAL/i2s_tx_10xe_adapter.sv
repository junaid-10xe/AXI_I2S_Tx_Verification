/*************************************************************************
   > File Name: i2s_tx_10xe_adapter.sv
   > Description: This file contains adapter class which is consist of two functions reg2bus and bus2reg.
   > Author: Muhammad Junaid Ramzan
   > Modified: Muhammad Junaid Ramzan
   > Mail: muhammad.junaid@10xengineers.ai
   ---------------------------------------------------------------
   Copyright   (c)2024 10xEngineers
   ---------------------------------------------------------------
************************************************************************/
`ifndef I2S_TX_10XE_ADAPTER
`define I2S_TX_10XE_ADAPTER
//Class: i2s_tx_10xe_adapter
//Description: Contains two function reg2bus and bus2reg to conver bus txn to reg txn and reg txn to bus txn

class i2s_tx_10xe_adapter extends uvm_reg_adapter;
    //factory registration
    `uvm_object_utils(i2s_tx_10xe_adapter)
    //Constructor
    function new(string name = "i2s_tx_10xe_adapter");
        super.new(name);
    endfunction

    //Function to convert reg txn to bus txn
    function uvm_sequence_item reg2bus(const ref uvm_reg_bus_op rw);
        i2s_tx_10xe_axi4_lite_seq_item tr;
        //Create a i2s_tx_10xe_axi4_lite_seq_item
        tr = i2s_tx_10xe_axi4_lite_seq_item::type_id::create("tr");
        //Assign values to i2s_tx_10xe_axi4_lite_seq_item
        tr.s_axi_ctrl_awvalid = (rw.kind == UVM_WRITE) ? 1'b1 :1'b0;
        tr.s_axi_ctrl_arvalid = (rw.kind == UVM_READ) ? 1'b1 :1'b0;
        //For write 
        if(tr.s_axi_ctrl_awvalid) begin
            tr.s_axi_ctrl_awaddr = rw.addr;            
            tr.s_axi_ctrl_wdata  = rw.data;
        end
        //For read
        if(tr.s_axi_ctrl_arvalid) begin
            tr.s_axi_ctrl_araddr = rw.addr;
        end
        return tr;
    endfunction

    //Function to convert bus txn to reg txn
    function void bus2reg(uvm_sequence_item bus_item, ref uvm_reg_bus_op rw);
        i2s_tx_10xe_axi4_lite_seq_item tr;
        assert($cast(tr, bus_item));
        // for write
        if (tr.s_axi_ctrl_awvalid) begin
            rw.kind = UVM_WRITE;
            rw.addr = tr.s_axi_ctrl_awaddr;
            rw.data = tr.s_axi_ctrl_wdata;
            if(tr.s_axi_ctrl_bresp == 00) begin
                rw.status = UVM_IS_OK;
            end
            else rw.status = UVM_NOT_OK;
        end
        // for read
        else if (tr.s_axi_ctrl_arvalid) begin
            rw.kind = UVM_READ;
            rw.addr = tr.s_axi_ctrl_araddr;
            rw.data = tr.s_axi_ctrl_rdata;
            if(tr.s_axi_ctrl_rresp == 00) begin
                rw.status = UVM_IS_OK;        
            end
            else begin
                rw.status = UVM_NOT_OK;
            end
        end
    endfunction

endclass

`endif