package textprinter.cli

import textprinter.model.RenderOptions

fun parseArgs(args: Array<String>): RenderOptions {
    var options = RenderOptions()
    for (arg in args) {
        options = when {
            arg.startsWith("--align=") -> options.copy(align = arg.substringAfter('='))
            arg.startsWith("--width=") -> options.copy(width = arg.substringAfter('=').toInt())
            arg.startsWith("--frame=") -> options.copy(frameName = arg.substringAfter('='))
            arg.startsWith("--theme=") -> options.copy(themeName = arg.substringAfter('='))
            else -> options
        }
    }
    return options
}

fun positionalText(args: Array<String>): String =
    args.filterNot { it.startsWith("--") }.joinToString(" ")
