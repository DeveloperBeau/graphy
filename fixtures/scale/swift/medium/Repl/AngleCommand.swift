// Backs the ":angle radians|degrees" command used by the trig functions.
enum AngleCommand {
    static func run(_ context: ReplContext, _ parts: [String]) -> String {
        guard parts.count > 1 else {
            return "angle mode is \(context.settings.angle)"
        }
        context.settings.angle = parts[1] == "degrees" ? .degrees : .radians
        return "angle mode set to \(context.settings.angle)"
    }
}
