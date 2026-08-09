package calc.lexer;

public class Symbols {
    public static TokenType typeOf(char c) {
        switch (c) {
            case '+': return TokenType.PLUS;
            case '-': return TokenType.MINUS;
            case '*': return TokenType.STAR;
            case '/': return TokenType.SLASH;
            case '^': return TokenType.CARET;
            case '%': return TokenType.PERCENT;
            case '(': return TokenType.LPAREN;
            case ')': return TokenType.RPAREN;
            case ',': return TokenType.COMMA;
            case '=': return TokenType.EQUALS;
            default: return null;
        }
    }
}
