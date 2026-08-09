enum HelpCommand {
    static func run(_ context: ReplContext, _ parts: [String]) -> String {
        let names = context.functions.names().joined(separator: ", ")
        return [
            "commands: :help :vars :history :precision N :angle MODE :quit",
            "functions: " + names,
            "assign with  name = expression",
        ].joined(separator: "\n")
    }
}
