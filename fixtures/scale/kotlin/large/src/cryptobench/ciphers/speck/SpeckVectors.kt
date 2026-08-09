package cryptobench.ciphers.speck

object SpeckVectors {
    fun samples(): List<String> = listOf(
        "THE PACKAGE ARRIVES ON THE THIRD TRAIN",
        "COLD WINDS RISE OVER THE NORTHERN PASS",
        "SIGNAL FIRES BURN ALONG THE COAST TONIGHT",
    )

    fun count(): Int = samples().size
}
