package calc.lexer

class Symbols {
    static TokenType typeOf(char c) {
        switch (c) {
            case '+' as char: return TokenType.PLUS
            case '-' as char: return TokenType.MINUS
            case '*' as char: return TokenType.STAR
            case '/' as char: return TokenType.SLASH
            case '^' as char: return TokenType.CARET
            case '%' as char: return TokenType.PERCENT
            case '(' as char: return TokenType.LPAREN
            case ')' as char: return TokenType.RPAREN
            case ',' as char: return TokenType.COMMA
            case '=' as char: return TokenType.EQUALS
            default: return null
        }
    }
}
