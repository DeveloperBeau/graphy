package textprinter

import textprinter.cli.ArgParser
import textprinter.model.Document
import textprinter.model.RenderOptions
import textprinter.render.Renderer

class Main {
    static void main(String[] args) {
        ArgParser parser = new ArgParser()
        RenderOptions options = parser.parse(args)
        String text = parser.positionalText(args)
        if (text.isEmpty()) {
            System.err.println("usage: textprinter [--align=MODE] [--width=N] [--frame=NAME] TEXT")
            System.exit(2)
        }
        Document document = Document.fromText(text)
        Renderer renderer = new Renderer(options)
        println renderer.render(document)
    }
}
