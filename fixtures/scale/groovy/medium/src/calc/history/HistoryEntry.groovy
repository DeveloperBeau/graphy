package calc.history

import java.time.Instant

class HistoryEntry {
    final String input
    final double result
    final Instant at

    HistoryEntry(String input, double result) {
        this.input = input
        this.result = result
        this.at = Instant.now()
    }

    String summary() {
        return input + " = " + result
    }
}
