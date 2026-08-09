import '../lexer/token_type.dart';

const lowest = 0;

int precedenceOf(TokenType type) {
  switch (type) {
    case TokenType.plus:
    case TokenType.minus:
      return 10;
    case TokenType.star:
    case TokenType.slash:
    case TokenType.percent:
      return 20;
    case TokenType.caret:
      return 30;
    default:
      return lowest;
  }
}

bool rightAssociative(TokenType type) => type == TokenType.caret;

/// The minimum precedence for the right-hand side of the given operator.
int nextLevelFor(TokenType type) =>
    rightAssociative(type) ? precedenceOf(type) - 1 : precedenceOf(type);
