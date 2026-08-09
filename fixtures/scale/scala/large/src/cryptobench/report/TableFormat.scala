package cryptobench.report

object TableFormat {
  def formatRow(name: String, passed: Int, failed: Int, millis: Double): String =
    String.format("%-18s %5d %5d %9.2fms", name, Int.box(passed), Int.box(failed), Double.box(millis))

  def tableHeader(): String =
    String.format("%-18s %5s %5s %11s", "suite", "pass", "fail", "elapsed")

  /** Separator sized to match the header columns. */
  def tableRule(): String = "-" * 42
}
