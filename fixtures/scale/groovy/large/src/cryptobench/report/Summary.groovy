package cryptobench.report

import cryptobench.core.SuiteResult

class Summary {
    private final List<SuiteResult> results = []

    void add(SuiteResult result) {
        results << result
    }

    int totalFailed() {
        return results.collect { it.failed }.sum() as Integer ?: 0
    }

    String render() {
        StringBuilder sb = new StringBuilder()
        sb.append(TableFormat.header()).append('\n').append(TableFormat.rule()).append('\n')
        results.each { r ->
            sb.append(TableFormat.formatRow(r.suiteName, r.passed, r.failed, r.elapsedMillis())).append('\n')
        }
        sb.append(results.size()).append(" suites, ").append(totalFailed()).append(" failures")
        return sb.toString()
    }
}
