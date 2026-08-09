package cryptobench.ciphers.gronsfeld

data class GronsfeldKey(
    val digits: String,
) {
    fun digitAt(position: Int): Int = digits[position % digits.length] - '0'

    companion object {
        fun default(): GronsfeldKey = GronsfeldKey("31415")
    }
}
