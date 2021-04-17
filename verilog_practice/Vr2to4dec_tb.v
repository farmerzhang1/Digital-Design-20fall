`timescale 1 ns / 100 ps

module Vr2to4dec_tb();
    reg A0s, A1s, ENs;
    wire Y0s, Y1s, Y2s, Y3s;
    integer i, errors;
    reg [3: 0] expectY;

    Vr2to4dec UUT (.A0(A0s), .A1(A1s), .EN(ENs), .Y0(Y0s), .Y1(Y1s), .Y2(Y2s), .Y3(Y3s));
    /*iverilog */
    initial
    begin
        $dumpfile("wave.vcd");          //wave.vcd
        $dumpvars;                      //test bench module name
    end

    initial
    begin
        errors = 0;
        for (i = 0; i < 8; i += 1)
        begin
            {ENs, A1s, A0s} = i;
            #10 ;
            expectY = 4'b0000;
            if (ENs == 1) expectY[{A1s, A0s}] = 1'b1;
            if ({Y3s, Y2s, Y1s, Y0s} != expectY)
            begin
                $display("error: EN A1A0 = %b %b%b, Y3Y2Y1Y0 = %b%b%b%b", ENs, A1s, A0s, Y3s, Y2s, Y1s, Y0s);
                errors = errors + 1;
            end
        end
        $display("Test complete, %d errors", errors);
    end
endmodule