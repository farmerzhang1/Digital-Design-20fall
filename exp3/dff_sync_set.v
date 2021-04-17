module dff_sync_set (CLK, D, SET, Q, QN);
    input CLK, D, SET;
    output reg Q, QN;
    always @ (posedge CLK)
        if (SET==1) begin Q <= 1; QN <= 0; end
        else begin Q <= D; QN <= ~D; end
endmodule
