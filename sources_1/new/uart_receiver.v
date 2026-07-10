module uart_tb;
reg clk,rst;
reg[7:0] data_in;
reg wr_enb;
wire rdy;
reg rdy_clr;
wire[7:0]dout;
wire busy;
uart_top ut(rst,data_in,wr_enb,clk,rdy_clr,rdy,busy,data_out);

initial begin
{clk,rst,data_in,rdy_clr}=0;
end
always #5 clk = ~clk;

task send_byte(input[7:0]din);
begin 
@(negedge clk);
data_in = din;
wr_enb = 1'b1;

@(negedge clk)
wr_enb = 0;
end
endtask

task clear_ready;
begin
@(negedge clk)
rdy_clr = 1'b1;
@(negedge clk)
rdy_clr = 1'b0;
end
endtask

initial begin
@(negedge clk)
rst = 1'b1;
@(negedge clk)
rst = 1'b0;
send_byte (8'h41);
wait (!busy);
wait(rdy);
$display(" received data is %h",dout);
clear_ready;
#1001;
send_byte (8'h55);
wait(!busy);
wait(rdy);
$display(" received data is %h",dout);
clear_ready;
end
endmodule

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.04.2026 20:53:13
// Design Name: 
// Module Name: uart_receiver
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
                                                  
               
