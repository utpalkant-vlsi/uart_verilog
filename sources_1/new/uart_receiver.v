//////////////////////////////////////////////////////////////////////////////////
// Company: National Institute of Technology, Patna.
// Engineer: Utpal Kant
// 
// Create Date: 01.01.2026 14:49:10
// Design Name: uart
// Module Name: uart_receiver
// Project Name: uart_Design
// Target Devices: Basys3 FPGA
// Tool Versions:Vivado 2024.2 
// Description: Samples incoming asynchronous serial data from the RX line.
//              It detects the start bit, samples consecutive data bits based on the receiver clock enable tick,
//              verifies the stop bit, and outputs the reconstructed parallel byte along with a data-ready flag..
// Dependencies: uart.v
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//////////////////////////////////////////////////////////////////////////////////


module uart_receiver(
input clk,rst,rdy_clr,clk_enb,rx,
output reg rdy,
output reg [7:0] data_out
    );
parameter start_state = 2'b00;
parameter data_out_state = 2'b01;
parameter stop_state = 2'b10;

reg[1:0]state = start_state;
reg[3:0]sample = 0;
reg[2:0]index = 0;
reg[7:0] temp_register = 8'b0;

always@(posedge clk)
            begin
                 if(rst) 
                       begin
                           rdy = 0;
                           data_out = 0;
                       end
             end
             
always@(posedge clk)
            begin
                 if(rdy_clr)
                       rdy <=0;
                       
                  if(clk_enb)
               case(state) 
                           start_state :
                                         begin
                                              if(rx == 0 && sample !=0)
                                                  sample <= sample+1'b1;
                                               if(sample == 15) 
                                                       begin 
                                                           state <= data_out_state;
                                                           sample <=0;
                                                           index<=0;
                                                           temp_register<=0;
                                                        
                                         end                end
                             data_out_state :
                                             begin
                                                 sample <= sample+1'b1;
                                                      if(sample ==4'h8)
                                                          begin
                                                              temp_register[index]<=rx;
                                                              index<= index+1'b1;
                                                           end
                                                      if(index == 8 && sample ==15)
                                                         state <= stop_state;
                                              end
                             stop_state:
                                       begin
                                           if(sample == 15)
                                                begin 
                                                     state <= start_state;
                                                     data_out <= temp_register;
                                                     rdy <= 1'b1;
                                                     sample <= 0;
                                                 end
                                            else 
                                                sample = sample +1'b1;
                                        end
                    default:
                           begin
                               state <= start_state;
                            end
         endcase
     end
 endmodule
                                                  
               
