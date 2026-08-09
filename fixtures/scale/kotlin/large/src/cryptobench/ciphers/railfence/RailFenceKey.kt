package cryptobench.ciphers.railfence

data class RailFenceKey(
    val rails: Int,
) {
    fun cycleLength(): Int = 2 * (rails - 1)

    companion object {
        fun default(): RailFenceKey = RailFenceKey(3)
    }
}
