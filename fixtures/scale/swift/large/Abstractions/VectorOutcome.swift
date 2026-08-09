// Result of running one family's test vectors through CorrectnessEngine.
//
// detail carries a short human-readable reason when passed is false.
// Collected per-family by Harness.runAll() into a report-ready list
// that both SummaryReport and SuiteReport read from.
struct VectorOutcome {
    let family: String
    let passed: Bool
    let detail: String
}
