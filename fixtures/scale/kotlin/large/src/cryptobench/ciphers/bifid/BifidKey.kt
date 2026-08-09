package cryptobench.ciphers.bifid

data class BifidKey(
    val seedWord: String,
) {
    fun seedLength(): Int = seedWord.length

    companion object {
        fun default(): BifidKey = BifidKey("CIPHER")
    }
}
