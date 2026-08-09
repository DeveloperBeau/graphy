package cryptobench.core

data class SuiteResult(
    val suiteName: String,
    val passed: Int,
    val failed: Int,
    val elapsedNanos: Long,
) {
    fun allPassed(): Boolean = failed == 0

    fun elapsedMillis(): Double = elapsedNanos / 1_000_000.0
}
