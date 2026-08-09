package textprinter.util

fun padTo(line: String, width: Int): String =
    if (line.length >= width) line else line + " ".repeat(width - line.length)

fun repeatChar(c: Char, count: Int): String = c.toString().repeat(count)

/** Length as seen on screen, ignoring ANSI escape sequences. */
fun visibleLength(line: String): Int =
    line.replace(Regex("\u001b\\[[0-9;]*m"), "").length
