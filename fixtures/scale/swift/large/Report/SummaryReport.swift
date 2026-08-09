struct SummaryReport {
    func build(_ outcomes: [VectorOutcome], priorSessions: Int) -> String {
        let passed = outcomes.filter { $0.passed }.count
        let table = TableRenderer()
        table.row("metric", "value")
        table.row("families", String(outcomes.count))
        table.row("passed", String(passed))
        table.row("prior sessions", String(priorSessions))
        return table.render()
    }
}
