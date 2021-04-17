module mux4(input a, input b, input c, input d, input [1:0]sel,
            output out);
    wire out1, out2;
    mux mux1(.a(a), .b(b), .sel(sel[0]), .out(out1));
    mux mux2(.a(c), .b(d), .sel(sel[0]), .out(out2));
    mux mux3(.a(out1), .b(out2), .sel(sel[1]), .out(out));
endmodule