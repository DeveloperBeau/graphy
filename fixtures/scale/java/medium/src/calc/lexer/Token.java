package calc.lexer;

public class Token {
    private final TokenType type;
    private final String text;
    private final int position;

    public Token(TokenType type, String text, int position) {
        this.type = type;
        this.text = text;
        this.position = position;
    }

    public TokenType getType() {
        return type;
    }

    public String getText() {
        return text;
    }

    public int getPosition() {
        return position;
    }

    public double numberValue() {
        return Double.parseDouble(text);
    }
}
