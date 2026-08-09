package textprinter.border

final case class Frame(corner: Char, horizontal: Char, vertical: Char) {

  /** The full top or bottom rule for a body of the given inner width. */
  def rule(innerWidth: Int): String =
    corner.toString + horizontal.toString * (innerWidth + 2) + corner.toString

  def sides(content: String): String =
    vertical.toString + " " + content + " " + vertical.toString
}
