final class Parser {
    private let stream: TokenStream

    init(_ source: String) {
        stream = TokenStream(source)
    }

    func parseStatement() -> Node {
        if stream.looksLikeAssignment() {
            let name = stream.advance().text
            _ = stream.advance()
            return Assignment(name: name, value: parseExpression(1))
        }
        return parseExpression(1)
    }

    func parseExpression(_ minPrecedence: Int) -> Node {
        var left = parsePrimary()
        while stream.current().kind == .op && Precedence.of(stream.current().text) >= minPrecedence {
            let op = stream.advance().text
            let next = Precedence.rightAssociative(op) ? Precedence.of(op) : Precedence.of(op) + 1
            left = BinaryOp(op: op, left: left, right: parseExpression(next))
        }
        return left
    }
}
