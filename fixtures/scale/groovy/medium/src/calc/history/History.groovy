package calc.history

class History {
    private final List<HistoryEntry> entries = []
    private final int capacity

    History(int capacity) {
        this.capacity = capacity
    }

    void record(String input, double result) {
        if (entries.size() == capacity) entries.remove(0)
        entries << new HistoryEntry(input, result)
    }

    List<HistoryEntry> recent(int count) {
        int from = Math.max(0, entries.size() - count)
        return entries.subList(from, entries.size())
    }

    int size() {
        return entries.size()
    }
}
