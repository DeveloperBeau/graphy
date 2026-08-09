package textprinter.border

data class Frame(
    val corner: Char,
    val horizontal: Char,
    val vertical: Char,
) {
    /** The full top or bottom rule for a body of the given inner width. */
    fun rule(innerWidth: Int): String =
        corner + horizontal.toString().repeat(innerWidth + 2) + corner
}
