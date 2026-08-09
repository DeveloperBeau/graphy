package calc.errors

final class LexException(message: String) extends CalcException("lex", message) {
  def this(message: String, position: Int) = this(message + " at column " + position)
}

object LexException {
  /** Convenience for errors tied to a column in the source line. */
  def at(message: String, position: Int): LexException =
    new LexException(message + " at column " + position)
}
