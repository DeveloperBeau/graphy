package cryptobench.live

import cryptobench.core.SuiteResult

class ProgressReporter {
    private val sink = ConsoleSink(System.out)
    private var total = 0
    private var done = 0

    fun begin(suiteCount: Int) {
        total = suiteCount
        sink.line("running " + suiteCount + " suites")
    }

    fun startSuite(name: String) {
        sink.transientLine("[" + (done + 1) + "/" + total + "] " + name + "...")
    }

    fun finishSuite(result: SuiteResult) {
        done++
        val status = if (result.allPassed()) "ok" else "FAIL"
        sink.line("\r[" + done + "/" + total + "] " + result.suiteName + " " + status)
    }

    fun end(summaryText: String) {
        sink.line(summaryText)
    }
}
