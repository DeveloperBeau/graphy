// Formats the two kinds of line the Repl prints: successful results
// and errors surfaced from parsing or evaluation.
enum ResultFormatter {
    static func formatResult(_ value: Double, _ settings: Settings) -> String {
        return "= " + NumberFormat.format(value, settings.precision)
    }

    static func formatError(_ kind: String, _ detail: String) -> String {
        return "! " + kind + ": " + detail
    }
}
