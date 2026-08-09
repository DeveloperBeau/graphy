package textprinter;

import textprinter.cli.ArgParser;
import textprinter.model.Document;
import textprinter.model.RenderOptions;
import textprinter.render.Renderer;

public class Main {
    public static void main(String[] args) {
        ArgParser parser = new ArgParser();
        RenderOptions options = parser.parse(args);
        String text = parser.remainingText(args);
        if (text.isEmpty()) {
            System.err.println("usage: textprinter [--align=left|center|right] [--width=N] [--frame=ascii|rounded|double] [--theme=NAME] TEXT");
            System.exit(2);
        }
        Document document = Document.fromText(text);
        Renderer renderer = new Renderer(options);
        System.out.println(renderer.render(document));
    }
}
