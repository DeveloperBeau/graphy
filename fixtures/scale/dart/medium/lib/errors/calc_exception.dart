/// Base for every error surfaced to the REPL prompt.
class CalcException implements Exception {
  final String stage;
  final String message;

  CalcException(this.stage, this.message);

  String describe() => '[$stage] $message';
}
