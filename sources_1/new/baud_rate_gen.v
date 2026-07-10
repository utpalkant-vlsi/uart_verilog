`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: National Institue of Technology, Patna.
// Engineer: Utpal Kant
// 
// Create Date: 01.01.2026 14:49:10
// Design Name: uart
// Module Name: baud_rate_gen
// Project Name: uart_Design
// Target Devices: Basys3 FPGA
// Tool Versions:Vivado 2024.2 
// Description: Generates the precise clock enable ticks required for the transmitter (tx_enb) 
//              and receiver (rx_enb). It divides down the main system clock to establish accurate
//              synchronization for asynchronous serial communication based on the target baud rate.
// Dependencies: uart.v
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module baud_rate_gen(
input clk,
output rx_enb,tx_enb
    );
reg[12:0]tx_counter;
reg[9:0]rx_counter;

always@(posedge clk) 
      begin
            if(rx_counter == 325)
                  rx_counter = 0;
            else 
                   rx_counter = rx_counter + 1'b1;
       end
       
 always@(posedge clk) 
       begin
             if(tx_counter == 5208)
                   tx_counter = 0;
             else
                    tx_counter = tx_counter + 1'b1;
       end
       
assign  tx_enb =  (tx_counter==0)?1:0;
assign  rx_enb =  (rx_counter ==0)?1:0;   
endmodule
