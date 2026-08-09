package cryptobench.ciphers.caesar

data class CaesarKey(
    val shift: Int,
) {
    fun normalized(): CaesarKey = CaesarKey(((shift % 26) + 26) % 26)

    companion object {
        fun default(): CaesarKey = CaesarKey(7)
    }
}
