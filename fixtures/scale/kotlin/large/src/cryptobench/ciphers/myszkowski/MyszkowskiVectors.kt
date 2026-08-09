package cryptobench.ciphers.myszkowski

object MyszkowskiVectors {
    fun samples(): List<String> = listOf(
        "SIGNAL FIRES BURN ALONG THE COAST TONIGHT",
        "THE ARCHIVE KEY IS UNDER THE FOURTH STONE",
        "SILVER BIRDS CARRY WORDS ACROSS THE SEA",
    )

    fun count(): Int = samples().size
}
