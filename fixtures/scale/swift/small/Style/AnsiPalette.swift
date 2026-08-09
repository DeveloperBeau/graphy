import Foundation

enum AnsiPalette {
    static let reset = "\u{1b}[0m"
    static let bold = "\u{1b}[1m"
    static let dim = "\u{1b}[2m"

    static func colored(_ body: String, code: Int) -> String {
        return "\u{1b}[\(code)m" + body + reset
    }
}
