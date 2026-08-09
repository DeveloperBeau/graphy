package cryptobench.live;

import cryptobench.core.SuiteResult;

public class ProgressReporter {
    private final ConsoleSink sink = new ConsoleSink(System.out);
    private int total;
    private int done;

    public void begin(int suiteCount) {
        this.total = suiteCount;
        sink.line("running " + suiteCount + " suites");
    }

    public void startSuite(String name) {
        sink.transient_("[" + (done + 1) + "/" + total + "] " + name + "...");
    }

    public void finishSuite(SuiteResult result) {
        done++;
        String status = result.allPassed() ? "ok" : "FAIL";
        sink.line("\r[" + done + "/" + total + "] " + result.getSuiteName() + " " + status);
    }

    public void end(String summaryText) {
        sink.line(summaryText);
    }
}
