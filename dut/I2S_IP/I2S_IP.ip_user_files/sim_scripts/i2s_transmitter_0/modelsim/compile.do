vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/xilinx_vip
vlib modelsim_lib/msim/xpm
vlib modelsim_lib/msim/i2s_transmitter_v1_0_5
vlib modelsim_lib/msim/xil_defaultlib

vmap xilinx_vip modelsim_lib/msim/xilinx_vip
vmap xpm modelsim_lib/msim/xpm
vmap i2s_transmitter_v1_0_5 modelsim_lib/msim/i2s_transmitter_v1_0_5
vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib

vlog -work xilinx_vip -64 -incr -mfcu -sv -L i2s_transmitter_v1_0_5 "+incdir+/home/lpt-10xe/Vivado/Vivado/2022.1/data/xilinx_vip/include" \
"/home/lpt-10xe/Vivado/Vivado/2022.1/data/xilinx_vip/hdl/axi4stream_vip_axi4streampc.sv" \
"/home/lpt-10xe/Vivado/Vivado/2022.1/data/xilinx_vip/hdl/axi_vip_axi4pc.sv" \
"/home/lpt-10xe/Vivado/Vivado/2022.1/data/xilinx_vip/hdl/xil_common_vip_pkg.sv" \
"/home/lpt-10xe/Vivado/Vivado/2022.1/data/xilinx_vip/hdl/axi4stream_vip_pkg.sv" \
"/home/lpt-10xe/Vivado/Vivado/2022.1/data/xilinx_vip/hdl/axi_vip_pkg.sv" \
"/home/lpt-10xe/Vivado/Vivado/2022.1/data/xilinx_vip/hdl/axi4stream_vip_if.sv" \
"/home/lpt-10xe/Vivado/Vivado/2022.1/data/xilinx_vip/hdl/axi_vip_if.sv" \
"/home/lpt-10xe/Vivado/Vivado/2022.1/data/xilinx_vip/hdl/clk_vip_if.sv" \
"/home/lpt-10xe/Vivado/Vivado/2022.1/data/xilinx_vip/hdl/rst_vip_if.sv" \

vlog -work xpm -64 -incr -mfcu -sv -L i2s_transmitter_v1_0_5 "+incdir+/home/lpt-10xe/Vivado/Vivado/2022.1/data/xilinx_vip/include" \
"/home/lpt-10xe/Vivado/Vivado/2022.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"/home/lpt-10xe/Vivado/Vivado/2022.1/data/ip/xpm/xpm_fifo/hdl/xpm_fifo.sv" \
"/home/lpt-10xe/Vivado/Vivado/2022.1/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -64 -93 \
"/home/lpt-10xe/Vivado/Vivado/2022.1/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work i2s_transmitter_v1_0_5 -64 -incr -mfcu -sv -L i2s_transmitter_v1_0_5 "+incdir+/home/lpt-10xe/Vivado/Vivado/2022.1/data/xilinx_vip/include" \
"../../../ipstatic/hdl/i2s_transmitter_v1_0_rfs.sv" \

vlog -work xil_defaultlib -64 -incr -mfcu -sv -L i2s_transmitter_v1_0_5 "+incdir+/home/lpt-10xe/Vivado/Vivado/2022.1/data/xilinx_vip/include" \
"../../../../I2S_IP.gen/sources_1/ip/i2s_transmitter_0/sim/i2s_transmitter_0.sv" \

vlog -work xil_defaultlib \
"glbl.v"

