module verilog(
     input clk, button, sw,
     output [3:0] D, [2:0] AN
);
     reg button_r1, button_r2;
     reg [3:0] cnt, cnt_next, num, num_next;
     reg [1:0] curr_state, next_state;
     reg [3:0] data;
     reg [2:0] sel;
     wire button_edge;
     wire clk_wiz;
     reg [2:0] tag;
     parameter S0 = 0;
     parameter S1 = 1;
     parameter S2 = 2;
     parameter S3 = 3;

     always @ *
     begin
          if (button_edge)
          begin
               cnt_next = cnt << 1;
               cnt_next[0] = sw;
               if (curr_state == S3 && ~sw)
                    num_next = num + 1;
               else
                    num_next = num;

               case(curr_state)
               S0:
                    if(!sw)
                         next_state = S0;
                    else
                         next_state = S1;
               S1:
                    if(!sw)
                         next_state = S0;
                    else
                         next_state = S2;
               S2:
                    if(!sw)
                         next_state = S3;
                    else
                         next_state = S2;
               S3:
                    if(!sw)
                         next_state = S0;
                    else
                         next_state = S1;
               endcase
          end
     end

     always @ (posedge clk)
          button_r1 <= button;
     always @ (negedge clk)
          button_r2 <= button_r1;
     assign button_edge = button_r1 & ~button_r2;

     always @ (posedge clk)
     begin
          cnt <= cnt_next;
          curr_state <= next_state;
          num <= num_next;
     end


     always @ (posedge clk_wiz)
     begin
          if(tag >= 5)
               tag <= 0;
          else
               tag <= tag + 1;

          sel <= tag;

          if (tag < 4)
               data <= cnt[tag];
          else if(tag == 4)
               data <= curr_state + 10; // 0 to A, 1 to B, etc.
          else if(tag == 5)
               data <= num;
     end

     assign D = data;
     assign AN = sel;
     clk_wiz_0 cw0 (.clk_in1(clk),.clk_out1(clk_wiz));
endmodule