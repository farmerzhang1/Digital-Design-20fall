`default_nettype none
module top_module(
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n   );
	wire aandb, candd, ortwo, notortwo;
	assign aandb = a & b;
	assign candd = c & d;
	assign ortwo = aandb | candd;
	assign notortwo = ~ortwo;
	assign out = ortwo;
	assign out_n =notortwo;
endmodule
