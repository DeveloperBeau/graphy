package calc.history;

import java.util.ArrayDeque;
import java.util.Deque;
import java.util.List;

public class History {
    private final Deque<HistoryEntry> entries = new ArrayDeque<>();
    private final int capacity;

    public History(int capacity) {
        this.capacity = capacity;
    }

    public void record(String input, double result) {
        if (entries.size() == capacity) {
            entries.removeFirst();
        }
        entries.addLast(new HistoryEntry(input, result));
    }

    public List<HistoryEntry> recent(int count) {
        return entries.stream().skip(Math.max(0, entries.size() - count)).toList();
    }

    public int size() {
        return entries.size();
    }
}
