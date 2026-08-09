package textprinter.style

object Styles {
    private const val ESC = "\u001b["
    private const val RESET = ESC + "0m"

    fun bold(text: String): String = ESC + "1m" + text + RESET

    fun dim(text: String): String = ESC + "2m" + text + RESET

    fun underline(text: String): String = ESC + "4m" + text + RESET

    fun colorize(text: String, ansiCode: Int): String =
        ESC + ansiCode.toString() + "m" + text + RESET
}
