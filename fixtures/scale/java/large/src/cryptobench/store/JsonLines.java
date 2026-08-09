package cryptobench.store;

public class JsonLines {
    public static String toJson(ResultRecord record) {
        StringBuilder sb = new StringBuilder("{");
        field(sb, "suite", '"' + record.getSuite() + '"');
        field(sb, "passed", String.valueOf(record.getPassed()));
        field(sb, "failed", String.valueOf(record.getFailed()));
        field(sb, "millis", String.format("%.3f", record.getMillis()));
        sb.setLength(sb.length() - 1);
        return sb.append('}').toString();
    }

    private static void field(StringBuilder sb, String key, String value) {
        sb.append('"').append(key).append('"').append(':').append(value).append(',');
    }
}
