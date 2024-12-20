#!/bin/bash -f
# ****************************************************************************
# Vivado (TM) v2022.1 (64-bit)
#
# Filename    : elaborate.sh
# Simulator   : Xilinx Vivado Simulator
# Description : Script for elaborating the compiled design
#
# Generated by Vivado on Fri Dec 20 16:17:04 PKT 2024
# SW Build 3526262 on Mon Apr 18 15:47:01 MDT 2022
#
# IP Build 3524634 on Mon Apr 18 20:55:01 MDT 2022
#
# usage: elaborate.sh
#
# ****************************************************************************
set -Eeuo pipefail
# elaborate design
echo "xelab --incr --debug typical --relax --mt 8 -L xil_defaultlib -L i2s_transmitter_v1_0_5 -L uvm -L unisims_ver -L unimacro_ver -L secureip -L xpm --snapshot i2s_tx_10xe_tb_top_behav xil_defaultlib.i2s_tx_10xe_tb_top xil_defaultlib.glbl -log elaborate.log -L uvm"
xelab --incr --debug typical --relax --mt 8 -L xil_defaultlib -L i2s_transmitter_v1_0_5 -L uvm -L unisims_ver -L unimacro_ver -L secureip -L xpm --snapshot i2s_tx_10xe_tb_top_behav xil_defaultlib.i2s_tx_10xe_tb_top xil_defaultlib.glbl -log elaborate.log -L uvm

