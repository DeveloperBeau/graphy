struct SuiteReport {
    func build(_ outcomes: [VectorOutcome]) -> String {
        let table = TableRenderer()
        table.row("suite", "families")
        for suite in SuiteMap.suiteNames() {
            table.row(suite, String(SuiteMap.grouped()[suite]?.count ?? 0))
        }
        return table.render()
    }
}
