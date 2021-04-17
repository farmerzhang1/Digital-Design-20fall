`timescale 1 ns/100 ps
module mux4_tb();
    reg as, bs, cs, ds, expectOut;
    reg [1:0] sel;
    wire outs;
    integer i, errors;
    mux4 UUT(.a(as), .b(bs), .c(cs), .d(ds), .sel(sel), .out(outs));
    initial
    begin
        errors = 0;
        for (i = 0; i < 64; i++)
        begin
            {as, bs, cs, ds, sel} = i;
            #10; // after this statement, outs are updated (not immediately after "{as, bs, sels} = i;" !!!!)
            //$display("this is a test: a %b b %b sel %b out %b", as, bs, sels, outs);
            case (sel)
                2'b00: expectOut = as;
                2'b01: expectOut = bs;
                2'b10: expectOut = cs;
                2'b11: expectOut = ds;
            endcase
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
        $dumpvars(0, mux4_tb);    //tb模块名称
    end
endmodule