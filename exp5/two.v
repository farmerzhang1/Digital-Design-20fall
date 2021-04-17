`timescale 1 ns / 100 ps

module two();
    reg RST_L, D, CLK;
    initial CLK = 0;
    initial
    begin
        $dumpfile("two.vcd");       //生成的vcd文件名称
        $dumpvars(0, two);          //tb模块名称
    end

    initial
    begin
    #60 $stop(0);
    end

    always @ (CLK)
        #5 CLK <= ~CLK;

    initial
    begin
        RST_L = 0; #27
        RST_L = 1; #28
        RST_L = 1;
    end

    initial
    begin
        D = 0; #13
        D = 1; #24
        D = 0; #18
        D = 0;

    end
endmodule