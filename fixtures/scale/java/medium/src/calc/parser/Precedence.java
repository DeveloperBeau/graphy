package calc.parser;

import calc.lexer.TokenType;

public class Precedence {
    public static final int LOWEST = 0;
    public static final int ADDITIVE = 10;
    public static final int MULTIPLICATIVE = 20;
    public static final int POWER = 30;

    public static int of(TokenType type) {
        switch (type) {
            case PLUS:
            case MINUS:
                return ADDITIVE;
            case STAR:
            case SLASH:
            case PERCENT:
                return MULTIPLICATIVE;
            case CARET:
                return POWER;
            default:
                return LOWEST;
        }
    }

    public static boolean rightAssociative(TokenType type) {
        return type == TokenType.CARET;
    }

    /** The minimum precedence for the right-hand side of the given operator. */
    public static int nextFor(TokenType type) {
        return rightAssociative(type) ? of(type) - 1 : of(type);
    }
}
