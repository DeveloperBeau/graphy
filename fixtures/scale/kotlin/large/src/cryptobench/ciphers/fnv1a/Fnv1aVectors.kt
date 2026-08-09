package cryptobench.ciphers.fnv1a

object Fnv1aVectors {
    fun samples(): List<String> = listOf(
        "THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG",
        "PACK MY BOX WITH FIVE DOZEN LIQUOR JUGS",
        "SPHINX OF BLACK QUARTZ JUDGE MY VOW",
    )

    fun count(): Int = samples().size
}
