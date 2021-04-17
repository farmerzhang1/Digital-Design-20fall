module top_module (
    input [4:0] a, b, c, d, e, f,
    output [7:0] w, x, y, z );//
    assign w = {a, b[4:2]};
    assign x = {b[1:0], c, d[4]};
    assign y = {d[3:0], e[4:1]};
    assign z = {e[0], f, 2'b11};

endmodule

    assign out = {in[0], in[1], in[2], in[3], in[4], in[5], in[6], in[7]};