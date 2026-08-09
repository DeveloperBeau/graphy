package calc.lexer

class CharStream {
    private final String source
    private int index = 0

    CharStream(String source) {
        this.source = source
    }

    boolean hasNext() {
        return index < source.length()
    }

    char peek() {
        return source.charAt(index)
    }

    char next() {
        return source.charAt(index++)
    }

    int position() {
        return index
    }

    void skipWhitespace() {
        while (hasNext() && Character.isWhitespace(peek())) index++
    }

    String takeWhile(Closure<Boolean> accept) {
        StringBuilder sb = new StringBuilder()
        while (hasNext() && accept(peek())) sb.append(next())
        return sb.toString()
    }
}
