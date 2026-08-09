package cryptobench.ciphers.lcg

data class LcgKey(
    val seed: Long,
) {
    fun withStride(stride: Long): LcgKey = LcgKey(seed + stride)

    companion object {
        fun default(): LcgKey = LcgKey(0x0DDC0FFEE)
    }
}
