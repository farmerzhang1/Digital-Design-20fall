module counter90 (CLK, RESET, out);
    input CLK, RESET;
    output reg [3:0] out;
    always @ (posedge CLK or posedge RESET)
        if (RESET == 0) out <= 4'b1001;
        else if (out == 4'b0000) out <= 4'b1001;
        else out <= out - 1;
endmodule