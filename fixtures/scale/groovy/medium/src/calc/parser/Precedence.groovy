package calc.parser

import calc.lexer.TokenType

class Precedence {
    static final int LOWEST = 0

    static int of(TokenType type) {
        switch (type) {
            case TokenType.PLUS:
            case TokenType.MINUS:
                return 10
            case TokenType.STAR:
            case TokenType.SLASH:
            case TokenType.PERCENT:
                return 20
            case TokenType.CARET:
                return 30
            default:
                return LOWEST
        }
    }

    static boolean rightAssociative(TokenType type) {
        return type == TokenType.CARET
    }

    static int nextFor(TokenType type) {
        return rightAssociative(type) ? of(type) - 1 : of(type)
    }
}
