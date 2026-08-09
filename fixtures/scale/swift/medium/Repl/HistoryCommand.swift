// Backs the ":history" command; shows the last ten evaluated lines.
enum HistoryCommand {
    static func run(_ context: ReplContext, _ parts: [String]) -> String {
        let table = TablePrinter(headers: ["expression", "value"])
        for entry in context.history.recent(10) {
            table.add([entry.expression, NumberFormat.format(entry.value, context.settings.precision)])
        }
        return table.render()
    }
}
