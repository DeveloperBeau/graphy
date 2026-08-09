package calc.parser

import calc.errors.ParseException
import calc.lexer.Token
import calc.lexer.TokenType

class TokenCursor(private val tokens: List<Token>) {
    private var index = 0

    fun peek(): Token = tokens[index]

    fun advance(): Token = tokens[index++]

    fun atType(type: TokenType): Boolean = peek().type == type

    fun accept(type: TokenType): Boolean {
        if (!atType(type)) return false
        index++
        return true
    }

    fun expect(type: TokenType) {
        if (advance().type != type) throw ParseException("expected " + type)
    }
}
