`timescale 1 ns/100 ps
module mux_tb();
    reg as, bs, sels, expectOut;
    wire outs;
    integer i, errors;
    mux UUT(.a(as), .b(bs), .sel(sels), .out(outs));
    initial
    begin
        errors = 0;
        for (i = 0; i < 8; i++)
        begin
            {as, bs, sels} = i;
            #10; // after this statement, outs are updated (not immediately after "{as, bs, sels} = i;" !!!!)
            $display("this is a test: a %b b %b sel %b out %b", as, bs, sels, outs);
            expectOut = sels == 0 ? as : bs;
            if (outs != expectOut)
            begin
                $display("Error: expected %b, actual %b", expectOut, outs);
                errors += 1;
            end
        end
        $display("test complete, %d errors", errors);
    end
    initial
    begin
        $dumpfile("wave.vcd");        //生成的vcd文件名称
        $dumpvars(0, mux_tb);    //tb模块名称
    end
endmodule