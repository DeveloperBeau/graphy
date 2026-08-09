package textprinter.render

import textprinter.border.frameNamed
import textprinter.layout.alignLine
import textprinter.layout.wrapLine
import textprinter.model.Document
import textprinter.model.RenderOptions
import textprinter.style.themeNamed

class Renderer(rawOptions: RenderOptions) {
    private val options = rawOptions.normalized()

    fun render(document: Document): String {
        val width = options.width
        val body = document.lines
            .flatMap { wrapLine(it, width) }
            .map { alignLine(it, width, options.align) }
        val frame = frameNamed(options.frameName)
        val theme = themeNamed(options.themeName)
        return BorderPainter(frame).paint(body, theme, width)
    }
}
