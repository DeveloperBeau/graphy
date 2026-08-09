package textprinter.layout

fun wrapLine(line: String, width: Int): List<String> {
    val wrapped = mutableListOf<String>()
    val current = StringBuilder()
    for (word in line.split(" ")) {
        if (current.isNotEmpty() && current.length + 1 + word.length > width) {
            wrapped.add(current.toString())
            current.clear()
        }
        if (current.isNotEmpty()) current.append(' ')
        current.append(word)
    }
    if (current.isNotEmpty()) wrapped.add(current.toString())
    return wrapped.ifEmpty { listOf("") }
}
