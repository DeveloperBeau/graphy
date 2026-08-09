import '../ast/binary_expr.dart';
import '../ast/expr.dart';
import '../lexer/token.dart';
import '../lexer/token_type.dart';
import 'operands.dart';
import 'precedence.dart';
import 'token_cursor.dart';

class Parser {
  final TokenCursor cursor;

  Parser(List<Token> tokens) : cursor = TokenCursor(tokens);

  Expr parseExpression() {
    final root = parseBinary(lowest);
    cursor.expect(TokenType.end);
    return root;
  }

  Expr parseBinary(int minPrecedence) {
    var left = parsePrimary(this);
    while (precedenceOf(cursor.peek().type) > minPrecedence) {
      final op = cursor.advance();
      left = BinaryExpr(op.text, left, parseBinary(nextLevelFor(op.type)));
    }
    return left;
  }
}
