`timescale 1 ns / 100 ps

module one();
    reg a, b;

    initial
    begin
        $dumpfile("one.vcd");        //生成的vcd文件名称
        $dumpvars(0, one);    //tb模块名称
    end

    initial
    begin
    #401 $stop(0);
    end

    initial
    begin
        a = 1; #200
        a = 0; #200 b = 0;
    end

    initial
    begin
        b = 0;
        #100 b = 1;
        #175 b = 0;
        #75  b = 1; #50 b = 1;
    end
endmodule