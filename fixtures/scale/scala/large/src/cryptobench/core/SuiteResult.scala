package cryptobench.core

final case class SuiteResult(suiteName: String, passed: Int, failed: Int, elapsedNanos: Long) {

  def allPassed: Boolean = failed == 0

  def elapsedMillis: Double = elapsedNanos / 1000000.0

  def label: String = suiteName + " (" + passed + "/" + (passed + failed) + ")"
}
