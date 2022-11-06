`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/02/2022 01:44:53 PM
// Design Name: 
// Module Name: sixtycount
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


module sixtycount(
input wire rst,
input wire clk,
input wire en,
output wire [3:0] count10,
output wire [3:0] count6,
output reg co
    );
    wire co10, co6;
    reg [2:0] flag;
    tencount tencount(
    .rst    (rst),
    .clk    (clk),
    .en     (en),
    .count  (count10),
    .co     (co10)
    );
    
    sixcount sixcount(
    .rst    (rst),
    .clk    (clk),
    .en     (en),
    .count  (count6),
    .co     (co6)
    );
    initial begin
        flag <= 2'b0;
        wait(en);
        co <= 1'b0;
    end
    always @ (posedge clk) begin
        wait(co10 && co6);
        if (flag == 2'd2) begin
            co <= 1'b1;
            flag <= flag + 1'b1;
        end
        else begin
            if (flag == 2'd3) begin
                flag <= 2'b0;
	 co <= 1'b0;
            end
            else begin
                flag <= flag + 1'b1;
            end
        end
    end
endmodule
