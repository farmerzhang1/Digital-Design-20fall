`timescale 1ns / 1ps
module clock(
    input clk,rst,
    output [2:0]sel, [3:0]data
    );
    reg [28:0]cnt;
    reg [3:0]led0, led1, led2, led3, data_store;
    reg [2:0]selz;
    reg [1:0]now;
    wire pulse_10hz,clk_wiz;
    always@(posedge clk)
    begin
        if(rst)
            cnt <= 0;
        else if (cnt > 10000000)
            cnt <= 0;
        else
            cnt <= cnt + 1;
    end

    assign pulse_10hz = (cnt == 1);

    always @ (posedge clk)
    begin
        if(rst==1'd1)
        begin
            led0 <= 4'd4;
            led1 <= 4'd3;
            led2 <= 4'd2;
            led3 <= 4'd1;
        end

        //這裡最好不要"一路順下來"不然可能會有racing hazard
        else if(pulse_10hz)
        begin
            if(led0 >= 9 && led1 >= 9 && led2 >= 5)
            begin
                led0 = 0;
                led1 = 0;
                led2 = 0;
                led3 = led3 + 1;
            end
            else if(led0 >= 9 && led1 >= 9)
            begin
                led0 = 0;
                led1 = 0;
                led2 = led2+1;
            end
            else if(led0 >= 9)
            begin
                led0 = 0;
                led1 = led1 + 1;
            end
            else
                led0 = led0+1;
        end
    end

    always@(posedge clk_wiz)    // print
    begin
        now <= now + 1;
        if(now == 2'd0)
        begin
            selz <= 3'd0;
            data_store <= led0;
        end
        else if(now == 2'd1)
        begin
            selz <= 3'd2;
            data_store <= led1;
        end
        else if(now == 2'd2)
        begin
            selz <= 3'd4;
            data_store <= led2;
        end
        else if(now == 3)
        begin
            selz <= 6;
            data_store <= led3;
        end
    end
    assign sel=selz;
    assign data=data_store;
    clk_wiz_0 clk_wiz_0_inst_1(.clk_in1(clk), .clk_out1(clk_wiz));
endmodule