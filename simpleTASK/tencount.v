`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/01/2022 01:45:08 PM
// Design Name: 
// Module Name: tencount
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


module tencount(
input wire rst,
input wire clk,
input wire en,
output reg [3:0] count,
output reg co
    );
    always @ (posedge clk) begin
        if (rst) begin
            count <= 4'b0;
            co <= 1'b0;
        end
        else if (en) begin
            if (count == 4'd9) begin
                count <= 4'b0;
                co <= 1'b0;
            end
            else begin
                count <= count + 1'b1;
                if (count == 4'd8) begin
                    co <= 1'b1;
                end
                else begin
                    co <= 1'b0;
                end
            end
        end
    end
endmodule
