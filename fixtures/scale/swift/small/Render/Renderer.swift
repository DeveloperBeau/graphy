import Foundation

struct Renderer {
    let options: Options
    let theme: Theme

    init(options: Options) {
        self.options = options
        self.theme = Theme.named(options.themeName)
    }

    func render(_ text: String) -> String {
        let lines = Wrapper.wrap(text, width: options.width)
        var aligned = lines.map { Alignment.alignLine($0, width: options.width, mode: options.align) }
        if options.borderStyle != "none" {
            aligned = Border(style: options.borderStyle).frame(aligned, width: options.width)
        }
        return theme.apply(aligned.joined(separator: "\n"))
    }
}
