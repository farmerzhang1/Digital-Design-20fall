module four (input a, b,
            output c);
    assign c = (a < b) ? a : b;
endmodule

module test (input a, b, c,
            output o);
    wire temp;
    four f1 (.a(a), .b(b), .c(temp));
    four f2 (.a(temp), .b(c), .c(o));
endmodule