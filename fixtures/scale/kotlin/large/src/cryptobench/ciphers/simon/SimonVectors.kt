package cryptobench.ciphers.simon

object SimonVectors {
    fun samples(): List<String> = listOf(
        "COLD WINDS RISE OVER THE NORTHERN PASS",
        "SIGNAL FIRES BURN ALONG THE COAST TONIGHT",
        "THE ARCHIVE KEY IS UNDER THE FOURTH STONE",
    )

    fun count(): Int = samples().size
}
