package textprinter.layout

import textprinter.util.TextUtil

object Aligner {
  def alignLeft(line: String, width: Int): String = TextUtil.padTo(line, width)

  def alignRight(line: String, width: Int): String =
    " " * math.max(0, width - line.length) + line

  def alignCenter(line: String, width: Int): String = {
    val gap = math.max(0, width - line.length)
    TextUtil.padTo(" " * (gap / 2) + line, width)
  }

  def align(line: String, width: Int, mode: String): String = mode match {
    case "right"  => alignRight(line, width)
    case "center" => alignCenter(line, width)
    case _        => alignLeft(line, width)
  }
}
