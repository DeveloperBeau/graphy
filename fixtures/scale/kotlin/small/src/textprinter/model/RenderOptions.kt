package textprinter.model

data class RenderOptions(
    val align: String = "left",
    val width: Int = 60,
    val frameName: String = "ascii",
    val themeName: String = "plain",
) {
    /** Clamp anything the flag parser let through to sane bounds. */
    fun normalized(): RenderOptions =
        copy(width = width.coerceIn(8, 200))
}
