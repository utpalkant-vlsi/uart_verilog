`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
Company: National Institute of Technology, Patna.
// Engineer: Utpal Kant
// 
// Create Date: 01.01.2026 14:49:10
// Design Name: uart
// Module Name: uart_top
// Project Name: uart_Design
// Target Devices: Basys3 FPGA
// Tool Versions:Vivado 2024.2 
// Description: Top-level wrapper module that instantiates and interconnects the baud rate generator,
//               the UART transmitter (sender), and the UART receiver into a unified system interface.
// Dependencies: uart.v
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
// 
//////////////////////////////////////////////////////////////////////////////////


module uart_top(
input rst,input [7:0] data_in,input wr_enb,clk,redy_clr,output rdy,busy,output [7:0] data_out
    );
    
wire rx_clk_enb;
wire tx_clk_enb;
wire tx_temp;

baud_rate_gen bg(clk,rx_clk_enb,tx_clk_enb);
uart_sender us(clk,wr_enb,tx_clk_enb,rst,data_in,tx_temp,busy);
uart_receiver ur(clk,rst,tx_temp,rdy_clr,rx_clk_enb,rdy,data_out);

endmodule
