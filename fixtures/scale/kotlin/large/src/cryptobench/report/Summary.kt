package cryptobench.report

import cryptobench.core.SuiteResult

class Summary {
    private val results = mutableListOf<SuiteResult>()

    fun add(result: SuiteResult) {
        results.add(result)
    }

    fun totalFailed(): Int = results.sumOf { it.failed }

    fun render(): String {
        val sb = StringBuilder()
        sb.append(tableHeader()).append('\n').append(tableRule()).append('\n')
        for (r in results) {
            sb.append(formatRow(r.suiteName, r.passed, r.failed, r.elapsedMillis())).append('\n')
        }
        sb.append(results.size).append(" suites, ").append(totalFailed()).append(" failures")
        return sb.toString()
    }
}
