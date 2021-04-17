module sub (input a, b,
        output o);
        assign o = a + b;
endmodule

module test (input a, b,
        output c);
        sub s(a, b, c);
endmodule