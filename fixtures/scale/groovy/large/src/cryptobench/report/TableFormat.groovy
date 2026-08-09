package cryptobench.report

class TableFormat {
    static String formatRow(String name, int passed, int failed, double millis) {
        return String.format("%-18s %5d %5d %9.2fms", name, passed, failed, millis)
    }

    static String header() {
        return String.format("%-18s %5s %5s %11s", "suite", "pass", "fail", "elapsed")
    }

    /** Separator sized to match the header columns. */
    static String rule() {
        return "-" * 42
    }
}
