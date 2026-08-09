package cryptobench.store

class JsonLines {
    static String toJson(ResultRecord record) {
        StringBuilder sb = new StringBuilder("{")
        field(sb, "suite", '"' + record.suite + '"')
        field(sb, "passed", record.passed as String)
        field(sb, "failed", record.failed as String)
        field(sb, "millis", String.format("%.3f", record.millis))
        sb.setLength(sb.length() - 1)
        return sb.append('}').toString()
    }

    private static void field(StringBuilder sb, String key, String value) {
        sb.append('"').append(key).append('"').append(':').append(value).append(',')
    }
}
