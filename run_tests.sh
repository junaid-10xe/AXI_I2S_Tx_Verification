#!/bin/bash
# ****************************************************************************
# Script to run simulation tests using make and test names
# Author: Muhammad Junaid
# Date: January 17, 2025
# ****************************************************************************

# List of test names
TEST_NAMES=(
  "ral_test"
  "axi_rst_test"
  "core_ver_test"
  "core_cfg_test"
  "core_en_test"
  "rand_reg_test"
  "axis_tvalid_test"
  "axis_valid_bit_low_test"
  "axis_valid_bit_hi_test"
  "validity_reg_test"
  "sanity_test"
  "left_just_test"
  "right_just_test"
  "intrpt_ctrl_test"
  "intrpt_stat_test"
  "rand_axis_test"
  "sck_freq4_test"
  "sck_freq2_test"
  "sck_freq3_test"
  "aes_intrpt_test"
)

# Iterate over test names and run make simulate for each
for TEST in "${TEST_NAMES[@]}"; do
  echo "Running simulation for test: $TEST"
  
  # Run make simulate with the test name
  make simulate TEST="$TEST"
  
  # Check the exit status of make
  if [ $? -ne 0 ]; then
    echo "Simulation failed for test: $TEST"
    exit 1
  else
    echo "Simulation completed successfully for test: $TEST"
  fi
done

echo "All tests executed successfully!"

