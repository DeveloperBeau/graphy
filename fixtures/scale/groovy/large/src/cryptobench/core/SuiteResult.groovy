package cryptobench.core

class SuiteResult {
    final String suiteName
    final int passed
    final int failed
    final long elapsedNanos

    SuiteResult(String suiteName, int passed, int failed, long elapsedNanos) {
        this.suiteName = suiteName
        this.passed = passed
        this.failed = failed
        this.elapsedNanos = elapsedNanos
    }

    boolean allPassed() {
        return failed == 0
    }

    double elapsedMillis() {
        return elapsedNanos / 1000000.0
    }
}
