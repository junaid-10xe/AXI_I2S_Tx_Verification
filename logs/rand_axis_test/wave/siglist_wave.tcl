# Author: Muhammad Junaid
# Date: January 20, 2025
# Description: TCL script to add specified signals to GTKWave using gtkwave::addSignalsFromList method.


# Signal addition commands using gtkwave::addSignalsFromList
# AXI4-Lite signals
gtkwave::addSignalsFromList i2s_tx_tb_top.DUT.s_axi_ctrl_aclk
gtkwave::addSignalsFromList i2s_tx_tb_top.DUT.s_axi_ctrl_aresetn

# For Write
gtkwave::addSignalsFromList i2s_tx_tb_top.DUT.s_axi_ctrl_awaddr
gtkwave::addSignalsFromList i2s_tx_tb_top.DUT.s_axi_ctrl_awvalid
gtkwave::addSignalsFromList i2s_tx_tb_top.DUT.s_axi_ctrl_awready
gtkwave::addSignalsFromList i2s_tx_tb_top.DUT.s_axi_ctrl_wdata
gtkwave::addSignalsFromList i2s_tx_tb_top.DUT.s_axi_ctrl_wvalid
gtkwave::addSignalsFromList i2s_tx_tb_top.DUT.s_axi_ctrl_wready
gtkwave::addSignalsFromList i2s_tx_tb_top.DUT.s_axi_ctrl_bready
gtkwave::addSignalsFromList i2s_tx_tb_top.DUT.s_axi_ctrl_bvalid
gtkwave::addSignalsFromList i2s_tx_tb_top.DUT.s_axi_ctrl_bresp

# For Read
gtkwave::addSignalsFromList i2s_tx_tb_top.DUT.s_axi_ctrl_araddr
gtkwave::addSignalsFromList i2s_tx_tb_top.DUT.s_axi_ctrl_arvalid
gtkwave::addSignalsFromList i2s_tx_tb_top.DUT.s_axi_ctrl_arready
gtkwave::addSignalsFromList i2s_tx_tb_top.DUT.s_axi_ctrl_rvalid
gtkwave::addSignalsFromList i2s_tx_tb_top.DUT.s_axi_ctrl_rready
gtkwave::addSignalsFromList i2s_tx_tb_top.DUT.s_axi_ctrl_rdata
gtkwave::addSignalsFromList i2s_tx_tb_top.DUT.s_axi_ctrl_rresp

# AXI-Stream Signals
gtkwave::addSignalsFromList i2s_tx_tb_top.DUT.s_axis_aud_aclk
gtkwave::addSignalsFromList i2s_tx_tb_top.DUT.s_axis_aud_aresetn
gtkwave::addSignalsFromList i2s_tx_tb_top.DUT.s_axis_aud_tdata
gtkwave::addSignalsFromList i2s_tx_tb_top.DUT.s_axis_aud_tid
gtkwave::addSignalsFromList i2s_tx_tb_top.DUT.s_axis_aud_tvalid
gtkwave::addSignalsFromList i2s_tx_tb_top.DUT.s_axis_aud_tready

#Other DUT Signals and outputs
gtkwave::addSignalsFromList i2s_tx_tb_top.DUT.aud_mclk
gtkwave::addSignalsFromList i2s_tx_tb_top.DUT.aud_mrst
gtkwave::addSignalsFromList i2s_tx_tb_top.DUT.sclk_out
gtkwave::addSignalsFromList i2s_tx_tb_top.DUT.lrclk_out
gtkwave::addSignalsFromList i2s_tx_tb_top.DUT.sdata_0_out
gtkwave::addSignalsFromList i2s_tx_tb_top.DUT.irq






