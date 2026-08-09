package calc.parser;

import java.util.List;

import calc.errors.ParseException;
import calc.lexer.Token;
import calc.lexer.TokenType;

public class TokenCursor {
    private final List<Token> tokens;
    private int index;

    public TokenCursor(List<Token> tokens) {
        this.tokens = tokens;
    }

    public Token peek() { return tokens.get(index); }

    public Token advance() { return tokens.get(index++); }

    public boolean atType(TokenType type) { return peek().getType() == type; }

    public boolean accept(TokenType type) {
        if (!atType(type)) return false;
        index++;
        return true;
    }

    public void expect(TokenType type) {
        if (advance().getType() != type) {
            throw new ParseException("expected " + type);
        }
    }
}
