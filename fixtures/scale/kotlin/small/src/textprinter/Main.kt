package textprinter

import textprinter.cli.parseArgs
import textprinter.cli.positionalText
import textprinter.model.Document
import textprinter.render.Renderer
import kotlin.system.exitProcess

fun main(args: Array<String>) {
    val options = parseArgs(args)
    val text = positionalText(args)
    if (text.isEmpty()) {
        System.err.println("usage: textprinter [--align=MODE] [--width=N] [--frame=NAME] [--theme=NAME] TEXT")
        exitProcess(2)
    }
    val document = Document.fromText(text)
    println(Renderer(options).render(document))
}
