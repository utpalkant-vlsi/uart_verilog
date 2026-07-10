# UART Controller in Verilog

A configurable Universal Asynchronous Receiver-Transmitter (UART) digital design implemented and verified in Verilog HDL using Xilinx Vivado.

## 📌 Architecture & Features
* **Baud Rate Generator:** Divides the system clock to generate precise timing ticks for transmission and reception.
* **Transmitter (Sender):** Accepts parallel data and transmits it serially over the `TX` line with appropriate start and stop bits.
* **Receiver:** Samples incoming data on the `RX` line and converts serial streams back into parallel data.
* **Top Module:** Connects the sub-modules together into an integrated hardware module.

## 📁 Project Structure
* `sources_1/new/uart_top.v` - Main top-level module
* `sources_1/new/baud_rate_gen.v` - Clock divider / baud generator
* `sources_1/new/uart_sender.v` - Serial transmitter
* `sources_1/new/uart_receiver.v` - Serial receiver
* `sim_1/new/uart_tb.v` - Testbench wrapper used for simulation

## 🛠️ Tools Used
* **IDE/Toolchain:** Xilinx Vivado
* **Language:** Verilog HDL
