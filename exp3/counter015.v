module counter015 (CLK, RESET, out);
    input CLK, RESET;
    output reg [3:0] out;
    always @ (posedge CLK or posedge RESET)
        if (RESET == 0) out <= 4'b0000;
        else out <= out+1;
endmodule