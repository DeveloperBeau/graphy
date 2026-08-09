package textprinter.util

object TextUtil {
  def padTo(line: String, width: Int): String =
    if (line.length >= width) line else line + " " * (width - line.length)

  def repeatChar(c: Char, count: Int): String = c.toString * count

  /** Length as seen on screen, ignoring ANSI escape sequences. */
  def visibleLength(line: String): Int =
    line.replaceAll("\u001b\\[[0-9;]*m", "").length
}
