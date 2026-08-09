package cryptobench.store

object JsonLines {
  def toJson(record: ResultRecord): String = {
    val sb = new StringBuilder("{")
    field(sb, "suite", "\"" + record.suite + "\"")
    field(sb, "passed", record.passed.toString)
    field(sb, "failed", record.failed.toString)
    field(sb, "millis", String.format("%.3f", Double.box(record.millis)))
    sb.setLength(sb.length - 1)
    sb.append('}').toString
  }

  private def field(sb: StringBuilder, key: String, value: String): Unit = {
    sb.append('"').append(key).append('"').append(':').append(value).append(',')
    ()
  }
}
