extension Parser {
    func parsePrimary() -> Node {
        let token = stream.advance()
        if token.kind == .number { return NumberLiteral(value: token.numberValue()) }
        if token.kind == .op && token.text == "-" { return UnaryOp(op: "-", operand: parsePrimary()) }
        if token.kind == .leftParen {
            let inner = parseExpression(1)
            _ = stream.advance()
            return inner
        }
        if token.kind == .identifier && stream.current().kind == .leftParen {
            return FunctionCall(name: token.text, arguments: parseArguments())
        }
        return VariableRef(name: token.text)
    }

    func parseArguments() -> [Node] {
        _ = stream.advance()
        var arguments = [parseExpression(1)]
        while stream.current().kind == .comma {
            _ = stream.advance()
            arguments.append(parseExpression(1))
        }
        _ = stream.advance()
        return arguments
    }
}
