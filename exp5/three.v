`timescale 1 ns / 100 ps

module three();
    reg RST_N, D, CLK;
    wire Q;
    initial CLK = 0;

    //input clk,rst_n,d,output reg q);
    d_ff_r dff (.clk(CLK), .rst_n(RST_N), .d(D), .q(Q));
    initial
    begin
        $dumpfile("three.vcd");       //生成的vcd文件名称
        $dumpvars(0, three);          //tb模块名称
    end
    initial
    begin
    #60 $stop(0);
    end

    always @ (CLK)
        #5 CLK <= ~CLK;

    initial
    begin
        RST_N = 0; #27
        RST_N = 1; #28
        RST_N = 1;
    end

    initial
    begin
        D = 0; #13
        D = 1; #24
        D = 0; #18
        D = 0;
    end
endmodule