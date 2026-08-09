// Backs the ":precision N" command; reads current precision with no argument.
enum PrecisionCommand {
    static func run(_ context: ReplContext, _ parts: [String]) -> String {
        guard parts.count > 1, let digits = Int(parts[1]) else {
            return "precision is \(context.settings.precision)"
        }
        context.settings.precision = digits
        return "precision set to \(digits)"
    }
}
