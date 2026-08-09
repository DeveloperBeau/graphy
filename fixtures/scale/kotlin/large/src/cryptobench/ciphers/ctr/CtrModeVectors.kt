package cryptobench.ciphers.ctr

object CtrModeVectors {
    fun samples(): List<String> = listOf(
        "SILVER BIRDS CARRY WORDS ACROSS THE SEA",
        "THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG",
        "PACK MY BOX WITH FIVE DOZEN LIQUOR JUGS",
    )

    fun count(): Int = samples().size
}
