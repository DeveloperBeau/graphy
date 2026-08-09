struct Harness {
    private let correctness = CorrectnessEngine()

    func runAll(_ reporter: ProgressReporter) -> [VectorOutcome] {
        var outcomes: [VectorOutcome] = []
        for descriptor in FamilyCatalog.all() {
            let outcome = correctness.verify(descriptor.cipher(), descriptor.vectors())
            reporter.step(descriptor.family, outcome.passed)
            outcomes.append(outcome)
        }
        return outcomes
    }
}
