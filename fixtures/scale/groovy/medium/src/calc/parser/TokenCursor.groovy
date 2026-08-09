package calc.parser

import calc.errors.ParseException
import calc.lexer.Token
import calc.lexer.TokenType

class TokenCursor {
    private final List<Token> tokens
    private int index = 0

    TokenCursor(List<Token> tokens) {
        this.tokens = tokens
    }

    Token peek() {
        return tokens[index]
    }

    Token advance() {
        return tokens[index++]
    }

    boolean atType(TokenType type) {
        return peek().type == type
    }

    boolean accept(TokenType type) {
        if (!atType(type)) return false
        index++
        return true
    }

    void expect(TokenType type) {
        if (advance().type != type) throw new ParseException("expected " + type)
    }
}
