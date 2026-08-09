package cryptobench.ciphers.xorshift

data class XorShiftKey(
    val seed: Long,
) {
    fun isZeroSeed(): Boolean = seed == 0L

    companion object {
        fun default(): XorShiftKey = XorShiftKey(0x1A2B3C4D5E6F)
    }
}
