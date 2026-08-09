package cryptobench.bench

import cryptobench.config.Settings
import cryptobench.core.CipherSuite
import cryptobench.live.ProgressReporter
import cryptobench.report.Summary
import cryptobench.store.ResultStore

class BenchmarkRunner(private val settings: Settings) {
    private val reporter = ProgressReporter()

    fun runAll(suites: List<CipherSuite>): Int {
        val store = ResultStore.openAt(settings.outputDir)
        val summary = Summary()
        reporter.begin(suites.size)
        for (suite in suites) {
            reporter.startSuite(suite.name())
            val result = suite.run()
            store.append(result)
            summary.add(result)
            reporter.finishSuite(result)
        }
        store.close()
        reporter.end(summary.render())
        return summary.totalFailed()
    }
}
