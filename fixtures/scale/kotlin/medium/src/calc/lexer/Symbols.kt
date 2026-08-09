package calc.lexer

fun symbolTypeOf(c: Char): TokenType? = when (c) {
    '+' -> TokenType.PLUS
    '-' -> TokenType.MINUS
    '*' -> TokenType.STAR
    '/' -> TokenType.SLASH
    '^' -> TokenType.CARET
    '%' -> TokenType.PERCENT
    '(' -> TokenType.LPAREN
    ')' -> TokenType.RPAREN
    ',' -> TokenType.COMMA
    '=' -> TokenType.EQUALS
    else -> null
}
