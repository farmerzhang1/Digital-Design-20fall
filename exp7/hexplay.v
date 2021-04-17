`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 04.12.2020 16:17:40
// Design Name:
// Module Name: top
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


module top(
    input clk, input [7:0] sw,
    output reg [2:0] AN, output reg [3:0] D
    );
    // frequency of CLK is 100 MHz
    //和现实中的数码管一样，我们建议的扫描频率为50Hz，也就是说，若要驱动8个数码管，需要一个400Hz的时钟。
    reg i;
    wire locked, reset, clk_l;
    always @ (posedge clk_l)
    begin
        i <= ~i;
        AN <= i;
        if (i)
            D <= sw[7:4];
        else
            D <= sw[3:0];
    end
    clk_wiz_0 ccc (.locked(locked), .reset(reset), .clk_in1(clk), .clk_out1(clk_l));
endmodule