final class Environment {
    private var variables: [String: Double] = [:]

    func assign(_ name: String, _ value: Double) {
        variables[name] = value
    }

    func resolve(_ name: String) throws -> Double {
        guard let value = variables[name] else {
            throw EvalError(message: "unknown variable", subject: name)
        }
        return value
    }

    func names() -> [String] {
        return variables.keys.sorted()
    }
}
