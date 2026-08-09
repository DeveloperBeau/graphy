// A reference to a variable previously bound via Assignment.
//
// Resolved against Environment at evaluation time, not parse time.
struct VariableRef: Node {
    let name: String

    func describe() -> String {
        return name
    }
}
