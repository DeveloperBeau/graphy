package cryptobench.ciphers.autokey

object AutokeyVectors {
    fun samples(): List<String> = listOf(
        "THE ARCHIVE KEY IS UNDER THE FOURTH STONE",
        "SILVER BIRDS CARRY WORDS ACROSS THE SEA",
        "THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG",
    )

    fun count(): Int = samples().size
}
