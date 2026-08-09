import Foundation

let options = ArgParser.parse(Array(CommandLine.arguments.dropFirst()))
if options.showHelp {
    Usage.print_()
} else {
    let text = InputReader.readAll()
    let renderer = Renderer(options: options)
    print(renderer.render(text))
}
