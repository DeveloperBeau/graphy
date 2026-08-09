package cryptobench.ciphers.vigenere

data class VigenereKey(
    val keyword: String,
) {
    fun keyCharAt(position: Int): Char = keyword[position % keyword.length]

    companion object {
        fun default(): VigenereKey = VigenereKey("LANTERN")
    }
}
