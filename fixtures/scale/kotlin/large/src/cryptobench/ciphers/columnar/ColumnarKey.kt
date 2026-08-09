package cryptobench.ciphers.columnar

data class ColumnarKey(val keyword: String) {

    /** Column indexes sorted by their keyword letter, ties left to right. */
    fun columnOrder(): IntArray =
        keyword.uppercase()
            .withIndex()
            .sortedWith(compareBy({ it.value }, { it.index }))
            .map { it.index }
            .toIntArray()

    /** Pads with X until the text fills whole rows. */
    fun padded(text: String): String {
        val sb = StringBuilder(text)
        while (sb.length % keyword.length != 0) sb.append('X')
        return sb.toString()
    }

    companion object {
        fun default(): ColumnarKey = ColumnarKey("ZEBRAS")
    }
}
