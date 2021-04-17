module counter (input clk, rst,
    output reg [7:0] led);
    reg [29:0] out;
    always @ (posedge clk or posedge rst)
    begin
        if (rst) out <= 0;
        else out <= out+1;
        led <= out[29:22];
    end
endmodule