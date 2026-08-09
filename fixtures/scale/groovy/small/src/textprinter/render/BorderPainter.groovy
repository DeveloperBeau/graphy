package textprinter.render

import textprinter.border.Frame
import textprinter.style.Theme

class BorderPainter {
    private final Frame frame

    BorderPainter(Frame frame) {
        this.frame = frame
    }

    String paint(List<String> body, Theme theme, int width) {
        StringBuilder sb = new StringBuilder()
        sb.append(frame.rule(width)).append('\n')
        body.each { line ->
            sb.append(frame.vertical).append(' ')
            sb.append(theme.apply(line))
            sb.append(' ').append(frame.vertical).append('\n')
        }
        sb.append(frame.rule(width))
        return sb.toString()
    }
}
