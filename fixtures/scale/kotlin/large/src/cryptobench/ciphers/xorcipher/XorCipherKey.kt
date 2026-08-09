package cryptobench.ciphers.xorcipher

data class XorCipherKey(
    val phrase: String,
) {
    fun phraseLength(): Int = phrase.length

    companion object {
        fun default(): XorCipherKey = XorCipherKey("drift-anchor-22")
    }
}
