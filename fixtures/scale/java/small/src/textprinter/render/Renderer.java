package textprinter.render;

import java.util.ArrayList;
import java.util.List;

import textprinter.border.Frame;
import textprinter.border.Frames;
import textprinter.layout.Aligner;
import textprinter.layout.Wrapper;
import textprinter.model.Document;
import textprinter.model.RenderOptions;
import textprinter.style.Theme;

public class Renderer {
    private final RenderOptions options;

    public Renderer(RenderOptions options) {
        this.options = options;
    }

    public String render(Document document) {
        int innerWidth = options.getWidth();
        List<String> body = new ArrayList<>();
        for (String line : document.getLines()) {
            for (String piece : Wrapper.wrap(line, innerWidth)) {
                body.add(Aligner.align(piece, innerWidth, options.getAlign()));
            }
        }
        Frame frame = Frames.byName(options.getFrameName());
        Theme theme = Theme.named(options.getThemeName());
        BorderPainter painter = new BorderPainter(frame);
        return painter.paint(body, theme, innerWidth);
    }
}
