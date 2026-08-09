package calc.errors

final class EvalException(message: String) extends CalcException("eval", message) {
  def withFunction(function: String): EvalException = new EvalException(function + ": " + message)
}

object EvalException {
  /** Raised when a builtin gets an argument outside its domain. */
  def domain(function: String): EvalException =
    new EvalException(function + " called outside its domain")
}
