module yac( // yet another counter
     input clk, increment, button, rst,
     output [3:0] D, [2:0] AN
);

reg button_r1, button_r2;
reg [3:0] cnt0, cnt0_next, cnt1, cnt1_next;
reg [3:0] data;
reg [2:0] sel;
wire button_edge;
wire clk_wiz;
reg tag;
always @ *
begin
     if(rst)
     begin
          cnt0_next = 4'hf;
          cnt1_next = 1;
     end else begin
     if (button_edge)
     begin
          if(increment)
          begin
               if(cnt0 == 4'hf && cnt1 == 4'hf)
               begin
                    cnt0_next = 0;
                    cnt1_next = 0;
               end
               else if(cnt0 == 4'hf)
               begin
                    cnt0_next = 0;
                    cnt1_next = cnt1 + 1;
               end
               else
               begin
                    cnt0_next = cnt0 + 1;
               end
          end
          else
          begin
              if(cnt0 == 0 && cnt1 == 0)
               begin
                    cnt0_next = 4'hf;
                    cnt1_next = 4'hf;
               end
               else if(cnt0 == 0)
               begin
                   cnt0_next = 4'hf;
                   cnt1_next = cnt1 - 1;
               end
               else
                    cnt0_next = cnt0 - 1;
          end
     end
     end
end

     // get buttone edges
     always@(posedge clk)
          button_r1 <= button;

     always@(negedge clk)
          button_r2 <= button_r1;

     assign button_edge = button_r1 & (~button_r2);

     always @ (posedge clk)
     begin
          cnt0 <= cnt0_next;
          cnt1 <= cnt1_next;
     end


     always@(posedge clk_wiz)
     begin
          tag <= ~tag;
          sel <= tag;
          if(tag)
               data <= cnt1;
          else
               data <= cnt0;
     end

     assign D = data;
     assign AN = sel;
     clk_wiz_0 cw0(.clk_in1(clk),.clk_out1(clk_wiz));
endmodule