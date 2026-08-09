// Thrown while walking the AST: unknown variables, unknown functions,
// or arithmetic errors such as division by zero.
struct EvalError: Error {
    let message: String
    let subject: String

    func pretty() -> String {
        return message + ": " + subject
    }
}
