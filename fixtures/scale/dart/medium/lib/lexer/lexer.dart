import '../errors/lex_exception.dart';
import 'char_stream.dart';
import 'symbols.dart';
import 'token.dart';
import 'token_type.dart';

class Lexer {
  final CharStream _stream;

  Lexer(String source) : _stream = CharStream(source);

  List<Token> tokenize() {
    final tokens = <Token>[];
    _stream.skipWhitespace();
    while (_stream.hasNext) {
      final at = _stream.position;
      final c = _stream.peek();
      if (_isDigit(c) || c == '.') {
        tokens.add(Token(TokenType.number, _stream.takeWhile((x) => _isDigit(x) || x == '.'), at));
      } else if (_isLetter(c)) {
        tokens.add(Token(TokenType.identifier, _stream.takeWhile(_isLetterOrDigit), at));
      } else {
        final type = symbolTypeOf(_stream.next());
        if (type == null) throw LexException("unexpected character '$c' at $at");
        tokens.add(Token(type, c, at));
      }
      _stream.skipWhitespace();
    }
    tokens.add(Token(TokenType.end, '', _stream.position));
    return tokens;
  }

  bool _isDigit(String c) => c.compareTo('0') >= 0 && c.compareTo('9') <= 0;
  bool _isLetter(String c) => RegExp(r'[A-Za-z]').hasMatch(c);
  bool _isLetterOrDigit(String c) => _isDigit(c) || _isLetter(c);
}
