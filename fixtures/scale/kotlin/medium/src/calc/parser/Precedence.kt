package calc.parser

import calc.lexer.TokenType

const val LOWEST = 0

fun precedenceOf(type: TokenType): Int = when (type) {
    TokenType.PLUS, TokenType.MINUS -> 10
    TokenType.STAR, TokenType.SLASH, TokenType.PERCENT -> 20
    TokenType.CARET -> 30
    else -> LOWEST
}

fun rightAssociative(type: TokenType): Boolean = type == TokenType.CARET

/** The minimum precedence for the right-hand side of the given operator. */
fun nextLevelFor(type: TokenType): Int =
    if (rightAssociative(type)) precedenceOf(type) - 1 else precedenceOf(type)
