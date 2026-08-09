package textprinter

import textprinter.cli.ArgParser
import textprinter.model.Document
import textprinter.render.Renderer

object Main {
  def main(args: Array[String]): Unit = {
    val options = ArgParser.parse(args)
    val text = ArgParser.positionalText(args)
    if (text.isEmpty) {
      System.err.println("usage: textprinter [--align=MODE] [--width=N] [--frame=NAME] [--theme=NAME] TEXT")
      sys.exit(2)
    }
    val document = Document.fromText(text)
    val renderer = new Renderer(options)
    println(renderer.render(document))
  }
}
