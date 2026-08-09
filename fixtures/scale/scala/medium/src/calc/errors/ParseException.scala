package calc.errors

final class ParseException(message: String) extends CalcException("parse", message) {
  def withContext(context: String): ParseException = new ParseException(message + " in " + context)
}

object ParseException {
  /** The common "expected X" parse failure. */
  def expected(what: String): ParseException =
    new ParseException("expected " + what)
}
