package textprinter.border

fun asciiFrame(): Frame = Frame('+', '-', '|')

fun roundedFrame(): Frame = Frame('o', '─', '│')

fun doubleFrame(): Frame = Frame('╔', '═', '║')

fun frameNamed(name: String): Frame = when (name) {
    "rounded" -> roundedFrame()
    "double" -> doubleFrame()
    else -> asciiFrame()
}
