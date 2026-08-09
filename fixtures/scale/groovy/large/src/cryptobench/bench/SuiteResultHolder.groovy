package cryptobench.bench

import cryptobench.core.SuiteResult

/** Thin wrapper kept around a fresh suite result while it moves through the pipeline. */
class SuiteResultHolder {
    final SuiteResult result

    SuiteResultHolder(SuiteResult result) {
        this.result = result
    }

    boolean isClean() {
        return result.allPassed()
    }
}
