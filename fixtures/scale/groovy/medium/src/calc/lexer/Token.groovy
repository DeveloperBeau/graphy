package calc.lexer

class Token {
    final TokenType type
    final String text
    final int position

    Token(TokenType type, String text, int position) {
        this.type = type
        this.text = text
        this.position = position
    }

    double numberValue() {
        return text.toDouble()
    }
}
