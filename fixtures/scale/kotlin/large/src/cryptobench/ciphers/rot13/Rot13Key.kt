package cryptobench.ciphers.rot13

data class Rot13Key(
    val rounds: Int,
) {
    fun isIdentity(): Boolean = rounds % 2 == 0

    companion object {
        fun default(): Rot13Key = Rot13Key(1)
    }
}
