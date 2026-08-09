package textprinter.cli

import textprinter.model.RenderOptions

object ArgParser {
  def parse(args: Array[String]): RenderOptions =
    args.foldLeft(RenderOptions()) { (options, arg) =>
      if (arg.startsWith("--align=")) options.copy(align = valueOf(arg))
      else if (arg.startsWith("--width=")) options.copy(width = valueOf(arg).toInt)
      else if (arg.startsWith("--frame=")) options.copy(frameName = valueOf(arg))
      else if (arg.startsWith("--theme=")) options.copy(themeName = valueOf(arg))
      else options
    }

  def positionalText(args: Array[String]): String =
    args.filterNot(_.startsWith("--")).mkString(" ")

  private def valueOf(arg: String): String =
    arg.substring(arg.indexOf('=') + 1)
}
