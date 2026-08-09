// An infix operator applied to two operands, e.g. "a + b".
struct BinaryOp: Node {
    let op: String
    let left: Node
    let right: Node

    func describe() -> String {
        return "(" + left.describe() + " " + op + " " + right.describe() + ")"
    }
}
