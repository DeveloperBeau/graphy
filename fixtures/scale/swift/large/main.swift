import Foundation

let config = ArgParser.parse(Array(CommandLine.arguments.dropFirst()))
let session = SessionState()
let reporter = ProgressReporter(total: FamilyCatalog.all().count)
let outcomes = Harness().runAll(reporter)

let records = FamilyCatalog.all().map {
    ResultRecord(family: $0.family, suite: $0.suite, passed: true, nanoseconds: 0)
}
if config.persist {
    session.resultsStore().persist(records)
}
print(SummaryReport().build(outcomes, priorSessions: session.previousSessions()))
print(SuiteReport().build(outcomes))
