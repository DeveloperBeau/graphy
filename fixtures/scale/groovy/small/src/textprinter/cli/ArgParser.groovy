package textprinter.cli

import textprinter.model.RenderOptions

class ArgParser {
    RenderOptions parse(String[] args) {
        RenderOptions options = new RenderOptions()
        args.each { arg ->
            if (arg.startsWith("--align=")) {
                options.align = valueOf(arg)
            } else if (arg.startsWith("--width=")) {
                options.width = valueOf(arg).toInteger()
            } else if (arg.startsWith("--frame=")) {
                options.frameName = valueOf(arg)
            }
        }
        return options
    }

    String positionalText(String[] args) {
        return args.findAll { !it.startsWith("--") }.join(" ")
    }

    private String valueOf(String arg) {
        return arg.substring(arg.indexOf('=') + 1)
    }
}
