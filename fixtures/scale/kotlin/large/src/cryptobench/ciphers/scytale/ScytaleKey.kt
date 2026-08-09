package cryptobench.ciphers.scytale

data class ScytaleKey(
    val rows: Int,
) {
    fun circumference(): Int = rows

    companion object {
        fun default(): ScytaleKey = ScytaleKey(4)
    }
}
