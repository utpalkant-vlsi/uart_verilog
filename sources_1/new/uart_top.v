`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.04.2026 11:27:43
// Design Name: 
// Module Name: uart_top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
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
