module lab_73(
    input clk,rst,
    output [2:0]AN,[3:0]D
    );
    reg [24:0]cur_time;
    reg [9:0]num,min;
    reg [3:0]led0,led1,led2,led3,data_store;
    reg [2:0]selpin;
    reg [1:0]situation;
    wire reset,locked,clk_wiz,print_clk;
    always@(posedge clk_wiz)//10MHZ,0 degree
    begin
        if(rst==1'b1) //启动前先reset一下，保证相位的稳定
        begin
            led0<=4'd4;
            led1<=4'd3;
            led2<=4'd2;
            led3<=4'd1;
            cur_time<=25'd0;
            num<=10'd30;
            min<=10'd234;
        end
        else if(rst==1'b0)
        begin
        if(cur_time<25'd100_0000)
          begin
             cur_time<=cur_time+25'd1;
             if(num==10'd100)
             begin
                num<=10'd0;
             end
             if(min==10'd600)
             begin
                min<=10'd0;
             end
          end
          else if(cur_time==25'd100_0000)
          begin
              cur_time<=25'd0;
              if(num==10'd100)
              begin
                num<=10'd0;
              end
              else
              begin
                num<=num+10'd1;
              end
              if(min==10'd600)
              begin
                min<=10'd0;
              end
              else
              begin
                min<=min+10'd1;
              end
              if(led0>=4'd9)
                begin
                    led0<=4'd0;
                end
              else
                begin
                    led0<=led0+4'd1;
                end
            if(led0==4'd9)
            begin
                if(led1>=4'd9)
                begin
                    led1<=4'd0;
                end
                else if(led1<4'd9)
                begin
                    led1<=led1+4'd1;
                end
            end
            end
            if(num==10'd100)
            begin
                if(led2>=4'd5)
                begin
                    led2<=4'd0;
                end
                else if(led2<4'd5)
                begin
                    led2<=led2+4'd1;
                end
            end
            if(min==10'd600)
            begin
                if(led3>=4'd9)
                begin
                    led3<=4'd0;
                end
                else
                begin
                    led3<=led3+4'd1;
                end//led3
            end//led2
         end//rst
    end//always
    always@(posedge print_clk)//10MHZ，180 degree
    begin
        situation<=situation+1'b1;//to diaplayw
        if(situation==2'b00)
        begin
            selpin<=3'b000;
            data_store<=led0;
        end
        else if(situation==2'b01)
        begin
            selpin<=3'b010;
            data_store<=led1;
        end
        else if(situation==2'b10)
        begin
            selpin<=3'b100;
            data_store<=led2;
        end
        else if(situation==2'b11)
        begin
            selpin<=3'b110;
            data_store<=led3;
        end
    end
    assign AN=selpin;
    assign D=data_store;
    assign locked=1'b0;
    assign reset=1'b0;
    clk_wiz_0 clk_wiz_0_inst_1(
    .reset(reset),
    .locked(locked),
    .clk_in1(clk),
    .clk_out1(clk_wiz),
    .clk_out2(print_clk)
    );
endmodule
