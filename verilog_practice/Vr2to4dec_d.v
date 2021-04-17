module Vr2to4dec_d(A0, A1, EN, Y0, Y1, Y2, Y3);
    input A0, A1, EN;
    output Y0, Y1, Y2, Y3;
    assign Y0 = EN ? ({A1, A0} == 2'b00) : 0;
    assign Y1 = EN ? ({A1, A0} == 2'b01) : 0;
    assign Y1 = EN ? ({A1, A0} == 2'b10) : 0;
    assign Y1 = EN ? ({A1, A0} == 2'b11) : 0;
endmodule