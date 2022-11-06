`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/02/2022 02:05:35 PM
// Design Name: 
// Module Name: tb_sixtycount
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


module tb_sixtycount(

    );
    reg rst;
    reg clk;
    reg en;
    wire [3:0] count10;
    wire [3:0] count6;
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
sixtycount sixtycount(
.rst    (rst),
.clk    (clk),
.en     (en),
.count10    (count10),
.count6     (count6),
.co     (co)
);
endmodule
