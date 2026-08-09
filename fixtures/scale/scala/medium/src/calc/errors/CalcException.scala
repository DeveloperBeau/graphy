package calc.errors

/** Base for every error surfaced to the REPL prompt. */
class CalcException(val stage: String, message: String) extends RuntimeException(message) {

  def describe: String = "[" + stage + "] " + message

  def isUserError: Boolean = stage != "internal"

  def stageLabel: String = stage.toUpperCase
}
