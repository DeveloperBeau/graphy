package textprinter.render

import textprinter.border.Frames
import textprinter.layout.Aligner
import textprinter.layout.Wrapper
import textprinter.model.Document
import textprinter.model.RenderOptions
import textprinter.style.Theme

final class Renderer(rawOptions: RenderOptions) {
  private val options = rawOptions.normalized

  def render(document: Document): String = {
    val width = options.width
    val body = document.lines
      .flatMap(line => Wrapper.wrap(line, width))
      .map(piece => Aligner.align(piece, width, options.align))
    val frame = Frames.byName(options.frameName)
    val theme = Theme.named(options.themeName)
    val painter = new BorderPainter(frame)
    painter.paint(body, theme, width)
  }
}
