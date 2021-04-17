package FFT
import chisel3._
import chisel3.experimental._
import chisel3.util._
import scala.math._     // sine, cosine table

class FFT extends Module with FPConfig with ElaborateConfig {
    val io = IO (new Bundle {
        val dIn = Input(new Complex)
        val din_valid = Input(Bool())
        val dOut1 = Output(new Complex)
        val dOut2 = Output(new Complex)
        val dout_valid = Output(Bool())
    })
    // FFTLength is power of 2
    val stages = log2Ceil (FFTLength)
    // cosine and sinusoid table, then wn (twiddle factor) table
    // returning a vector of FixedPoint
    def cosTable (k : Int) : Vec[FixedPoint] = {
        val times = (0 until FFTLength/2 by pow (2, k).toInt).map (i => -2 * Pi * i / FFTLength.toDouble)
        val inits = times.map (t => FixedPoint.fromDouble(cos(t), DataWidth.W, BinaryPoint.BP))
        VecInit (inits)
    }
    def sinTable (k : Int) : Vec[FixedPoint] = {
        val times = (0 until FFTLength/2 by pow (2, k).toInt).map (i => -2 * Pi * i / FFTLength.toDouble)
        val inits = times.map (t => FixedPoint.fromDouble(sin(t), DataWidth.W, BinaryPoint.BP))
        VecInit (inits)
    }
    // curried factory XD
    def wnTable (k : Int) (index : UInt) : Complex = {
        val res = Wire (new Complex)
        res.Re := cosTable (k) (index)
        res.Im := sinTable (k) (index)
        res
    }
    val count = RegInit(0.U((stages + 1).W))
    val busy = count =/= 0.U
    when (io.din_valid || busy) {
        count := Mux(count === (FFTLength * 3 / 2 - 1).asUInt(), 0.U, count + 1.U)
    }
    val out1 = VecInit(Seq.fill(stages + 1)(0.S((2 * DataWidth).W).asTypeOf(new Complex)))
    val out2 = VecInit(Seq.fill(stages + 1)(0.S((2 * DataWidth).W).asTypeOf(new Complex)))
    out1(0) := io.dIn
    out2(0) := io.dIn
    // ready? go!
    for (i <- 0 until stages - 1) {
        val wn_ctrl = count (stages - 2 - i, 0)
        val wn = wnTable (i) (wn_ctrl)
        // 看圖說話，進入蝶形算子前x1有延遲(using shift register to delay)
        val butterfly = Butterfly(ShiftRegister(out1(i), (FFTLength / pow(2, i + 1)).toInt), out2(i), wn)
        val sw_ctrl = count (stages - 2 - i)
        // 從butterfly出來後，x2也有延遲且為x1 delay的一半
        val sw = Switch(butterfly._1, ShiftRegister(butterfly._2, (FFTLength / pow(2, i + 2)).toInt), sw_ctrl)
        out1(i + 1) := sw._1  // 連線，進入下一級
        out2(i + 1) := sw._2
    }
    val out1D1 = RegNext(out1(stages - 1))
    out1(stages) := ComplexAdd(out1D1, out2(stages - 1))
    out2(stages) := ComplexSub(out1D1, out2(stages - 1))
    io.dOut1 := RegNext(out1(stages))
    io.dOut2 := RegNext(out2(stages))
    io.dout_valid := RegNext(count) === (FFTLength - 1).asUInt()
}
