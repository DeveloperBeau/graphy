enum Precedence {
    static func of(_ op: String) -> Int {
        switch op {
        case "+", "-": return 1
        case "*", "/", "%": return 2
        case "^": return 3
        default: return 0
        }
    }

    static func rightAssociative(_ op: String) -> Bool {
        return op == "^"
    }
}
