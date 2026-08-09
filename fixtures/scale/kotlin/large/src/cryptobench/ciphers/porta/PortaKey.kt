package cryptobench.ciphers.porta

data class PortaKey(
    val keyword: String,
) {
    fun keyCharAt(position: Int): Char = keyword[position % keyword.length]

    companion object {
        fun default(): PortaKey = PortaKey("MERIDIAN")
    }
}
