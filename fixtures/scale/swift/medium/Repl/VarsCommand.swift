enum VarsCommand {
    static func run(_ context: ReplContext, _ parts: [String]) -> String {
        let table = TablePrinter(headers: ["name", "value"])
        for name in context.environment.names() {
            let value = (try? context.environment.resolve(name)) ?? 0
            table.add([name, NumberFormat.format(value, context.settings.precision)])
        }
        return table.render()
    }
}
