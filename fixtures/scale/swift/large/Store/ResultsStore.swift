struct ResultsStore {
    private let writer = JsonlWriter(path: StorePaths.resultsFile())
    private let reader = JsonlReader(path: StorePaths.resultsFile())

    func priorRuns() -> [ResultRecord] {
        return reader.readAll()
    }

    func persist(_ records: [ResultRecord]) {
        writer.append(records)
    }
}
