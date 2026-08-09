import 'token_type.dart';

class Token {
  final TokenType type;
  final String text;
  final int position;

  Token(this.type, this.text, this.position);

  double numberValue() => double.parse(text);

  @override
  String toString() => '$type($text)';
}
