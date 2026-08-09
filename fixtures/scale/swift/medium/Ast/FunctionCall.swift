// A call to a builtin such as sin(x) or clamp(a, b, c).
struct FunctionCall: Node {
    let name: String
    let arguments: [Node]

    func describe() -> String {
        let parts = arguments.map { $0.describe() }
        return name + "(" + parts.joined(separator: ", ") + ")"
    }
}
