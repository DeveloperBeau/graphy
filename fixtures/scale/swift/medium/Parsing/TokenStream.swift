final class TokenStream {
    private var tokens: [Token] = []
    private var index = 0

    init(_ source: String) {
        let lexer = Lexer(source)
        var token = lexer.nextToken()
        while true {
            tokens.append(token)
            if token.kind == .end { break }
            token = lexer.nextToken()
        }
    }

    func current() -> Token {
        return tokens[index < tokens.count ? index : tokens.count - 1]
    }

    func advance() -> Token {
        let token = current()
        index += 1
        return token
    }

    func looksLikeAssignment() -> Bool {
        return tokens.count > 2 && tokens[0].kind == .identifier && tokens[1].kind == .equals
    }
}
