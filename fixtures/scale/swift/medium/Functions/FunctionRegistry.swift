final class FunctionRegistry {
    private var table: [String: ([Double]) -> Double] = [:]

    func define(_ name: String, _ body: @escaping ([Double]) -> Double) {
        table[name] = body
    }

    func invoke(_ name: String, _ arguments: [Double]) throws -> Double {
        guard let body = table[name] else {
            throw EvalError(message: "unknown function", subject: name)
        }
        return body(arguments)
    }

    func names() -> [String] {
        return table.keys.sorted()
    }
}
