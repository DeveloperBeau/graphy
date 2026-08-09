package textprinter.render

import textprinter.border.Frames
import textprinter.layout.Aligner
import textprinter.layout.Wrapper
import textprinter.model.Document
import textprinter.model.RenderOptions
import textprinter.style.Theme

class Renderer {
    private final RenderOptions options

    Renderer(RenderOptions rawOptions) {
        this.options = rawOptions.normalized()
    }

    String render(Document document) {
        int width = options.width
        List<String> body = []
        document.lines.each { line ->
            Wrapper.wrap(line, width).each { piece ->
                body << Aligner.align(piece, width, options.align)
            }
        }
        def frame = Frames.byName(options.frameName)
        def theme = Theme.named("plain")
        BorderPainter painter = new BorderPainter(frame)
        return painter.paint(body, theme, width)
    }
}
