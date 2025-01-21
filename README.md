# AXI-I2S Transmitter Verification Environment

This repository provides a comprehensive UVM-based verification environment for the AXI-I2S Transmitter, ensuring functionality, protocol compliance, and performance validation. The environment supports both AXI4-Lite (for register access) and AXI-Stream (for data streaming) interfaces.

---

## **Architecture Overview**

The verification architecture includes the following components:
- **Testbench Top:** Orchestrates interactions between the DUT and verification components.
- **AXI4-Lite Agent:** Handles configuration and register-level transactions.
- **AXI-Stream Agent:** Manages high-speed streaming data transactions.
- **I2S Agent:** Monitors and verifies I2S-specific output signals (`SCLK`, `LRCLK`, and `SDATA`).
- **Scoreboard:** Compares DUT outputs with expected results.
- **Coverage:** Tracks functional and protocol coverage for AXI4-Lite and AXI-Stream interfaces.
- **Environment Class:** Sets up and integrates agents, monitors, coverage, and scoreboard.
- **Test Sequences:** Provides stimulus for functional and directed scenarios.

![Verification Architecture](docs/architecture_diagram.png)  
*Image: AXI-I2S Transmitter Verification Architecture*

---

## **Setup Instructions**

### **Prerequisites**
1. **Vivado Design Suite:** Ensure Vivado is installed and accessible in your system's PATH.
2. **Clone the Repository:**  
   ```bash
   git clone <repository_url>
   cd <repository_directory>

