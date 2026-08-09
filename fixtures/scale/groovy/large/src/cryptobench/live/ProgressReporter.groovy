package cryptobench.live

import cryptobench.core.SuiteResult

class ProgressReporter {
    private final ConsoleSink sink = new ConsoleSink(System.out)
    private int total
    private int done

    void begin(int suiteCount) {
        total = suiteCount
        sink.line("running " + suiteCount + " suites")
    }

    void startSuite(String name) {
        sink.transientLine("[" + (done + 1) + "/" + total + "] " + name + "...")
    }

    void finishSuite(SuiteResult result) {
        done++
        String status = result.allPassed() ? "ok" : "FAIL"
        sink.line("\r[" + done + "/" + total + "] " + result.suiteName + " " + status)
    }

    void end(String summaryText) {
        sink.line(summaryText)
    }
}
