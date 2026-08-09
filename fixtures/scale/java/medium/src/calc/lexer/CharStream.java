package calc.lexer;

import java.util.function.IntPredicate;

public class CharStream {
    private final String source;
    private int index;

    public CharStream(String source) {
        this.source = source;
    }

    public boolean hasNext() { return index < source.length(); }

    public char peek() { return source.charAt(index); }

    public char next() { return source.charAt(index++); }

    public int position() { return index; }

    public void skipWhitespace() {
        while (hasNext() && Character.isWhitespace(peek())) {
            index++;
        }
    }

    public String takeWhile(IntPredicate accept) {
        StringBuilder sb = new StringBuilder();
        while (hasNext() && accept.test(peek())) {
            sb.append(next());
        }
        return sb.toString();
    }
}
