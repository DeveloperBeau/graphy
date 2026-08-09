package cryptobench.ciphers.variantbeaufort

data class VariantBeaufortKey(
    val keyword: String,
) {
    fun keyCharAt(position: Int): Char = keyword[position % keyword.length]

    companion object {
        fun default(): VariantBeaufortKey = VariantBeaufortKey("COBALT")
    }
}
