import 'token_type.dart';

TokenType? symbolTypeOf(String c) {
  switch (c) {
    case '+':
      return TokenType.plus;
    case '-':
      return TokenType.minus;
    case '*':
      return TokenType.star;
    case '/':
      return TokenType.slash;
    case '^':
      return TokenType.caret;
    case '%':
      return TokenType.percent;
    case '(':
      return TokenType.lparen;
    case ')':
      return TokenType.rparen;
    case ',':
      return TokenType.comma;
    case '=':
      return TokenType.equals;
    default:
      return null;
  }
}
