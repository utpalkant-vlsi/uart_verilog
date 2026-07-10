`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.04.2026 11:36:21
// Design Name: 
// Module Name: uart_tb
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


module uart_tb;
reg clk,rst;
reg[7:0] data_in;
reg wr_enb;
wire rdy;
reg rdy_clr;
wire[7:0]dout;
wire busy;
uart_top ut(.clk(clk),.rst(rst),.data_in(data_in),.wr_enb(er_enb),.rdy_clr(rdy_clr),.rdy(rdy),.busy(busy),.data_out(dout));

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
