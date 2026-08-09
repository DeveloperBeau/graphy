// Common interface implemented by every expression tree node produced
// by the parser and consumed by the evaluator.
//
// Kept deliberately small: describe() is the only shared behavior,
// so new node kinds (NumberLiteral, BinaryOp, ...) stay lightweight.
protocol Node {
    // Renders the node back to a source-like fragment, used for
    // history logging and error messages.
    func describe() -> String
}
