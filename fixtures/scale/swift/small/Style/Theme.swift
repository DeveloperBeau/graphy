import Foundation

struct Theme {
    let name: String
    let prefix: String

    static func named(_ name: String) -> Theme {
        var prefix = ""
        if name == "bright" {
            prefix = AnsiPalette.bold
        } else if name == "mono" {
            prefix = AnsiPalette.dim
        }
        return Theme(name: name, prefix: prefix)
    }

    func apply(_ body: String) -> String {
        guard !prefix.isEmpty else { return body }
        return prefix + body + AnsiPalette.reset
    }
}
