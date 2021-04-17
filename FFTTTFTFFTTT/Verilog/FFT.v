module ComplexAdd(
  input  [31:0] io_op1_Re,
  input  [31:0] io_op1_Im,
  input  [31:0] io_op2_Re,
  input  [31:0] io_op2_Im,
  output [31:0] io_res_Re,
  output [31:0] io_res_Im
);
  assign io_res_Re = $signed(io_op1_Re) + $signed(io_op2_Re); // @[complex.scala 19:15]
  assign io_res_Im = $signed(io_op1_Im) + $signed(io_op2_Im); // @[complex.scala 20:15]
endmodule
module ComplexSub(
  input  [31:0] io_op1_Re,
  input  [31:0] io_op1_Im,
  input  [31:0] io_op2_Re,
  input  [31:0] io_op2_Im,
  output [31:0] io_res_Re,
  output [31:0] io_res_Im
);
  assign io_res_Re = $signed(io_op1_Re) - $signed(io_op2_Re); // @[complex.scala 39:15]
  assign io_res_Im = $signed(io_op1_Im) - $signed(io_op2_Im); // @[complex.scala 40:15]
endmodule
module ComplexMul(
  input  [31:0] io_op1_Re,
  input  [31:0] io_op1_Im,
  input  [31:0] io_op2_Re,
  input  [31:0] io_op2_Im,
  output [31:0] io_res_Re,
  output [31:0] io_res_Im
);
  wire [31:0] _T_2 = $signed(io_op1_Re) + $signed(io_op1_Im); // @[complex.scala 54:37]
  wire [63:0] k1 = $signed(io_op2_Re) * $signed(_T_2); // @[complex.scala 54:24]
  wire [31:0] _T_5 = $signed(io_op2_Im) - $signed(io_op2_Re); // @[complex.scala 55:37]
  wire [63:0] k2 = $signed(io_op1_Re) * $signed(_T_5); // @[complex.scala 55:24]
  wire [31:0] _T_8 = $signed(io_op2_Re) + $signed(io_op2_Im); // @[complex.scala 56:37]
  wire [63:0] k3 = $signed(io_op1_Im) * $signed(_T_8); // @[complex.scala 56:24]
  wire [63:0] _T_11 = $signed(k1) - $signed(k3); // @[complex.scala 57:21]
  wire [63:0] _T_14 = $signed(k1) + $signed(k2); // @[complex.scala 58:21]
  wire [47:0] _GEN_0 = _T_11[63:16]; // @[complex.scala 57:15]
  wire [47:0] _GEN_2 = _T_14[63:16]; // @[complex.scala 58:15]
  assign io_res_Re = _GEN_0[31:0]; // @[complex.scala 57:15]
  assign io_res_Im = _GEN_2[31:0]; // @[complex.scala 58:15]
endmodule
module Butterfly(
  input  [31:0] io_in1_Re,
  input  [31:0] io_in1_Im,
  input  [31:0] io_in2_Re,
  input  [31:0] io_in2_Im,
  input  [31:0] io_wn_Re,
  input  [31:0] io_wn_Im,
  output [31:0] io_out1_Re,
  output [31:0] io_out1_Im,
  output [31:0] io_out2_Re,
  output [31:0] io_out2_Im
);
  wire [31:0] ComplexAdd_io_op1_Re; // @[complex.scala 30:26]
  wire [31:0] ComplexAdd_io_op1_Im; // @[complex.scala 30:26]
  wire [31:0] ComplexAdd_io_op2_Re; // @[complex.scala 30:26]
  wire [31:0] ComplexAdd_io_op2_Im; // @[complex.scala 30:26]
  wire [31:0] ComplexAdd_io_res_Re; // @[complex.scala 30:26]
  wire [31:0] ComplexAdd_io_res_Im; // @[complex.scala 30:26]
  wire [31:0] ComplexSub_io_op1_Re; // @[complex.scala 44:26]
  wire [31:0] ComplexSub_io_op1_Im; // @[complex.scala 44:26]
  wire [31:0] ComplexSub_io_op2_Re; // @[complex.scala 44:26]
  wire [31:0] ComplexSub_io_op2_Im; // @[complex.scala 44:26]
  wire [31:0] ComplexSub_io_res_Re; // @[complex.scala 44:26]
  wire [31:0] ComplexSub_io_res_Im; // @[complex.scala 44:26]
  wire [31:0] ComplexMul_io_op1_Re; // @[complex.scala 62:26]
  wire [31:0] ComplexMul_io_op1_Im; // @[complex.scala 62:26]
  wire [31:0] ComplexMul_io_op2_Re; // @[complex.scala 62:26]
  wire [31:0] ComplexMul_io_op2_Im; // @[complex.scala 62:26]
  wire [31:0] ComplexMul_io_res_Re; // @[complex.scala 62:26]
  wire [31:0] ComplexMul_io_res_Im; // @[complex.scala 62:26]
  ComplexAdd ComplexAdd ( // @[complex.scala 30:26]
    .io_op1_Re(ComplexAdd_io_op1_Re),
    .io_op1_Im(ComplexAdd_io_op1_Im),
    .io_op2_Re(ComplexAdd_io_op2_Re),
    .io_op2_Im(ComplexAdd_io_op2_Im),
    .io_res_Re(ComplexAdd_io_res_Re),
    .io_res_Im(ComplexAdd_io_res_Im)
  );
  ComplexSub ComplexSub ( // @[complex.scala 44:26]
    .io_op1_Re(ComplexSub_io_op1_Re),
    .io_op1_Im(ComplexSub_io_op1_Im),
    .io_op2_Re(ComplexSub_io_op2_Re),
    .io_op2_Im(ComplexSub_io_op2_Im),
    .io_res_Re(ComplexSub_io_res_Re),
    .io_res_Im(ComplexSub_io_res_Im)
  );
  ComplexMul ComplexMul ( // @[complex.scala 62:26]
    .io_op1_Re(ComplexMul_io_op1_Re),
    .io_op1_Im(ComplexMul_io_op1_Im),
    .io_op2_Re(ComplexMul_io_op2_Re),
    .io_op2_Im(ComplexMul_io_op2_Im),
    .io_res_Re(ComplexMul_io_res_Re),
    .io_res_Im(ComplexMul_io_res_Im)
  );
  assign io_out1_Re = ComplexAdd_io_res_Re; // @[butterfly.scala 21:13]
  assign io_out1_Im = ComplexAdd_io_res_Im; // @[butterfly.scala 21:13]
  assign io_out2_Re = ComplexMul_io_res_Re; // @[butterfly.scala 22:13]
  assign io_out2_Im = ComplexMul_io_res_Im; // @[butterfly.scala 22:13]
  assign ComplexAdd_io_op1_Re = io_in1_Re; // @[complex.scala 31:21]
  assign ComplexAdd_io_op1_Im = io_in1_Im; // @[complex.scala 31:21]
  assign ComplexAdd_io_op2_Re = io_in2_Re; // @[complex.scala 32:21]
  assign ComplexAdd_io_op2_Im = io_in2_Im; // @[complex.scala 32:21]
  assign ComplexSub_io_op1_Re = io_in1_Re; // @[complex.scala 45:21]
  assign ComplexSub_io_op1_Im = io_in1_Im; // @[complex.scala 45:21]
  assign ComplexSub_io_op2_Re = io_in2_Re; // @[complex.scala 46:21]
  assign ComplexSub_io_op2_Im = io_in2_Im; // @[complex.scala 46:21]
  assign ComplexMul_io_op1_Re = ComplexSub_io_res_Re; // @[complex.scala 63:21]
  assign ComplexMul_io_op1_Im = ComplexSub_io_res_Im; // @[complex.scala 63:21]
  assign ComplexMul_io_op2_Re = io_wn_Re; // @[complex.scala 64:21]
  assign ComplexMul_io_op2_Im = io_wn_Im; // @[complex.scala 64:21]
endmodule
module Switch(
  input  [31:0] io_in1_Re,
  input  [31:0] io_in1_Im,
  input  [31:0] io_in2_Re,
  input  [31:0] io_in2_Im,
  input         io_sel,
  output [31:0] io_out1_Re,
  output [31:0] io_out1_Im,
  output [31:0] io_out2_Re,
  output [31:0] io_out2_Im
);
  assign io_out1_Re = io_sel ? $signed(io_in2_Re) : $signed(io_in1_Re); // @[butterfly.scala 43:13]
  assign io_out1_Im = io_sel ? $signed(io_in2_Im) : $signed(io_in1_Im); // @[butterfly.scala 43:13]
  assign io_out2_Re = io_sel ? $signed(io_in1_Re) : $signed(io_in2_Re); // @[butterfly.scala 44:13]
  assign io_out2_Im = io_sel ? $signed(io_in1_Im) : $signed(io_in2_Im); // @[butterfly.scala 44:13]
endmodule
module FFT(
  input         clock,
  input         reset,
  input  [31:0] io_dIn_Re,
  input  [31:0] io_dIn_Im,
  input         io_din_valid,
  output [31:0] io_dOut1_Re,
  output [31:0] io_dOut1_Im,
  output [31:0] io_dOut2_Re,
  output [31:0] io_dOut2_Im,
  output        io_dout_valid
);
  wire [31:0] Butterfly_io_in1_Re; // @[butterfly.scala 26:26]
  wire [31:0] Butterfly_io_in1_Im; // @[butterfly.scala 26:26]
  wire [31:0] Butterfly_io_in2_Re; // @[butterfly.scala 26:26]
  wire [31:0] Butterfly_io_in2_Im; // @[butterfly.scala 26:26]
  wire [31:0] Butterfly_io_wn_Re; // @[butterfly.scala 26:26]
  wire [31:0] Butterfly_io_wn_Im; // @[butterfly.scala 26:26]
  wire [31:0] Butterfly_io_out1_Re; // @[butterfly.scala 26:26]
  wire [31:0] Butterfly_io_out1_Im; // @[butterfly.scala 26:26]
  wire [31:0] Butterfly_io_out2_Re; // @[butterfly.scala 26:26]
  wire [31:0] Butterfly_io_out2_Im; // @[butterfly.scala 26:26]
  wire [31:0] Switch_io_in1_Re; // @[butterfly.scala 49:26]
  wire [31:0] Switch_io_in1_Im; // @[butterfly.scala 49:26]
  wire [31:0] Switch_io_in2_Re; // @[butterfly.scala 49:26]
  wire [31:0] Switch_io_in2_Im; // @[butterfly.scala 49:26]
  wire  Switch_io_sel; // @[butterfly.scala 49:26]
  wire [31:0] Switch_io_out1_Re; // @[butterfly.scala 49:26]
  wire [31:0] Switch_io_out1_Im; // @[butterfly.scala 49:26]
  wire [31:0] Switch_io_out2_Re; // @[butterfly.scala 49:26]
  wire [31:0] Switch_io_out2_Im; // @[butterfly.scala 49:26]
  wire [31:0] Butterfly_1_io_in1_Re; // @[butterfly.scala 26:26]
  wire [31:0] Butterfly_1_io_in1_Im; // @[butterfly.scala 26:26]
  wire [31:0] Butterfly_1_io_in2_Re; // @[butterfly.scala 26:26]
  wire [31:0] Butterfly_1_io_in2_Im; // @[butterfly.scala 26:26]
  wire [31:0] Butterfly_1_io_wn_Re; // @[butterfly.scala 26:26]
  wire [31:0] Butterfly_1_io_wn_Im; // @[butterfly.scala 26:26]
  wire [31:0] Butterfly_1_io_out1_Re; // @[butterfly.scala 26:26]
  wire [31:0] Butterfly_1_io_out1_Im; // @[butterfly.scala 26:26]
  wire [31:0] Butterfly_1_io_out2_Re; // @[butterfly.scala 26:26]
  wire [31:0] Butterfly_1_io_out2_Im; // @[butterfly.scala 26:26]
  wire [31:0] Switch_1_io_in1_Re; // @[butterfly.scala 49:26]
  wire [31:0] Switch_1_io_in1_Im; // @[butterfly.scala 49:26]
  wire [31:0] Switch_1_io_in2_Re; // @[butterfly.scala 49:26]
  wire [31:0] Switch_1_io_in2_Im; // @[butterfly.scala 49:26]
  wire  Switch_1_io_sel; // @[butterfly.scala 49:26]
  wire [31:0] Switch_1_io_out1_Re; // @[butterfly.scala 49:26]
  wire [31:0] Switch_1_io_out1_Im; // @[butterfly.scala 49:26]
  wire [31:0] Switch_1_io_out2_Re; // @[butterfly.scala 49:26]
  wire [31:0] Switch_1_io_out2_Im; // @[butterfly.scala 49:26]
  wire [31:0] Butterfly_2_io_in1_Re; // @[butterfly.scala 26:26]
  wire [31:0] Butterfly_2_io_in1_Im; // @[butterfly.scala 26:26]
  wire [31:0] Butterfly_2_io_in2_Re; // @[butterfly.scala 26:26]
  wire [31:0] Butterfly_2_io_in2_Im; // @[butterfly.scala 26:26]
  wire [31:0] Butterfly_2_io_wn_Re; // @[butterfly.scala 26:26]
  wire [31:0] Butterfly_2_io_wn_Im; // @[butterfly.scala 26:26]
  wire [31:0] Butterfly_2_io_out1_Re; // @[butterfly.scala 26:26]
  wire [31:0] Butterfly_2_io_out1_Im; // @[butterfly.scala 26:26]
  wire [31:0] Butterfly_2_io_out2_Re; // @[butterfly.scala 26:26]
  wire [31:0] Butterfly_2_io_out2_Im; // @[butterfly.scala 26:26]
  wire [31:0] Switch_2_io_in1_Re; // @[butterfly.scala 49:26]
  wire [31:0] Switch_2_io_in1_Im; // @[butterfly.scala 49:26]
  wire [31:0] Switch_2_io_in2_Re; // @[butterfly.scala 49:26]
  wire [31:0] Switch_2_io_in2_Im; // @[butterfly.scala 49:26]
  wire  Switch_2_io_sel; // @[butterfly.scala 49:26]
  wire [31:0] Switch_2_io_out1_Re; // @[butterfly.scala 49:26]
  wire [31:0] Switch_2_io_out1_Im; // @[butterfly.scala 49:26]
  wire [31:0] Switch_2_io_out2_Re; // @[butterfly.scala 49:26]
  wire [31:0] Switch_2_io_out2_Im; // @[butterfly.scala 49:26]
  wire [31:0] ComplexAdd_io_op1_Re; // @[complex.scala 30:26]
  wire [31:0] ComplexAdd_io_op1_Im; // @[complex.scala 30:26]
  wire [31:0] ComplexAdd_io_op2_Re; // @[complex.scala 30:26]
  wire [31:0] ComplexAdd_io_op2_Im; // @[complex.scala 30:26]
  wire [31:0] ComplexAdd_io_res_Re; // @[complex.scala 30:26]
  wire [31:0] ComplexAdd_io_res_Im; // @[complex.scala 30:26]
  wire [31:0] ComplexSub_io_op1_Re; // @[complex.scala 44:26]
  wire [31:0] ComplexSub_io_op1_Im; // @[complex.scala 44:26]
  wire [31:0] ComplexSub_io_op2_Re; // @[complex.scala 44:26]
  wire [31:0] ComplexSub_io_op2_Im; // @[complex.scala 44:26]
  wire [31:0] ComplexSub_io_res_Re; // @[complex.scala 44:26]
  wire [31:0] ComplexSub_io_res_Im; // @[complex.scala 44:26]
  reg [4:0] count; // @[fft.scala 36:24]
  reg [31:0] _RAND_0;
  wire  busy = count != 5'h0; // @[fft.scala 37:22]
  wire  _T = io_din_valid | busy; // @[fft.scala 38:24]
  wire  _T_1 = count == 5'h17; // @[fft.scala 39:28]
  wire [4:0] _T_3 = count + 5'h1; // @[fft.scala 39:77]
  wire [31:0] _GEN_2 = 3'h1 == count[2:0] ? $signed(32'shec83) : $signed(32'sh10000); // @[fft.scala 32:16]
  wire [31:0] _GEN_3 = 3'h2 == count[2:0] ? $signed(32'shb505) : $signed(_GEN_2); // @[fft.scala 32:16]
  wire [31:0] _GEN_4 = 3'h3 == count[2:0] ? $signed(32'sh61f8) : $signed(_GEN_3); // @[fft.scala 32:16]
  wire [31:0] _GEN_5 = 3'h4 == count[2:0] ? $signed(32'sh0) : $signed(_GEN_4); // @[fft.scala 32:16]
  wire [31:0] _GEN_6 = 3'h5 == count[2:0] ? $signed(-32'sh61f8) : $signed(_GEN_5); // @[fft.scala 32:16]
  wire [31:0] _GEN_7 = 3'h6 == count[2:0] ? $signed(-32'shb505) : $signed(_GEN_6); // @[fft.scala 32:16]
  wire [31:0] _GEN_10 = 3'h1 == count[2:0] ? $signed(-32'sh61f8) : $signed(32'sh0); // @[fft.scala 33:16]
  wire [31:0] _GEN_11 = 3'h2 == count[2:0] ? $signed(-32'shb505) : $signed(_GEN_10); // @[fft.scala 33:16]
  wire [31:0] _GEN_12 = 3'h3 == count[2:0] ? $signed(-32'shec83) : $signed(_GEN_11); // @[fft.scala 33:16]
  wire [31:0] _GEN_13 = 3'h4 == count[2:0] ? $signed(-32'sh10000) : $signed(_GEN_12); // @[fft.scala 33:16]
  wire [31:0] _GEN_14 = 3'h5 == count[2:0] ? $signed(-32'shec83) : $signed(_GEN_13); // @[fft.scala 33:16]
  wire [31:0] _GEN_15 = 3'h6 == count[2:0] ? $signed(-32'shb505) : $signed(_GEN_14); // @[fft.scala 33:16]
  reg [31:0] _T_79_Re; // @[Reg.scala 15:16]
  reg [31:0] _RAND_1;
  reg [31:0] _T_79_Im; // @[Reg.scala 15:16]
  reg [31:0] _RAND_2;
  reg [31:0] _T_80_Re; // @[Reg.scala 15:16]
  reg [31:0] _RAND_3;
  reg [31:0] _T_80_Im; // @[Reg.scala 15:16]
  reg [31:0] _RAND_4;
  reg [31:0] _T_81_Re; // @[Reg.scala 15:16]
  reg [31:0] _RAND_5;
  reg [31:0] _T_81_Im; // @[Reg.scala 15:16]
  reg [31:0] _RAND_6;
  reg [31:0] _T_82_Re; // @[Reg.scala 15:16]
  reg [31:0] _RAND_7;
  reg [31:0] _T_82_Im; // @[Reg.scala 15:16]
  reg [31:0] _RAND_8;
  reg [31:0] _T_83_Re; // @[Reg.scala 15:16]
  reg [31:0] _RAND_9;
  reg [31:0] _T_83_Im; // @[Reg.scala 15:16]
  reg [31:0] _RAND_10;
  reg [31:0] _T_84_Re; // @[Reg.scala 15:16]
  reg [31:0] _RAND_11;
  reg [31:0] _T_84_Im; // @[Reg.scala 15:16]
  reg [31:0] _RAND_12;
  reg [31:0] _T_85_Re; // @[Reg.scala 15:16]
  reg [31:0] _RAND_13;
  reg [31:0] _T_85_Im; // @[Reg.scala 15:16]
  reg [31:0] _RAND_14;
  reg [31:0] _T_86_Re; // @[Reg.scala 15:16]
  reg [31:0] _RAND_15;
  reg [31:0] _T_86_Im; // @[Reg.scala 15:16]
  reg [31:0] _RAND_16;
  reg [31:0] _T_88_Re; // @[Reg.scala 15:16]
  reg [31:0] _RAND_17;
  reg [31:0] _T_88_Im; // @[Reg.scala 15:16]
  reg [31:0] _RAND_18;
  reg [31:0] _T_89_Re; // @[Reg.scala 15:16]
  reg [31:0] _RAND_19;
  reg [31:0] _T_89_Im; // @[Reg.scala 15:16]
  reg [31:0] _RAND_20;
  reg [31:0] _T_90_Re; // @[Reg.scala 15:16]
  reg [31:0] _RAND_21;
  reg [31:0] _T_90_Im; // @[Reg.scala 15:16]
  reg [31:0] _RAND_22;
  reg [31:0] _T_91_Re; // @[Reg.scala 15:16]
  reg [31:0] _RAND_23;
  reg [31:0] _T_91_Im; // @[Reg.scala 15:16]
  reg [31:0] _RAND_24;
  wire [31:0] _GEN_42 = 2'h1 == count[1:0] ? $signed(32'shb505) : $signed(32'sh10000); // @[fft.scala 32:16]
  wire [31:0] _GEN_43 = 2'h2 == count[1:0] ? $signed(32'sh0) : $signed(_GEN_42); // @[fft.scala 32:16]
  wire [31:0] _GEN_46 = 2'h1 == count[1:0] ? $signed(-32'shb505) : $signed(32'sh0); // @[fft.scala 33:16]
  wire [31:0] _GEN_47 = 2'h2 == count[1:0] ? $signed(-32'sh10000) : $signed(_GEN_46); // @[fft.scala 33:16]
  reg [31:0] _T_96_Re; // @[Reg.scala 15:16]
  reg [31:0] _RAND_25;
  reg [31:0] _T_96_Im; // @[Reg.scala 15:16]
  reg [31:0] _RAND_26;
  reg [31:0] _T_97_Re; // @[Reg.scala 15:16]
  reg [31:0] _RAND_27;
  reg [31:0] _T_97_Im; // @[Reg.scala 15:16]
  reg [31:0] _RAND_28;
  reg [31:0] _T_98_Re; // @[Reg.scala 15:16]
  reg [31:0] _RAND_29;
  reg [31:0] _T_98_Im; // @[Reg.scala 15:16]
  reg [31:0] _RAND_30;
  reg [31:0] _T_99_Re; // @[Reg.scala 15:16]
  reg [31:0] _RAND_31;
  reg [31:0] _T_99_Im; // @[Reg.scala 15:16]
  reg [31:0] _RAND_32;
  reg [31:0] _T_101_Re; // @[Reg.scala 15:16]
  reg [31:0] _RAND_33;
  reg [31:0] _T_101_Im; // @[Reg.scala 15:16]
  reg [31:0] _RAND_34;
  reg [31:0] _T_102_Re; // @[Reg.scala 15:16]
  reg [31:0] _RAND_35;
  reg [31:0] _T_102_Im; // @[Reg.scala 15:16]
  reg [31:0] _RAND_36;
  reg [31:0] _T_107_Re; // @[Reg.scala 15:16]
  reg [31:0] _RAND_37;
  reg [31:0] _T_107_Im; // @[Reg.scala 15:16]
  reg [31:0] _RAND_38;
  reg [31:0] _T_108_Re; // @[Reg.scala 15:16]
  reg [31:0] _RAND_39;
  reg [31:0] _T_108_Im; // @[Reg.scala 15:16]
  reg [31:0] _RAND_40;
  reg [31:0] _T_110_Re; // @[Reg.scala 15:16]
  reg [31:0] _RAND_41;
  reg [31:0] _T_110_Im; // @[Reg.scala 15:16]
  reg [31:0] _RAND_42;
  reg [31:0] out1D1_Re; // @[fft.scala 57:25]
  reg [31:0] _RAND_43;
  reg [31:0] out1D1_Im; // @[fft.scala 57:25]
  reg [31:0] _RAND_44;
  reg [31:0] _T_111_Re; // @[fft.scala 60:24]
  reg [31:0] _RAND_45;
  reg [31:0] _T_111_Im; // @[fft.scala 60:24]
  reg [31:0] _RAND_46;
  reg [31:0] _T_112_Re; // @[fft.scala 61:24]
  reg [31:0] _RAND_47;
  reg [31:0] _T_112_Im; // @[fft.scala 61:24]
  reg [31:0] _RAND_48;
  reg [4:0] _T_113; // @[fft.scala 62:29]
  reg [31:0] _RAND_49;
  Butterfly Butterfly ( // @[butterfly.scala 26:26]
    .io_in1_Re(Butterfly_io_in1_Re),
    .io_in1_Im(Butterfly_io_in1_Im),
    .io_in2_Re(Butterfly_io_in2_Re),
    .io_in2_Im(Butterfly_io_in2_Im),
    .io_wn_Re(Butterfly_io_wn_Re),
    .io_wn_Im(Butterfly_io_wn_Im),
    .io_out1_Re(Butterfly_io_out1_Re),
    .io_out1_Im(Butterfly_io_out1_Im),
    .io_out2_Re(Butterfly_io_out2_Re),
    .io_out2_Im(Butterfly_io_out2_Im)
  );
  Switch Switch ( // @[butterfly.scala 49:26]
    .io_in1_Re(Switch_io_in1_Re),
    .io_in1_Im(Switch_io_in1_Im),
    .io_in2_Re(Switch_io_in2_Re),
    .io_in2_Im(Switch_io_in2_Im),
    .io_sel(Switch_io_sel),
    .io_out1_Re(Switch_io_out1_Re),
    .io_out1_Im(Switch_io_out1_Im),
    .io_out2_Re(Switch_io_out2_Re),
    .io_out2_Im(Switch_io_out2_Im)
  );
  Butterfly Butterfly_1 ( // @[butterfly.scala 26:26]
    .io_in1_Re(Butterfly_1_io_in1_Re),
    .io_in1_Im(Butterfly_1_io_in1_Im),
    .io_in2_Re(Butterfly_1_io_in2_Re),
    .io_in2_Im(Butterfly_1_io_in2_Im),
    .io_wn_Re(Butterfly_1_io_wn_Re),
    .io_wn_Im(Butterfly_1_io_wn_Im),
    .io_out1_Re(Butterfly_1_io_out1_Re),
    .io_out1_Im(Butterfly_1_io_out1_Im),
    .io_out2_Re(Butterfly_1_io_out2_Re),
    .io_out2_Im(Butterfly_1_io_out2_Im)
  );
  Switch Switch_1 ( // @[butterfly.scala 49:26]
    .io_in1_Re(Switch_1_io_in1_Re),
    .io_in1_Im(Switch_1_io_in1_Im),
    .io_in2_Re(Switch_1_io_in2_Re),
    .io_in2_Im(Switch_1_io_in2_Im),
    .io_sel(Switch_1_io_sel),
    .io_out1_Re(Switch_1_io_out1_Re),
    .io_out1_Im(Switch_1_io_out1_Im),
    .io_out2_Re(Switch_1_io_out2_Re),
    .io_out2_Im(Switch_1_io_out2_Im)
  );
  Butterfly Butterfly_2 ( // @[butterfly.scala 26:26]
    .io_in1_Re(Butterfly_2_io_in1_Re),
    .io_in1_Im(Butterfly_2_io_in1_Im),
    .io_in2_Re(Butterfly_2_io_in2_Re),
    .io_in2_Im(Butterfly_2_io_in2_Im),
    .io_wn_Re(Butterfly_2_io_wn_Re),
    .io_wn_Im(Butterfly_2_io_wn_Im),
    .io_out1_Re(Butterfly_2_io_out1_Re),
    .io_out1_Im(Butterfly_2_io_out1_Im),
    .io_out2_Re(Butterfly_2_io_out2_Re),
    .io_out2_Im(Butterfly_2_io_out2_Im)
  );
  Switch Switch_2 ( // @[butterfly.scala 49:26]
    .io_in1_Re(Switch_2_io_in1_Re),
    .io_in1_Im(Switch_2_io_in1_Im),
    .io_in2_Re(Switch_2_io_in2_Re),
    .io_in2_Im(Switch_2_io_in2_Im),
    .io_sel(Switch_2_io_sel),
    .io_out1_Re(Switch_2_io_out1_Re),
    .io_out1_Im(Switch_2_io_out1_Im),
    .io_out2_Re(Switch_2_io_out2_Re),
    .io_out2_Im(Switch_2_io_out2_Im)
  );
  ComplexAdd ComplexAdd ( // @[complex.scala 30:26]
    .io_op1_Re(ComplexAdd_io_op1_Re),
    .io_op1_Im(ComplexAdd_io_op1_Im),
    .io_op2_Re(ComplexAdd_io_op2_Re),
    .io_op2_Im(ComplexAdd_io_op2_Im),
    .io_res_Re(ComplexAdd_io_res_Re),
    .io_res_Im(ComplexAdd_io_res_Im)
  );
  ComplexSub ComplexSub ( // @[complex.scala 44:26]
    .io_op1_Re(ComplexSub_io_op1_Re),
    .io_op1_Im(ComplexSub_io_op1_Im),
    .io_op2_Re(ComplexSub_io_op2_Re),
    .io_op2_Im(ComplexSub_io_op2_Im),
    .io_res_Re(ComplexSub_io_res_Re),
    .io_res_Im(ComplexSub_io_res_Im)
  );
  assign io_dOut1_Re = _T_111_Re; // @[fft.scala 60:14]
  assign io_dOut1_Im = _T_111_Im; // @[fft.scala 60:14]
  assign io_dOut2_Re = _T_112_Re; // @[fft.scala 61:14]
  assign io_dOut2_Im = _T_112_Im; // @[fft.scala 61:14]
  assign io_dout_valid = _T_113 == 5'hf; // @[fft.scala 62:19]
  assign Butterfly_io_in1_Re = _T_86_Re; // @[butterfly.scala 27:21]
  assign Butterfly_io_in1_Im = _T_86_Im; // @[butterfly.scala 27:21]
  assign Butterfly_io_in2_Re = io_dIn_Re; // @[butterfly.scala 28:21]
  assign Butterfly_io_in2_Im = io_dIn_Im; // @[butterfly.scala 28:21]
  assign Butterfly_io_wn_Re = 3'h7 == count[2:0] ? $signed(-32'shec83) : $signed(_GEN_7); // @[butterfly.scala 29:20]
  assign Butterfly_io_wn_Im = 3'h7 == count[2:0] ? $signed(-32'sh61f8) : $signed(_GEN_15); // @[butterfly.scala 29:20]
  assign Switch_io_in1_Re = Butterfly_io_out1_Re; // @[butterfly.scala 50:21]
  assign Switch_io_in1_Im = Butterfly_io_out1_Im; // @[butterfly.scala 50:21]
  assign Switch_io_in2_Re = _T_91_Re; // @[butterfly.scala 51:21]
  assign Switch_io_in2_Im = _T_91_Im; // @[butterfly.scala 51:21]
  assign Switch_io_sel = count[2]; // @[butterfly.scala 52:21]
  assign Butterfly_1_io_in1_Re = _T_99_Re; // @[butterfly.scala 27:21]
  assign Butterfly_1_io_in1_Im = _T_99_Im; // @[butterfly.scala 27:21]
  assign Butterfly_1_io_in2_Re = Switch_io_out2_Re; // @[butterfly.scala 28:21]
  assign Butterfly_1_io_in2_Im = Switch_io_out2_Im; // @[butterfly.scala 28:21]
  assign Butterfly_1_io_wn_Re = 2'h3 == count[1:0] ? $signed(-32'shb505) : $signed(_GEN_43); // @[butterfly.scala 29:20]
  assign Butterfly_1_io_wn_Im = 2'h3 == count[1:0] ? $signed(-32'shb505) : $signed(_GEN_47); // @[butterfly.scala 29:20]
  assign Switch_1_io_in1_Re = Butterfly_1_io_out1_Re; // @[butterfly.scala 50:21]
  assign Switch_1_io_in1_Im = Butterfly_1_io_out1_Im; // @[butterfly.scala 50:21]
  assign Switch_1_io_in2_Re = _T_102_Re; // @[butterfly.scala 51:21]
  assign Switch_1_io_in2_Im = _T_102_Im; // @[butterfly.scala 51:21]
  assign Switch_1_io_sel = count[1]; // @[butterfly.scala 52:21]
  assign Butterfly_2_io_in1_Re = _T_108_Re; // @[butterfly.scala 27:21]
  assign Butterfly_2_io_in1_Im = _T_108_Im; // @[butterfly.scala 27:21]
  assign Butterfly_2_io_in2_Re = Switch_1_io_out2_Re; // @[butterfly.scala 28:21]
  assign Butterfly_2_io_in2_Im = Switch_1_io_out2_Im; // @[butterfly.scala 28:21]
  assign Butterfly_2_io_wn_Re = count[0] ? $signed(32'sh0) : $signed(32'sh10000); // @[butterfly.scala 29:20]
  assign Butterfly_2_io_wn_Im = count[0] ? $signed(-32'sh10000) : $signed(32'sh0); // @[butterfly.scala 29:20]
  assign Switch_2_io_in1_Re = Butterfly_2_io_out1_Re; // @[butterfly.scala 50:21]
  assign Switch_2_io_in1_Im = Butterfly_2_io_out1_Im; // @[butterfly.scala 50:21]
  assign Switch_2_io_in2_Re = _T_110_Re; // @[butterfly.scala 51:21]
  assign Switch_2_io_in2_Im = _T_110_Im; // @[butterfly.scala 51:21]
  assign Switch_2_io_sel = count[0]; // @[butterfly.scala 52:21]
  assign ComplexAdd_io_op1_Re = out1D1_Re; // @[complex.scala 31:21]
  assign ComplexAdd_io_op1_Im = out1D1_Im; // @[complex.scala 31:21]
  assign ComplexAdd_io_op2_Re = Switch_2_io_out2_Re; // @[complex.scala 32:21]
  assign ComplexAdd_io_op2_Im = Switch_2_io_out2_Im; // @[complex.scala 32:21]
  assign ComplexSub_io_op1_Re = out1D1_Re; // @[complex.scala 45:21]
  assign ComplexSub_io_op1_Im = out1D1_Im; // @[complex.scala 45:21]
  assign ComplexSub_io_op2_Re = Switch_2_io_out2_Re; // @[complex.scala 46:21]
  assign ComplexSub_io_op2_Im = Switch_2_io_out2_Im; // @[complex.scala 46:21]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  count = _RAND_0[4:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  _T_79_Re = _RAND_1[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{`RANDOM}};
  _T_79_Im = _RAND_2[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{`RANDOM}};
  _T_80_Re = _RAND_3[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_4 = {1{`RANDOM}};
  _T_80_Im = _RAND_4[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_5 = {1{`RANDOM}};
  _T_81_Re = _RAND_5[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_6 = {1{`RANDOM}};
  _T_81_Im = _RAND_6[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_7 = {1{`RANDOM}};
  _T_82_Re = _RAND_7[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_8 = {1{`RANDOM}};
  _T_82_Im = _RAND_8[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_9 = {1{`RANDOM}};
  _T_83_Re = _RAND_9[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_10 = {1{`RANDOM}};
  _T_83_Im = _RAND_10[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_11 = {1{`RANDOM}};
  _T_84_Re = _RAND_11[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_12 = {1{`RANDOM}};
  _T_84_Im = _RAND_12[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_13 = {1{`RANDOM}};
  _T_85_Re = _RAND_13[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_14 = {1{`RANDOM}};
  _T_85_Im = _RAND_14[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_15 = {1{`RANDOM}};
  _T_86_Re = _RAND_15[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_16 = {1{`RANDOM}};
  _T_86_Im = _RAND_16[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_17 = {1{`RANDOM}};
  _T_88_Re = _RAND_17[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_18 = {1{`RANDOM}};
  _T_88_Im = _RAND_18[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_19 = {1{`RANDOM}};
  _T_89_Re = _RAND_19[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_20 = {1{`RANDOM}};
  _T_89_Im = _RAND_20[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_21 = {1{`RANDOM}};
  _T_90_Re = _RAND_21[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_22 = {1{`RANDOM}};
  _T_90_Im = _RAND_22[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_23 = {1{`RANDOM}};
  _T_91_Re = _RAND_23[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_24 = {1{`RANDOM}};
  _T_91_Im = _RAND_24[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_25 = {1{`RANDOM}};
  _T_96_Re = _RAND_25[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_26 = {1{`RANDOM}};
  _T_96_Im = _RAND_26[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_27 = {1{`RANDOM}};
  _T_97_Re = _RAND_27[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_28 = {1{`RANDOM}};
  _T_97_Im = _RAND_28[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_29 = {1{`RANDOM}};
  _T_98_Re = _RAND_29[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_30 = {1{`RANDOM}};
  _T_98_Im = _RAND_30[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_31 = {1{`RANDOM}};
  _T_99_Re = _RAND_31[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_32 = {1{`RANDOM}};
  _T_99_Im = _RAND_32[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_33 = {1{`RANDOM}};
  _T_101_Re = _RAND_33[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_34 = {1{`RANDOM}};
  _T_101_Im = _RAND_34[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_35 = {1{`RANDOM}};
  _T_102_Re = _RAND_35[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_36 = {1{`RANDOM}};
  _T_102_Im = _RAND_36[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_37 = {1{`RANDOM}};
  _T_107_Re = _RAND_37[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_38 = {1{`RANDOM}};
  _T_107_Im = _RAND_38[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_39 = {1{`RANDOM}};
  _T_108_Re = _RAND_39[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_40 = {1{`RANDOM}};
  _T_108_Im = _RAND_40[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_41 = {1{`RANDOM}};
  _T_110_Re = _RAND_41[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_42 = {1{`RANDOM}};
  _T_110_Im = _RAND_42[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_43 = {1{`RANDOM}};
  out1D1_Re = _RAND_43[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_44 = {1{`RANDOM}};
  out1D1_Im = _RAND_44[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_45 = {1{`RANDOM}};
  _T_111_Re = _RAND_45[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_46 = {1{`RANDOM}};
  _T_111_Im = _RAND_46[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_47 = {1{`RANDOM}};
  _T_112_Re = _RAND_47[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_48 = {1{`RANDOM}};
  _T_112_Im = _RAND_48[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_49 = {1{`RANDOM}};
  _T_113 = _RAND_49[4:0];
  `endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`endif // SYNTHESIS
  always @(posedge clock) begin
    if (reset) begin
      count <= 5'h0;
    end else if (_T) begin
      if (_T_1) begin
        count <= 5'h0;
      end else begin
        count <= _T_3;
      end
    end
    _T_79_Re <= io_dIn_Re;
    _T_79_Im <= io_dIn_Im;
    _T_80_Re <= _T_79_Re;
    _T_80_Im <= _T_79_Im;
    _T_81_Re <= _T_80_Re;
    _T_81_Im <= _T_80_Im;
    _T_82_Re <= _T_81_Re;
    _T_82_Im <= _T_81_Im;
    _T_83_Re <= _T_82_Re;
    _T_83_Im <= _T_82_Im;
    _T_84_Re <= _T_83_Re;
    _T_84_Im <= _T_83_Im;
    _T_85_Re <= _T_84_Re;
    _T_85_Im <= _T_84_Im;
    _T_86_Re <= _T_85_Re;
    _T_86_Im <= _T_85_Im;
    _T_88_Re <= Butterfly_io_out2_Re;
    _T_88_Im <= Butterfly_io_out2_Im;
    _T_89_Re <= _T_88_Re;
    _T_89_Im <= _T_88_Im;
    _T_90_Re <= _T_89_Re;
    _T_90_Im <= _T_89_Im;
    _T_91_Re <= _T_90_Re;
    _T_91_Im <= _T_90_Im;
    _T_96_Re <= Switch_io_out1_Re;
    _T_96_Im <= Switch_io_out1_Im;
    _T_97_Re <= _T_96_Re;
    _T_97_Im <= _T_96_Im;
    _T_98_Re <= _T_97_Re;
    _T_98_Im <= _T_97_Im;
    _T_99_Re <= _T_98_Re;
    _T_99_Im <= _T_98_Im;
    _T_101_Re <= Butterfly_1_io_out2_Re;
    _T_101_Im <= Butterfly_1_io_out2_Im;
    _T_102_Re <= _T_101_Re;
    _T_102_Im <= _T_101_Im;
    _T_107_Re <= Switch_1_io_out1_Re;
    _T_107_Im <= Switch_1_io_out1_Im;
    _T_108_Re <= _T_107_Re;
    _T_108_Im <= _T_107_Im;
    _T_110_Re <= Butterfly_2_io_out2_Re;
    _T_110_Im <= Butterfly_2_io_out2_Im;
    out1D1_Re <= Switch_2_io_out1_Re;
    out1D1_Im <= Switch_2_io_out1_Im;
    _T_111_Re <= ComplexAdd_io_res_Re;
    _T_111_Im <= ComplexAdd_io_res_Im;
    _T_112_Re <= ComplexSub_io_res_Re;
    _T_112_Im <= ComplexSub_io_res_Im;
    _T_113 <= count;
  end
endmodule
