-makelib xcelium_lib/xilinx_vip -sv \
  "/home/lpt-10xe/Vivado/Vivado/2022.1/data/xilinx_vip/hdl/axi4stream_vip_axi4streampc.sv" \
  "/home/lpt-10xe/Vivado/Vivado/2022.1/data/xilinx_vip/hdl/axi_vip_axi4pc.sv" \
  "/home/lpt-10xe/Vivado/Vivado/2022.1/data/xilinx_vip/hdl/xil_common_vip_pkg.sv" \
  "/home/lpt-10xe/Vivado/Vivado/2022.1/data/xilinx_vip/hdl/axi4stream_vip_pkg.sv" \
  "/home/lpt-10xe/Vivado/Vivado/2022.1/data/xilinx_vip/hdl/axi_vip_pkg.sv" \
  "/home/lpt-10xe/Vivado/Vivado/2022.1/data/xilinx_vip/hdl/axi4stream_vip_if.sv" \
  "/home/lpt-10xe/Vivado/Vivado/2022.1/data/xilinx_vip/hdl/axi_vip_if.sv" \
  "/home/lpt-10xe/Vivado/Vivado/2022.1/data/xilinx_vip/hdl/clk_vip_if.sv" \
  "/home/lpt-10xe/Vivado/Vivado/2022.1/data/xilinx_vip/hdl/rst_vip_if.sv" \
-endlib
-makelib xcelium_lib/xpm -sv \
  "/home/lpt-10xe/Vivado/Vivado/2022.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
  "/home/lpt-10xe/Vivado/Vivado/2022.1/data/ip/xpm/xpm_fifo/hdl/xpm_fifo.sv" \
  "/home/lpt-10xe/Vivado/Vivado/2022.1/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
-endlib
-makelib xcelium_lib/xpm \
  "/home/lpt-10xe/Vivado/Vivado/2022.1/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib xcelium_lib/i2s_transmitter_v1_0_5 -sv \
  "../../../ipstatic/hdl/i2s_transmitter_v1_0_rfs.sv" \
-endlib
-makelib xcelium_lib/xil_defaultlib -sv \
  "../../../../I2S_IP.gen/sources_1/ip/i2s_transmitter_0/sim/i2s_transmitter_0.sv" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  glbl.v
-endlib

