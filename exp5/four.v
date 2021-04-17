`timescale 1 ns / 100 ps

module four();
    reg [2:0] in;
    wire [7:0] out;
    integer i;

    initial
    begin
        $dumpfile("four.vcd");  //生成的vcd文件名称
        $dumpvars(0, four);     //tb模块名称
    end

    initial
    begin
    #100 $stop(0);
    end

    initial
    begin
        for (i = 0; i < 8; i = i + 1) begin  in = i; #10; end
    end
    // decoder (in, out);
    decoder dc (.in(in), .out(out));
endmodule
