`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.04.2026 20:20:10
// Design Name: 
// Module Name: baud_rate_gen
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
