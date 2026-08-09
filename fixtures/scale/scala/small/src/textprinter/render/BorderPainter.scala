package textprinter.render

import textprinter.border.Frame
import textprinter.style.Theme

final class BorderPainter(frame: Frame) {

  def paint(body: List[String], theme: Theme, width: Int): String = {
    val sb = new StringBuilder
    sb.append(frame.rule(width)).append('\n')
    for (line <- body) {
      sb.append(frame.vertical).append(' ')
      sb.append(theme.apply(line))
      sb.append(' ').append(frame.vertical).append('\n')
    }
    sb.append(frame.rule(width))
    sb.toString
  }
}
