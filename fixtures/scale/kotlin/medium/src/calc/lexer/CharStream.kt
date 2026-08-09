package calc.lexer

class CharStream(private val source: String) {
    private var index = 0

    fun hasNext(): Boolean = index < source.length

    fun peek(): Char = source[index]

    fun next(): Char = source[index++]

    fun position(): Int = index

    fun skipWhitespace() {
        while (hasNext() && peek().isWhitespace()) index++
    }

    fun takeWhile(accept: (Char) -> Boolean): String {
        val sb = StringBuilder()
        while (hasNext() && accept(peek())) sb.append(next())
        return sb.toString()
    }
}
