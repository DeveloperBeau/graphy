package cryptobench.ciphers.beaufort

data class BeaufortKey(
    val keyword: String,
) {
    fun keyCharAt(position: Int): Char = keyword[position % keyword.length]

    companion object {
        fun default(): BeaufortKey = BeaufortKey("GRANITE")
    }
}
