package textprinter.style

object Styles {
  private val Esc = "\u001b["
  private val Reset = Esc + "0m"

  def bold(text: String): String = Esc + "1m" + text + Reset

  def dim(text: String): String = Esc + "2m" + text + Reset

  def underline(text: String): String = Esc + "4m" + text + Reset

  def colorize(text: String, ansiCode: Int): String =
    Esc + ansiCode.toString + "m" + text + Reset
}
