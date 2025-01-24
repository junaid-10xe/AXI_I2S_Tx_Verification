# Makefile for Vivado Simulation with +UVM_TESTNAME
# Author: Muhammad Junaid
# Date: January 3, 2025

# Paths
SRC_DIR   = dut/I2S_IP
PRJ_FILE  = $(SRC_DIR)/i2s_tx_tb_top_vlog.prj
TCL_BATCH = $(SRC_DIR)/i2s_tx_tb_top.tcl
WCFG_FILE = $(SRC_DIR)/i2s_tx_10xe_tb_top_behav.wcfg

# Default Test Name (can be overridden via command line)
TEST 	  ?= sanity_test
#Verbosity 
VERBOSITY ?= UVM_LOW 
LOG_DIR    = logs/$(TEST)
WAV_DIR	   = $(LOG_DIR)/wave
# Coverage Directory and Database
COV_DIR = Coverage
# Flags
XVLOG_FLAGS = --incr --relax -L uvm -L i2s_transmitter_v1_0_5 -L uvm -prj
XELAB_FLAGS = --incr --debug typical --relax --mt 8 \
              -cov_db_name $(TEST) -cov_db_dir $(COV_DIR)\
              -L xil_defaultlib -L i2s_transmitter_v1_0_5 -L uvm \
              -L unisims_ver -L unimacro_ver -L secureip -L xpm
XSIM_FLAGS = -key {Behavioral:sim_1:Functional:i2s_tx_tb_top}

# Targets
all: compile elaborate simulate

# Create log directory if it doesn't exist
$(LOG_DIR):
	@mkdir -p $(LOG_DIR)
# Compile
compile: $(LOG_DIR)
	@echo "Compiling design sources..."
	xvlog $(XVLOG_FLAGS) -prj $(PRJ_FILE) 2>&1 | tee $(LOG_DIR)/compile.log
	@echo "Compilation completed successfully."

# Elaborate
elaborate: compile
	@echo "Elaborating design..."
	xelab $(XELAB_FLAGS) --snapshot i2s_tx_tb_top_behav xil_defaultlib.i2s_tx_tb_top \
	xil_defaultlib.glbl -log $(LOG_DIR)/elaborate.log -L uvm
	@echo "Elaboration completed successfully."

# Simulate with +UVM_TESTNAME
simulate: elaborate
	@echo "Simulating design with UVM test: $(TEST)..."
	xsim i2s_tx_tb_top_behav $(XSIM_FLAGS) \
	-tclbatch $(TCL_BATCH) \
	-view $(WCFG_FILE) \
	-log $(LOG_DIR)/simulate.log -testplusarg UVM_VERBOSITY=$(VERBOSITY) -testplusarg UVM_TESTNAME=$(TEST)
	mkdir -p $(WAV_DIR)
	cp  *.wdb *.vcd *.wcfg siglist_wave.tcl $(WAV_DIR)
	@echo "Simulation completed successfully with test: $(TEST)."

# Clean logs and other generated files
clean:
	@echo "Cleaning up..."
	rm -rf ./xsim.dir ./webtalk*.jou *.log *.pb *.wdb *.jou *.vcd
	@echo "Cleanup completed."

.PHONY: all compile elaborate simulate clean
