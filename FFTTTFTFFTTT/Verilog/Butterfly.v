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
  input         clock,
  input         reset,
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
