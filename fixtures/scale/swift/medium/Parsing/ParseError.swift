// Thrown by the parser when it encounters an unexpected token.
struct ParseError: Error {
    let message: String
    let fragment: String

    // Human-readable form shown at the REPL prompt.
    func pretty() -> String {
        return message + " near '" + fragment + "'"
    }
}
