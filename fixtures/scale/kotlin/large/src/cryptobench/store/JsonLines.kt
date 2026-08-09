package cryptobench.store

fun toJsonLine(record: ResultRecord): String {
    val sb = StringBuilder("{")
    field(sb, "suite", "\"" + record.suite + "\"")
    field(sb, "passed", record.passed.toString())
    field(sb, "failed", record.failed.toString())
    field(sb, "millis", String.format("%.3f", record.millis))
    sb.setLength(sb.length - 1)
    return sb.append('}').toString()
}

private fun field(sb: StringBuilder, key: String, value: String) {
    sb.append('"').append(key).append('"').append(':').append(value).append(',')
}
