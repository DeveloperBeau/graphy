package cryptobench.store

import cryptobench.core.SuiteResult

data class ResultRecord(
    val suite: String,
    val passed: Int,
    val failed: Int,
    val millis: Double,
) {
    companion object {
        fun of(result: SuiteResult): ResultRecord =
            ResultRecord(result.suiteName, result.passed, result.failed, result.elapsedMillis())
    }
}
