struct SessionState {
    private let store = ResultsStore()

    func previousSessions() -> Int {
        let runs = store.priorRuns()
        let families = Set(runs.map { $0.family })
        return families.isEmpty ? 0 : runs.count / families.count
    }

    func resultsStore() -> ResultsStore {
        return store
    }
}
