module Vr2to4dec(A0, A1, EN, Y0, Y1, Y2, Y3);
    input A0, A1, EN;
    output reg Y0, Y1, Y2, Y3;
    reg [3:0] IY;

    always @ (A0 or A1 or EN)
    begin
        IY = 4'b0000;
        if (EN == 1)
        begin
            IY[{A1, A0}] = 1;
        end
        //{Y3， Y2， Y1， Y0} = IY;
        Y3 = IY[3];
        Y2 = IY[2];
        Y1 = IY[1];
        Y0 = IY[0];
    end
endmodule