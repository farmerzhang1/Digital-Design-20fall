`timescale 1 ns / 100 ps

module test_bench();
    reg clk,rst_n,clk_a;
    reg [7:0] r1,r2,r3;
    integer i;
    initial clk = 0;

    initial
    begin
        $dumpfile("wave.vcd");        //生成的vcd文件名称
        $dumpvars(0, test_bench);    //tb模块名称
    end

    always @ (clk)
        #5 clk <= ~clk;

    initial
    begin
    rst_n = 0;
    #55 rst_n = 1;
    #300 $stop(0);
    end

    initial
    begin
        r1 = 0;
        repeat(10)
        begin
        @(posedge clk);
        #2 r1 = $random % 256;
        end
    end

    initial
    begin
        for(i = 0; i < 20; i = i + 1)
        begin
            r2 = i;
            #10;
        end
    end

    initial
    begin
        r3 = 0;
        while(r3 < 10)
        begin
        @(posedge clk);
        r3 = r3 +1;
        end
    end
endmodule
