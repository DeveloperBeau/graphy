// A variable binding statement, e.g. "x = 1 + 2".
//
// Assigning also yields the assigned value, so "x = 1 + 2" prints "= 3".
struct Assignment: Node {
    let name: String
    let value: Node

    func describe() -> String {
        return name + " = " + value.describe()
    }
}
