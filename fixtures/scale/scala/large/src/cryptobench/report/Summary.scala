package cryptobench.report

import scala.collection.mutable.ListBuffer

import cryptobench.core.SuiteResult

final class Summary {
  private val results = ListBuffer.empty[SuiteResult]

  def add(result: SuiteResult): Unit = { results += result; () }

  def totalFailed: Int = results.map(_.failed).sum

  def render(): String = {
    val sb = new StringBuilder
    sb.append(TableFormat.tableHeader()).append('\n').append(TableFormat.tableRule()).append('\n')
    for (r <- results) {
      sb.append(TableFormat.formatRow(r.suiteName, r.passed, r.failed, r.elapsedMillis)).append('\n')
    }
    sb.append(results.size).append(" suites, ").append(totalFailed).append(" failures")
    sb.toString
  }
}
