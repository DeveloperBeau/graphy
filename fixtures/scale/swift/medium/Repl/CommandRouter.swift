enum CommandRouter {
    static func dispatch(_ line: String, _ context: ReplContext) -> String {
        let parts = line.trimmingCharacters(in: CharacterSet(charactersIn: ":")).split(separator: " ").map(String.init)
        switch parts.first ?? "" {
        case "help": return HelpCommand.run(context, parts)
        case "vars": return VarsCommand.run(context, parts)
        case "history": return HistoryCommand.run(context, parts)
        case "precision": return PrecisionCommand.run(context, parts)
        case "angle": return AngleCommand.run(context, parts)
        case "quit": return QuitCommand.run(context, parts)
        default: return "unknown command :" + (parts.first ?? "")
        }
    }
}
