`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/02/2022 01:25:11 PM
// Design Name: 
// Module Name: tb_sixcount
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


module tb_sixcount(

    );
    reg rst;
    reg clk;
    reg en;
    wire [3:0] count;
    wire co;
    initial begin
        rst = 0;
        clk = 0;
        en = 0;
        #100
        rst = 1;
        #40
        rst = 0;
        en = 1;
    end
    
    always #10 clk = ~clk;
sixcount sixcount(
.rst    (rst),
.clk    (clk),
.en     (en),
.count  (count),
.co     (co)
);
endmodule
