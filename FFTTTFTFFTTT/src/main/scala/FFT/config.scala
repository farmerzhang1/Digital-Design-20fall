package FFT

// fixed point configuration
trait FPConfig {
    val DataWidth = 32
    val BinaryPoint = 16
}

trait ElaborateConfig {
    val FFTLength = 16
}