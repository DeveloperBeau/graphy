package cryptobench.core;

public class SuiteResult {
    private final String suiteName;
    private final int passed;
    private final int failed;
    private final long elapsedNanos;

    public SuiteResult(String suiteName, int passed, int failed, long elapsedNanos) {
        this.suiteName = suiteName;
        this.passed = passed;
        this.failed = failed;
        this.elapsedNanos = elapsedNanos;
    }

    public String getSuiteName() { return suiteName; }

    public int getPassed() { return passed; }

    public int getFailed() { return failed; }

    public long getElapsedNanos() { return elapsedNanos; }

    public boolean allPassed() { return failed == 0; }
}
