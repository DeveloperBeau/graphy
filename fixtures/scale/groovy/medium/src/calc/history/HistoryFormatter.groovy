package calc.history

class HistoryFormatter {
    private static final int DEFAULT_COUNT = 10

    static String format(History history) {
        return formatRecent(history, DEFAULT_COUNT)
    }

    static String formatRecent(History history, int count) {
        List<String> lines = history.recent(count).collect { it.summary() }
        return lines.isEmpty() ? "(empty)" : lines.join("\n")
    }
}
