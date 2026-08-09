// Backs the ":quit" command; stops the Repl.run() loop.
//
// The final message echoes back the session's calculation count so
// the user gets a small sense of closure before the prompt exits.
enum QuitCommand {
    static func run(_ context: ReplContext, _ parts: [String]) -> String {
        context.settings.running = false
        return "bye (\(context.history.count()) calculations this session)"
    }
}
