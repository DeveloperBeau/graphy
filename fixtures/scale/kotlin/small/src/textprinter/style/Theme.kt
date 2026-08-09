package textprinter.style

class Theme(val name: String, private val textColor: Int, private val emphasize: Boolean) {

    fun apply(text: String): String {
        val colored = if (textColor == 0) text else Styles.colorize(text, textColor)
        return if (emphasize) Styles.bold(colored) else colored
    }
}

fun themeNamed(name: String): Theme = when (name) {
    "ocean" -> Theme(name, 36, false)
    "alert" -> Theme(name, 31, true)
    "forest" -> Theme(name, 32, false)
    else -> Theme("plain", 0, false)
}
