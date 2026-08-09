import Foundation

final class Lexer {
    private let cursor: ScanCursor

    init(_ source: String) {
        cursor = ScanCursor(source)
    }

    func nextToken() -> Token {
        while !cursor.atEnd() && cursor.peek() == " " {
            _ = cursor.advance()
        }
        if cursor.atEnd() { return Token(kind: .end, text: "") }
        let ch = cursor.peek()
        if ch.isNumber { return readWhile(.number) { $0.isNumber || $0 == "." } }
        if ch.isLetter { return readWhile(.identifier) { $0.isLetter } }
        _ = cursor.advance()
        switch ch {
        case "(": return Token(kind: .leftParen, text: "(")
        case ")": return Token(kind: .rightParen, text: ")")
        case ",": return Token(kind: .comma, text: ",")
        case "=": return Token(kind: .equals, text: "=")
        default: return Token(kind: .op, text: String(ch))
        }
    }

    private func readWhile(_ kind: TokenKind, _ keep: (Character) -> Bool) -> Token {
        var text = ""
        while !cursor.atEnd() && keep(cursor.peek()) {
            text.append(cursor.advance())
        }
        return Token(kind: kind, text: text)
    }
}
