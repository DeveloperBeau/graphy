import 'calc_exception.dart';

class ParseException extends CalcException {
  ParseException(String message) : super('parse', message);

  factory ParseException.expected(String what) => ParseException('expected $what');
}
