module test (input [7:0] a, b,
            output [7:0] c, d, e, f, g, h, i, j, k);
// a = 8'b0011 0011
// b = 8'b1111 0000
    assign c = a & b;               //0011 0000
    assign d = a | b;               //1111 0011
    assign e = a ^ b;               //1100 0011
    assign f = ~a;                  //1100 1100
    assign g = {a[3:0], b[3:0]};    //0011 0000
    assign h = a >> 3;              //0000 0110
    assign i = &b;                  //0000 0000
    assign j = (a > b) ? a : b;     //b
    assign k = a - b;               //0100 0011
endmodule