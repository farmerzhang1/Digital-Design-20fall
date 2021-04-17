package FFT

import chisel3.util._
import chisel3.iotesters
import chisel3.iotesters.{ChiselFlatSpec, Driver, PeekPokeTester}

class MyComplex(val Re: Double, val Im: Double) {
    def +(rhs: MyComplex): MyComplex = new MyComplex(Re + rhs.Re, Im + rhs.Im)
    def -(rhs: MyComplex): MyComplex = new MyComplex(Re - rhs.Re, Im - rhs.Im)
    def *(rhs: MyComplex): MyComplex = new MyComplex(Re * rhs.Re - Im * rhs.Im, rhs.Re * Im + Re * rhs.Im)
}
object FFTTestMain extends App {
    iotesters.Driver.execute(args, () => new FFT) {
        c => new FFTTest(c)
    }
}

class FFTTest(c : FFT) extends PeekPokeTester(c)
    with FPConfig
    with ElaborateConfig {
    def fft(x: Array[MyComplex]): Array[MyComplex] = {
        require(x.length > 0 && (x.length & (x.length - 1)) == 0, "array size should be power of two")
        fft(x, 0, x.length, 1)
    }

    def fft(x: Array[Double]): Array[MyComplex] = fft(x.map(Re => new MyComplex(Re, 0.0)))

    private def fft(x: Array[MyComplex], start: Int, n: Int, stride: Int) : Array[MyComplex] = {
        if (n == 1) {
            return Array(x(start))
        }
        // divide and conquer
        val X = fft(x, start, n / 2, 2 * stride) ++ fft(x, start + stride, n / 2, 2 * stride)

        for (k <- 0 until n / 2) {
            val t = X(k)
            val arg = -2 * math.Pi * k / n
            val c = new MyComplex(math.cos(arg), math.sin(arg)) * X(k + n / 2)
            X(k) = t + c
            X(k + n / 2) = t - c
        }
        X
    }

    def range(a: Int, upBound: Int, downBound: Int) : Int = {
        assert(upBound < 32)
        assert(downBound >= 0)
        return (a >> downBound) & (0xffffffff >>> (31 - upBound + downBound))
    }
    // reverse the bits, 因為在一大堆蝶形算子和switch中原本的順序會被打亂，且一開始輸入數據的時候不是倒位序
    def reverse(a: Int, len: Int): Int = {
        var res: Int = 0
        for(i <- 0 until len) {
        res = res | range(a, i, i) << (len-1-i)
        }
        res
    }

    val r = new scala.util.Random
    var bound: Double = math.pow(2.0, BinaryPoint)
    var error: Double = 0
    var ovNum: Int = 0
    var iterNum: Int = 2

    for (t <- 0 until iterNum) {
        var a = new Array[MyComplex](FFTLength)
        var cnt = 0
        // [0, FFTLength)
        for (i <- 0 until FFTLength) {
            // get random number in [-bound/2, bound/2]
            var Re = -bound.toInt / 2 + r.nextInt(bound.toInt)
            var Im = -bound.toInt / 2 + r.nextInt(bound.toInt)
            // add to array
            a(cnt) = new MyComplex(2 * Re / bound, 2 * Im / bound)
            // some inputs
            poke(c.io.dIn.Re, Re)
            poke(c.io.dIn.Im, Im)
            poke(c.io.din_valid, 1)
            step(1) // tick
            cnt += 1
        }
        var ref = fft(a)    // get standard FFT output

        var errorOne: Double = 0
        var error1: Double = 0
        var ovNum1: Int = 0         // overflow number
        var eps: Double = 1e-9
        for (i <- 0 until FFTLength / 2) {
            var ref1 = ref(reverse(i * 2, log2Ceil(FFTLength)))
            var d1 = peek(c.io.dOut1)
            printf ("ref1: %f + %fi\nfft : %f + %fi\n\n", ref1.Re, ref1.Im, 2 * d1("Re").toDouble/bound, 2*d1("Im").toDouble/bound)
            printf ("\n")
            error1 = math.abs((((2 * d1("Re").toDouble / bound) - ref1.Re) / (ref1.Re + eps) + ((2 * d1("Im").toDouble / bound) - ref1.Im) / (ref1.Im + eps)) / 2.0)
            if (error1 <= 0.5) {
                errorOne += error1
            } else {
                ovNum1 += 1
            }
            var ref2 = ref(reverse(i * 2 + 1, log2Ceil(FFTLength)))
            var d2 = peek(c.io.dOut2)
            printf ("ref2: %f + %fi\nfft : %f + %fi\n", ref2.Re, ref2.Im, 2 * d2("Re").toDouble/bound, 2*d2("Im").toDouble/bound)
            printf ("\n")
            error1 = math.abs((((2 * d2("Re").toDouble / bound) - ref2.Re) / (ref2.Re + eps) + ((2 * d2("Im").toDouble / bound) - ref2.Im) / (ref2.Im + eps)) / 2.0)
            if (error1 <= 0.5) {
                errorOne += error1
            } else {
                ovNum1 += 1
            }
            step(1)
        }
        errorOne = errorOne / (FFTLength - ovNum1)
        ovNum += ovNum1
        error += errorOne
        var errorOnePercent = errorOne * 100
        printf("In this sample, Error rate: %.2f%%\n", errorOnePercent)
    }

    error /= iterNum
    print("Total error rate is: " + error*100 + "%\n")
}