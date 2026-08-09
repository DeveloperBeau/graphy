import '../errors/parse_exception.dart';
import '../lexer/token.dart';
import '../lexer/token_type.dart';

class TokenCursor {
  final List<Token> tokens;
  int _index = 0;

  TokenCursor(this.tokens);

  Token peek() => tokens[_index];

  Token advance() => tokens[_index++];

  bool atType(TokenType type) => peek().type == type;

  bool accept(TokenType type) {
    if (!atType(type)) return false;
    _index++;
    return true;
  }

  void expect(TokenType type) {
    if (advance().type != type) throw ParseException('expected $type');
  }
}
