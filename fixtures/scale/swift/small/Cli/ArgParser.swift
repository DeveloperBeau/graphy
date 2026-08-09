import Foundation

enum ArgParser {
    static func parse(_ args: [String]) -> Options {
        var options = Options.defaults()
        var i = 0
        while i < args.count {
            switch args[i] {
            case "--width": i += 1; options.width = Int(args[i]) ?? options.width
            case "--align": i += 1; options.align = args[i]
            case "--border": i += 1; options.borderStyle = args[i]
            case "--theme": i += 1; options.themeName = args[i]
            case "--help": options.showHelp = true
            default: break
            }
            i += 1
        }
        return options
    }
}
