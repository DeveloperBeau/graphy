package textprinter.layout

import textprinter.util.padTo

fun alignLeft(line: String, width: Int): String = padTo(line, width)

fun alignRight(line: String, width: Int): String =
    " ".repeat((width - line.length).coerceAtLeast(0)) + line

fun alignCenter(line: String, width: Int): String {
    val gap = (width - line.length).coerceAtLeast(0)
    return padTo(" ".repeat(gap / 2) + line, width)
}

fun alignLine(line: String, width: Int, mode: String): String = when (mode) {
    "right" -> alignRight(line, width)
    "center" -> alignCenter(line, width)
    else -> alignLeft(line, width)
}
