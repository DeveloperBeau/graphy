package cryptobench.live

import cryptobench.core.SuiteResult

final class ProgressReporter {
  private val sink = new ConsoleSink(System.out)
  private var total = 0
  private var done = 0

  def begin(suiteCount: Int): Unit = {
    total = suiteCount
    sink.line("running " + suiteCount + " suites")
  }

  def startSuite(name: String): Unit =
    sink.transientLine("[" + (done + 1) + "/" + total + "] " + name + "...")

  def finishSuite(result: SuiteResult): Unit = {
    done += 1
    val status = if (result.allPassed) "ok" else "FAIL"
    sink.line("\r[" + done + "/" + total + "] " + result.suiteName + " " + status)
  }

  def end(summaryText: String): Unit = sink.line(summaryText)
}
