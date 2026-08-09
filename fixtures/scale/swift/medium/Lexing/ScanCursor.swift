import Foundation

final class ScanCursor {
    private let source: [Character]
    private var position = 0

    init(_ source: String) {
        self.source = Array(source)
    }

    func atEnd() -> Bool {
        return position >= source.count
    }

    func peek() -> Character {
        return atEnd() ? "\0" : source[position]
    }

    func advance() -> Character {
        let ch = source[position]
        position += 1
        return ch
    }
}
