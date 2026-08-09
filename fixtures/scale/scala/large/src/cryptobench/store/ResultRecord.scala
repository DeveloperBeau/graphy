package cryptobench.store

import cryptobench.core.SuiteResult

final case class ResultRecord(suite: String, passed: Int, failed: Int, millis: Double)

object ResultRecord {
  def of(result: SuiteResult): ResultRecord =
    ResultRecord(result.suiteName, result.passed, result.failed, result.elapsedMillis)
}
