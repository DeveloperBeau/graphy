package calc.lexer;

import java.util.ArrayList;
import java.util.List;

import calc.errors.LexException;

public class Lexer {
    private final CharStream stream;

    public Lexer(String source) {
        this.stream = new CharStream(source);
    }

    public List<Token> tokenize() {
        List<Token> tokens = new ArrayList<>();
        stream.skipWhitespace();
        while (stream.hasNext()) {
            int at = stream.position();
            char c = stream.peek();
            if (Character.isDigit(c) || c == '.') {
                tokens.add(new Token(TokenType.NUMBER, stream.takeWhile(x -> Character.isDigit(x) || x == '.'), at));
            } else if (Character.isLetter(c)) {
                tokens.add(new Token(TokenType.IDENTIFIER, stream.takeWhile(Character::isLetterOrDigit), at));
            } else {
                TokenType type = Symbols.typeOf(stream.next());
                if (type == null) {
                    throw new LexException("unexpected character '" + c + "' at " + at);
                }
                tokens.add(new Token(type, String.valueOf(c), at));
            }
            stream.skipWhitespace();
        }
        tokens.add(new Token(TokenType.END, "", stream.position()));
        return tokens;
    }
}
