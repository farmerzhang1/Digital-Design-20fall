`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 11.12.2020 16:11:44
// Design Name:
// Module Name: counter
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


module counter(
    input clk, sw, button, rst,
    output [3:0] data, [2:0] sel
);
wire reset, locked;
reg button_r1, button_r2;
reg [3:0] cnt0, cnt0_next, cnt1, cnt1_next;
reg [3:0] data_store;
reg [2:0] selpin;
wire button_edge;
wire clk_wiz;
reg tag;
always@(*)
begin
     if(rst)
     begin
          cnt0_next = 15;
          cnt1_next = 1;
     end
     else
     begin
     if(button_edge == 1)
     begin
          if(sw == 1)
          begin
               if(cnt0 == 15 && cnt1 == 15)
               begin
                    cnt0_next = 0;
                    cnt1_next = 0;
               end
               else if(cnt0 == 15)
               begin
                    cnt0_next = 0;
                    cnt1_next = cnt1 + 1;
               end
               else
               begin
                    cnt0_next = cnt0 + 1;
               end
         end
         else if(sw == 0)
         begin
              if(cnt0 == 0 && cnt1 == 0)
              begin
                   cnt0_next = 15;
                   cnt1_next = 15;
              end
              else if(cnt0 == 0)
              begin
                   cnt0_next = 15;
                   cnt1_next = cnt1 - 1;
              end
              else
              begin
                   cnt0_next = cnt0 - 1;
              end
         end
     end
     end
end


always@(posedge clk)
       button_r1 <= button;
always@(negedge clk)
       button_r2 <= button_r1;
assign button_edge = button_r1 & (~button_r2);
always@(posedge clk)
begin
     cnt0 <= cnt0_next;
     cnt1 <= cnt1_next;
end


always@(posedge clk_wiz)
begin
     tag <= ~tag;
     if(tag == 1)
     begin
          selpin <= 3'b001;
          data_store <= cnt1;
     end
     else if(tag == 0)
     begin
          selpin <= 3'b000;
          data_store <= cnt0;
     end
end
assign data = data_store;
assign sel = selpin;
     clk_wiz_0 clk_wiz_0_inst_1(.clk_in1(clk),.clk_out1(clk_wiz));
endmodule