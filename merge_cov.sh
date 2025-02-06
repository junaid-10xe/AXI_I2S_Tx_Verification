#!/bin/bash
# ****************************************************************************
# Author: Muhammad Junaid
# Date: January 21, 2025
# Description: This script dynamically merges individual coverage databases 
#              from a directory into a single merged coverage database and 
#              generates a coverage report.
# ****************************************************************************

# Variables
COV_DIR="Coverage/xsim.covdb"            # Base directory containing individual coverage databases
MERGE_DIR="./Coverage/coverage_merged"            # Directory for merged coverage database
REPORT_DIR="./Coverage/coverage_report"           # Directory for coverage report
MERGE_DB_NAME="merged_coverage"          # Name for the merged database

# Ensure required directories exist
mkdir -p "$MERGE_DIR"
mkdir -p "$REPORT_DIR"

# Initialize merge command
MERGE_CMD="xcrg"

# Iterate over subdirectories in the coverage directory
for DB_PATH in "$COV_DIR"/*; do
    if [ -d "$DB_PATH" ]; then
        DB_NAME=$(basename "$DB_PATH")  # Extract the folder name
        echo "Including coverage database: $DB_PATH"
        MERGE_CMD+=" -dir $DB_PATH -db_name $DB_NAME"
    else
        echo "Warning: No coverage directories found in $COV_DIR. Skipping..."
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

