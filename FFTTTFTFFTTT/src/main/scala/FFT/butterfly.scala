package FFT

import chisel3._
import chisel3.experimental._


class ButterflyIO extends Bundle
    with FPConfig {
    val in1 = Input(new Complex)
    val in2 = Input(new Complex)
    val wn = Input(new Complex)
    val out1 = Output(new Complex)
    val out2 = Output(new Complex)
}

class Butterfly extends Module {
    val io = IO(new ButterflyIO())
    val add1 = ComplexAdd(io.in1, io.in2)
    val sub2 = ComplexSub(io.in1, io.in2)
    val mul2 = ComplexMul(sub2, io.wn)
    io.out1 := add1
    io.out2 := mul2
}
object Butterfly {
    def apply(in1: Complex, in2: Complex, wn: Complex): (Complex, Complex) = {
        val inst = Module(new Butterfly)
        inst.io.in1 := in1
        inst.io.in2 := in2
        inst.io.wn := wn
        (inst.io.out1, inst.io.out2)
    }
}
class SwitchIO extends Bundle {
    val in1 = Input(new Complex)
    val in2 = Input(new Complex)
    val sel = Input(Bool())
    val out1 = Output(new Complex)
    val out2 = Output(new Complex)
}

class Switch extends Module {
    val io = IO(new SwitchIO)
    io.out1 := Mux(io.sel, io.in2, io.in1)
    io.out2 := Mux(io.sel, io.in1, io.in2)
}

object Switch {
    def apply(in1: Complex, in2: Complex, sel: Bool): (Complex, Complex) = {
        val inst = Module(new Switch)
        inst.io.in1 := in1
        inst.io.in2 := in2
        inst.io.sel := sel
        (inst.io.out1, inst.io.out2)
    }
}