package cryptobench.store;

import cryptobench.core.SuiteResult;

public class ResultRecord {
    private final String suite;
    private final int passed;
    private final int failed;
    private final double millis;

    public ResultRecord(SuiteResult result) {
        this.suite = result.getSuiteName();
        this.passed = result.getPassed();
        this.failed = result.getFailed();
        this.millis = result.getElapsedNanos() / 1_000_000.0;
    }

    public String getSuite() { return suite; }

    public int getPassed() { return passed; }

    public int getFailed() { return failed; }

    public double getMillis() { return millis; }
}
