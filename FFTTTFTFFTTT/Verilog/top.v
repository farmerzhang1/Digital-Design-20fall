module top (input clock, input reset, output [2:0] AN, output [3:0] D);
    wire [31:0] io_dOut1_Re;
    wire [31:0] io_dOut1_Im;
    wire [31:0] io_dOut2_Re;
    wire [31:0] io_dOut2_Im;
    reg [3:0] d_temp;
    reg [2:0] sel;
    FFT fft (.clock(clock), .reset(~reset), .io_dIn_Re(32'd1234567), .io_dIn_Im(32'd987654), .io_din_valid(1'b1), .io_dOut1_Re(io_dOut1_Re), .io_dOut1_Im(io_dOut1_Im), .io_dOut2_Re(io_dOut2_Re), .io_dOut2_Im(io_dOut2_Im));
    // 32 = 4 * 8，每一次輸出一個數
    reg [1:0] current_num;
    reg [2:0] tag;
    clk_wiz_0 clk_wiz_0_inst (.clk_in1(clock), .clk_out1(clock_low));
    always @ (posedge clock)
    begin
        // must use CONSTANT
        case (current_num)
            0:
            begin
                // d_temp <= io_dOut1_Re[tag*4+3 : tag*4];
                if (tag == 0) d_temp <= io_dOut1_Re[3:0];
                else if (tag == 1) d_temp <= io_dOut1_Re[7:4];
                else if (tag == 2) d_temp <= io_dOut1_Re[11:8];
                else if (tag == 3) d_temp <= io_dOut1_Re[15:12];
                else if (tag == 4) d_temp <= io_dOut1_Re[19:16];
                else if (tag == 5) d_temp <= io_dOut1_Re[23:20];
                else if (tag == 6) d_temp <= io_dOut1_Re[27:24];
                else if (tag == 7) d_temp <= io_dOut1_Re[31:28];
            end
            1: //d_temp <= io_dOut1_Im[tag*4+3 : tag*4];
            begin
                // d_temp <= io_dOut1_Im[tag*4+3 : tag*4];
                // must use constant
                if (tag == 0) d_temp <= io_dOut1_Im[3:0];
                else if (tag == 1) d_temp <= io_dOut1_Im[7:4];
                else if (tag == 2) d_temp <= io_dOut1_Im[11:8];
                else if (tag == 3) d_temp <= io_dOut1_Im[15:12];
                else if (tag == 4) d_temp <= io_dOut1_Im[19:16];
                else if (tag == 5) d_temp <= io_dOut1_Im[23:20];
                else if (tag == 6) d_temp <= io_dOut1_Im[27:24];
                else if (tag == 7) d_temp <= io_dOut1_Im[31:28];
            end
            2: // d_temp <= io_dOut2_Re[tag*4+3 : tag*4];
            begin
                if (tag == 0) d_temp <= io_dOut2_Re[3:0];
                else if (tag == 1) d_temp <= io_dOut2_Re[7:4];
                else if (tag == 2) d_temp <= io_dOut2_Re[11:8];
                else if (tag == 3) d_temp <= io_dOut2_Re[15:12];
                else if (tag == 4) d_temp <= io_dOut2_Re[19:16];
                else if (tag == 5) d_temp <= io_dOut2_Re[23:20];
                else if (tag == 6) d_temp <= io_dOut2_Re[27:24];
                else if (tag == 7) d_temp <= io_dOut2_Re[31:28];
            end
            3: // d_temp <= io_dOut2_Im[tag*4+3 : tag*4];
            begin
                if (tag == 0) d_temp <= io_dOut2_Im[3:0];
                else if (tag == 1) d_temp <= io_dOut2_Im[7:4];
                else if (tag == 2) d_temp <= io_dOut2_Im[11:8];
                else if (tag == 3) d_temp <= io_dOut2_Im[15:12];
                else if (tag == 4) d_temp <= io_dOut2_Im[19:16];
                else if (tag == 5) d_temp <= io_dOut2_Im[23:20];
                else if (tag == 6) d_temp <= io_dOut2_Im[27:24];
                else if (tag == 7) d_temp <= io_dOut2_Im[31:28];
            end
        endcase
        sel <= tag;
        tag <= tag + 1;
        if (tag == 0) current_num <= current_num+1;
        else current_num <= current_num;
    end
    assign AN = sel;
    assign D = d_temp;
endmodule