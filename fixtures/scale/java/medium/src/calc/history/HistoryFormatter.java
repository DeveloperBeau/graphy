package calc.history;

import java.util.StringJoiner;

public class HistoryFormatter {
    private static final int DEFAULT_COUNT = 10;

    public static String format(History history) {
        StringJoiner joiner = new StringJoiner("\n");
        for (HistoryEntry entry : history.recent(DEFAULT_COUNT)) {
            joiner.add(entry.getInput() + " = " + entry.getResult());
        }
        return joiner.length() == 0 ? "(empty)" : joiner.toString();
    }
}
