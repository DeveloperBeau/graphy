package textprinter.render;

import java.util.List;

import textprinter.border.Frame;
import textprinter.style.Theme;

import static textprinter.util.TextUtil.repeatChar;

public class BorderPainter {
    private final Frame frame;

    public BorderPainter(Frame frame) {
        this.frame = frame;
    }

    public String paint(List<String> body, Theme theme, int innerWidth) {
        StringBuilder sb = new StringBuilder();
        String horizontal = repeatChar(frame.getHorizontal(), innerWidth + 2);
        sb.append(frame.getCorner()).append(horizontal).append(frame.getCorner()).append('\n');
        for (String line : body) {
            sb.append(frame.getVertical())
              .append(' ')
              .append(theme.apply(line))
              .append(' ')
              .append(frame.getVertical())
              .append('\n');
        }
        sb.append(frame.getCorner()).append(horizontal).append(frame.getCorner());
        return sb.toString();
    }
}
