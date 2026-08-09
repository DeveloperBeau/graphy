// A literal numeric constant, e.g. "3.14".
//
// Produced by Parser.parsePrimary() for any digit-leading token.
struct NumberLiteral: Node {
    let value: Double

    func describe() -> String {
        return String(value)
    }
}
