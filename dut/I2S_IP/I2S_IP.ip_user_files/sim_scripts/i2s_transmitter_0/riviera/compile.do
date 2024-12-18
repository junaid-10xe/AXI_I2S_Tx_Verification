vlib work
vlib riviera

vlib riviera/xilinx_vip
vlib riviera/xpm
vlib riviera/i2s_transmitter_v1_0_5
vlib riviera/xil_defaultlib

vmap xilinx_vip riviera/xilinx_vip
vmap xpm riviera/xpm
vmap i2s_transmitter_v1_0_5 riviera/i2s_transmitter_v1_0_5
vmap xil_defaultlib riviera/xil_defaultlib

vlog -work xilinx_vip  -sv2k12 "+incdir+/home/lpt-10xe/Vivado/Vivado/2022.1/data/xilinx_vip/include" \
"/home/lpt-10xe/Vivado/Vivado/2022.1/data/xilinx_vip/hdl/axi4stream_vip_axi4streampc.sv" \
"/home/lpt-10xe/Vivado/Vivado/2022.1/data/xilinx_vip/hdl/axi_vip_axi4pc.sv" \
"/home/lpt-10xe/Vivado/Vivado/2022.1/data/xilinx_vip/hdl/xil_common_vip_pkg.sv" \
"/home/lpt-10xe/Vivado/Vivado/2022.1/data/xilinx_vip/hdl/axi4stream_vip_pkg.sv" \
"/home/lpt-10xe/Vivado/Vivado/2022.1/data/xilinx_vip/hdl/axi_vip_pkg.sv" \
"/home/lpt-10xe/Vivado/Vivado/2022.1/data/xilinx_vip/hdl/axi4stream_vip_if.sv" \
"/home/lpt-10xe/Vivado/Vivado/2022.1/data/xilinx_vip/hdl/axi_vip_if.sv" \
"/home/lpt-10xe/Vivado/Vivado/2022.1/data/xilinx_vip/hdl/clk_vip_if.sv" \
"/home/lpt-10xe/Vivado/Vivado/2022.1/data/xilinx_vip/hdl/rst_vip_if.sv" \

vlog -work xpm  -sv2k12 "+incdir+/home/lpt-10xe/Vivado/Vivado/2022.1/data/xilinx_vip/include" \
"/home/lpt-10xe/Vivado/Vivado/2022.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"/home/lpt-10xe/Vivado/Vivado/2022.1/data/ip/xpm/xpm_fifo/hdl/xpm_fifo.sv" \
"/home/lpt-10xe/Vivado/Vivado/2022.1/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -93 \
"/home/lpt-10xe/Vivado/Vivado/2022.1/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work i2s_transmitter_v1_0_5  -sv2k12 "+incdir+/home/lpt-10xe/Vivado/Vivado/2022.1/data/xilinx_vip/include" \
"../../../ipstatic/hdl/i2s_transmitter_v1_0_rfs.sv" \

vlog -work xil_defaultlib  -sv2k12 "+incdir+/home/lpt-10xe/Vivado/Vivado/2022.1/data/xilinx_vip/include" \
"../../../../I2S_IP.gen/sources_1/ip/i2s_transmitter_0/sim/i2s_transmitter_0.sv" \

vlog -work xil_defaultlib \
"glbl.v"

