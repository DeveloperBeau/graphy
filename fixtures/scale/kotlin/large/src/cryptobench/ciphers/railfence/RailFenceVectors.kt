package cryptobench.ciphers.railfence

object RailFenceVectors {
    fun samples(): List<String> = listOf(
        "JACKDAWS LOVE MY BIG SPHINX OF QUARTZ",
        "MEET ME AT THE HARBOUR AT MIDNIGHT",
        "THE PACKAGE ARRIVES ON THE THIRD TRAIN",
    )

    fun count(): Int = samples().size
}
