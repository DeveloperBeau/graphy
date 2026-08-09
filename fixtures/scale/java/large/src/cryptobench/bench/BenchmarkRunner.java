package cryptobench.bench;

import java.util.List;

import cryptobench.config.Settings;
import cryptobench.core.CipherSuite;
import cryptobench.core.SuiteResult;
import cryptobench.live.ProgressReporter;
import cryptobench.report.Summary;
import cryptobench.store.ResultStore;

public class BenchmarkRunner {
    private final Settings settings;
    private final ProgressReporter reporter = new ProgressReporter();

    public BenchmarkRunner(Settings settings) {
        this.settings = settings;
    }

    public int runAll(List<CipherSuite> suites) {
        ResultStore store = ResultStore.openAt(settings.getOutputDir());
        Summary summary = new Summary();
        reporter.begin(suites.size());
        for (CipherSuite suite : suites) {
            reporter.startSuite(suite.name());
            SuiteResult result = suite.run();
            store.append(result);
            summary.add(result);
            reporter.finishSuite(result);
        }
        store.close();
        reporter.end(summary.render());
        return summary.totalFailed();
    }
}
