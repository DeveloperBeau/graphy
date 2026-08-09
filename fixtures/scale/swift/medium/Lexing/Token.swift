import Foundation

struct Token {
    let kind: TokenKind
    let text: String

    func numberValue() -> Double {
        return Double(text) ?? 0
    }
}
