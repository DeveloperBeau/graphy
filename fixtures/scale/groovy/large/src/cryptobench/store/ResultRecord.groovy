package cryptobench.store

import cryptobench.core.SuiteResult

class ResultRecord {
    final String suite
    final int passed
    final int failed
    final double millis

    ResultRecord(SuiteResult result) {
        this.suite = result.suiteName
        this.passed = result.passed
        this.failed = result.failed
        this.millis = result.elapsedMillis()
    }
}
