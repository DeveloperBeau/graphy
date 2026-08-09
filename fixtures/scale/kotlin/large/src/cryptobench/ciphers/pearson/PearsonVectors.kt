package cryptobench.ciphers.pearson

object PearsonVectors {
    fun samples(): List<String> = listOf(
        "MEET ME AT THE HARBOUR AT MIDNIGHT",
        "THE PACKAGE ARRIVES ON THE THIRD TRAIN",
        "COLD WINDS RISE OVER THE NORTHERN PASS",
    )

    fun count(): Int = samples().size
}
