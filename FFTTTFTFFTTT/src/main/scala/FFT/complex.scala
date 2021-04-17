package FFT
import chisel3._
import chisel3.experimental._

class Complex extends Bundle
    with FPConfig {
    val Re = FixedPoint(DataWidth.W, BinaryPoint.BP)
    val Im = FixedPoint(DataWidth.W, BinaryPoint.BP)
}

class ComplexIO extends Bundle {
    val op1 = Input(new Complex)
    val op2= Input(new Complex)
    val res = Output(new Complex)
}

class ComplexAdd extends Module {
    val io = IO(new ComplexIO)
    io.res.Re := io.op1.Re + io.op2.Re
    io.res.Im := io.op1.Im + io.op2.Im
}
/*
• The apply function is syntactic sugar to overload the () operator.
• You can define an apply method in classes that allow you to use object(arg) in your code
• You can define an apply function in the companion object typically to act as a factory
• (returns an object of the companion class).
*/
object ComplexAdd {
    def apply(op1: Complex, op2: Complex):Complex = {
        val inst = Module(new ComplexAdd)
        inst.io.op1 := op1
        inst.io.op2 := op2
        inst.io.res
    }
}

class ComplexSub extends Module {
    val io = IO(new ComplexIO)
    io.res.Re := io.op1.Re - io.op2.Re
    io.res.Im := io.op1.Im - io.op2.Im
}
object ComplexSub {
    def apply(op1: Complex, op2: Complex):Complex = {
        val inst = Module(new ComplexSub)
        inst.io.op1 := op1
        inst.io.op2 := op2
        inst.io.res
    }
}
class ComplexMul extends Module
    with ElaborateConfig {
    val io = IO(new ComplexIO)
    // gaussian multiplication
    val k1 = io.op2.Re * (io.op1.Re + io.op1.Im)
    val k2 = io.op1.Re * (io.op2.Im - io.op2.Re)
    val k3 = io.op1.Im * (io.op2.Re + io.op2.Im)
    io.res.Re := k1 - k3
    io.res.Im := k1 + k2
}
object ComplexMul {
    def apply(op1: Complex, op2: Complex):Complex = {
        val inst = Module(new ComplexMul)
        inst.io.op1 := op1
        inst.io.op2 := op2
        inst.io.res
    }
}
