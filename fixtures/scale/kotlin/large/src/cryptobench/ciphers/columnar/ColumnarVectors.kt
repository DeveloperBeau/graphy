package cryptobench.ciphers.columnar

object ColumnarVectors {
    fun samples(): List<String> = listOf(
        "MEET ME AT THE HARBOUR AT MIDNIGHT",
        "THE PACKAGE ARRIVES ON THE THIRD TRAIN",
        "COLD WINDS RISE OVER THE NORTHERN PASS",
    )

    fun count(): Int = samples().size
}
