package textprinter.render

import textprinter.border.Frame
import textprinter.style.Theme

class BorderPainter(private val frame: Frame) {

    fun paint(body: List<String>, theme: Theme, width: Int): String {
        val sb = StringBuilder()
        sb.append(frame.rule(width)).append('\n')
        for (line in body) {
            sb.append(frame.vertical).append(' ')
            sb.append(theme.apply(line))
            sb.append(' ').append(frame.vertical).append('\n')
        }
        sb.append(frame.rule(width))
        return sb.toString()
    }
}
