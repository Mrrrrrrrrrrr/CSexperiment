`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/01/2022 01:50:15 PM
// Design Name: 
// Module Name: tb_tencount
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


module tb_tencount(

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
tencount tencount(
.rst    (rst),
.clk    (clk),
.en     (en),
.count  (count),
.co     (co)
);
endmodule
