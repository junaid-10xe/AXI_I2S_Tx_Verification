#!/bin/bash
# ****************************************************************************
# Author: Muhammad Junaid
# Date: January 21, 2025
# Description: This script merges individual coverage databases into a 
#              single merged coverage database and generates a coverage report.
# ****************************************************************************


# Variables
COV_DIR="Coverage/xsim.covdb"                                # Base directory for individual coverage databases
MERGE_DIR="./coverage_merged"                                # Directory for merged coverage database
REPORT_DIR="./coverage_report"                               # Directory for coverage report
MERGE_DB_NAME="merged_coverage"                              # Name for the merged database

# Ensure required directories exist
mkdir -p "$MERGE_DIR"
mkdir -p "$REPORT_DIR"

# List of coverage databases to merge
COVERAGE_DATABASES=(
  "ral_test"
  "axis_tvalid_test"
  "axis_valid_bit_low_test"
  "axis_valid_bit_hi_test"
  "validity_reg_test"
  "sanity_test"
  "left_just_test"
  "right_just_test"
  "intrpt_ctrl_test"
  "intrpt_stat_test"
  "rand_reg_test"
  "rand_axis_test"
)

# Initialize merge command
MERGE_CMD="xcrg"

# Loop through each test's coverage database
for DB_NAME in "${COVERAGE_DATABASES[@]}"; do
    DB_PATH="$COV_DIR/$DB_NAME"
    if [ -d "$DB_PATH" ]; then
        echo "Including coverage database: $DB_PATH"
        MERGE_CMD+=" -dir $DB_PATH -db_name $DB_NAME"
    else
        echo "Warning: Coverage directory $DB_PATH not found. Skipping..."
    fi
done

# Add merge and report options
MERGE_CMD+=" -merge_dir $MERGE_DIR -merge_db_name $MERGE_DB_NAME -report_dir $REPORT_DIR"

# Execute the merge command
echo "Merging coverage databases..."
echo "Command: $MERGE_CMD"
eval "$MERGE_CMD"

# Check if the merge was successful
if [ $? -eq 0 ]; then
    echo "Coverage merge completed successfully."
    echo "Merged database: $MERGE_DIR/$MERGE_DB_NAME"
    echo "Coverage report: $REPORT_DIR"
else
    echo "Error: Coverage merge failed."
    exit 1
fi

