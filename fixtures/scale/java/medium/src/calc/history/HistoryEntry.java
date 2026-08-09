package calc.history;

import java.time.Instant;

public class HistoryEntry {
    private final String input;
    private final double result;
    private final Instant at;

    public HistoryEntry(String input, double result) {
        this.input = input;
        this.result = result;
        this.at = Instant.now();
    }

    public String getInput() {
        return input;
    }

    public double getResult() {
        return result;
    }

    public Instant getAt() {
        return at;
    }
}
