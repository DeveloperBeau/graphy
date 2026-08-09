// A prefix operator applied to a single operand, e.g. "-x".
//
// Only negation is produced by the parser today.
struct UnaryOp: Node {
    let op: String
    let operand: Node

    func describe() -> String {
        return op + operand.describe()
    }
}
