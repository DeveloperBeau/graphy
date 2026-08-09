package cryptobench.ciphers.myszkowski

data class MyszkowskiKey(
    val keyword: String,
) {
    fun hasRepeats(): Boolean = keyword.toSet().size < keyword.length

    companion object {
        fun default(): MyszkowskiKey = MyszkowskiKey("TOMATO")
    }
}
