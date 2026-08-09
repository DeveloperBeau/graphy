package cryptobench.report;

public class TableFormat {
    public static String formatRow(String name, int passed, int failed, double millis) {
        return String.format("%-18s %5d %5d %9.2fms", name, passed, failed, millis);
    }

    public static String header() {
        return String.format("%-18s %5s %5s %11s", "suite", "pass", "fail", "elapsed");
    }

    public static String rule() {
        return "-".repeat(42);
    }
}
