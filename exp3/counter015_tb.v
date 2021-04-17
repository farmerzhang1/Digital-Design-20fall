`timescale 1 ns / 100 ps
module counter015_tb ();
    reg CLK, RESET;
    wire [3:0] out;
    always begin
        #5.5 CLK = 0;
        #4.0 CLK = 1;
        #0.5 ;
    end
    counter015 ccc (.CLK(CLK), .RESET(RESET), .out(out));
    initial
    begin
        $dumpfile("counter0-15.vcd");   //生成的vcd文件名称
        $dumpvars(0, counter015_tb);    //tb模块名称
    end
    initial
    begin
        RESET = 0;
        #20 ;
        RESET = 1;
        #200 ;
        RESET = 0;
        #20 ;
        RESET = 1;
        #200 ;
        $stop;
    end
endmodule