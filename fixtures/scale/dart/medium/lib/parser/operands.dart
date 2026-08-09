import '../ast/assign_expr.dart';
import '../ast/call_expr.dart';
import '../ast/expr.dart';
import '../ast/number_expr.dart';
import '../ast/unary_expr.dart';
import '../ast/variable_expr.dart';
import '../errors/parse_exception.dart';
import '../lexer/token.dart';
import '../lexer/token_type.dart';
import 'parser.dart';
import 'precedence.dart';

/// Parses operands: literals, negation, grouping, calls, assignments, names.
Expr parsePrimary(Parser parser) {
  final token = parser.cursor.advance();
  switch (token.type) {
    case TokenType.number:
      return NumberExpr(token.numberValue());
    case TokenType.minus:
      return UnaryExpr('-', parsePrimary(parser));
    case TokenType.lparen:
      final inner = parser.parseBinary(lowest);
      parser.cursor.expect(TokenType.rparen);
      return inner;
    case TokenType.identifier:
      return parseName(parser, token);
    default:
      throw ParseException("unexpected token '${token.text}'");
  }
}

Expr parseName(Parser parser, Token name) {
  final cursor = parser.cursor;
  if (cursor.accept(TokenType.lparen)) {
    final args = <Expr>[];
    while (!cursor.atType(TokenType.rparen)) {
      args.add(parser.parseBinary(lowest));
      cursor.accept(TokenType.comma);
    }
    cursor.advance();
    return CallExpr(name.text, args);
  }
  if (cursor.accept(TokenType.equals)) {
    return AssignExpr(name.text, parser.parseBinary(lowest));
  }
  return VariableExpr(name.text);
}
