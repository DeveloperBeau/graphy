import 'calc_exception.dart';

class LexException extends CalcException {
  LexException(String message) : super('lex', message);

  factory LexException.at(String message, int position) =>
      LexException('$message at column $position');
}
