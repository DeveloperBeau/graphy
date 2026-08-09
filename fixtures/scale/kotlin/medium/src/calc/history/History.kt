package calc.history

import java.util.ArrayDeque

class History(private val capacity: Int) {
    private val entries = ArrayDeque<HistoryEntry>()

    fun record(input: String, result: Double) {
        if (entries.size == capacity) entries.removeFirst()
        entries.addLast(HistoryEntry(input, result))
    }

    fun recent(count: Int): List<HistoryEntry> =
        entries.toList().takeLast(count)

    fun size(): Int = entries.size
}
