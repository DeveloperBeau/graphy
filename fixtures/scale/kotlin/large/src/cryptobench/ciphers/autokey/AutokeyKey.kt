package cryptobench.ciphers.autokey

data class AutokeyKey(
    val primer: String,
) {
    fun primerLength(): Int = primer.length

    companion object {
        fun default(): AutokeyKey = AutokeyKey("EMBER")
    }
}
