#!/bin/bash -f
# ****************************************************************************
# Vivado (TM) v2022.1 (64-bit)
#
# Filename    : simulate.sh
# Simulator   : Xilinx Vivado Simulator
# Description : Script for simulating the design by launching the simulator
#
# Generated by Vivado on Thu Dec 19 17:01:29 PKT 2024
# SW Build 3526262 on Mon Apr 18 15:47:01 MDT 2022
#
# IP Build 3524634 on Mon Apr 18 20:55:01 MDT 2022
#
# usage: simulate.sh
#
# ****************************************************************************
set -Eeuo pipefail
# simulate design
echo "xsim i2s_tx_10xe_tb_top_behav -key {Behavioral:sim_1:Functional:i2s_tx_10xe_tb_top} -tclbatch i2s_tx_10xe_tb_top.tcl -view /home/lpt-10xe/10xTraining/TCP/dut/I2S_IP/i2s_tx_10xe_tb_top_behav.wcfg -log simulate.log"
xsim i2s_tx_10xe_tb_top_behav -key {Behavioral:sim_1:Functional:i2s_tx_10xe_tb_top} -tclbatch i2s_tx_10xe_tb_top.tcl -view /home/lpt-10xe/10xTraining/TCP/dut/I2S_IP/i2s_tx_10xe_tb_top_behav.wcfg -log simulate.log

