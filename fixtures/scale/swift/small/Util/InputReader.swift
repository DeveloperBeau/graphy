import Foundation

enum InputReader {
    static func readAll() -> String {
        var parts: [String] = []
        while let line = readLine() {
            parts.append(line.trimmingCharacters(in: .whitespaces))
        }
        return parts.joined(separator: " ")
    }
}
