import Foundation

enum Wrapper {
    static func wrap(_ text: String, width: Int) -> [String] {
        var lines: [String] = []
        var current = ""
        for word in text.split(separator: " ") {
            if !current.isEmpty && current.count + word.count + 1 > width {
                lines.append(current)
                current = String(word)
            } else {
                current = current.isEmpty ? String(word) : current + " " + word
            }
        }
        if !current.isEmpty {
            lines.append(current)
        }
        return lines
    }
}
