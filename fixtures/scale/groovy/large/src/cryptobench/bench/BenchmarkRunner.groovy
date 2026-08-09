package cryptobench.bench

import cryptobench.config.Settings
import cryptobench.core.CipherSuite
import cryptobench.live.ProgressReporter
import cryptobench.report.Summary
import cryptobench.store.ResultStore

class BenchmarkRunner {
    private final Settings settings
    private final ProgressReporter reporter = new ProgressReporter()

    BenchmarkRunner(Settings settings) {
        this.settings = settings
    }

    int runAll(List<CipherSuite> suites) {
        ResultStore store = ResultStore.openAt(settings.outputDir)
        Summary summary = new Summary()
        reporter.begin(suites.size())
        suites.each { suite ->
            reporter.startSuite(suite.name())
            SuiteResultHolder holder = new SuiteResultHolder(suite.run())
            store.append(holder.result)
            summary.add(holder.result)
            reporter.finishSuite(holder.result)
        }
        store.close()
        reporter.end(summary.render())
        return summary.totalFailed()
    }
}
