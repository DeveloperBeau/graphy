final class HistoryLog {
    private var entries: [HistoryEntry] = []

    @discardableResult
    func append(_ expression: String, _ value: Double) -> HistoryEntry {
        let entry = HistoryEntry(expression: expression, value: value, stamp: Date())
        entries.append(entry)
        return entry
    }

    func recent(_ count: Int) -> [HistoryEntry] {
        let start = entries.count > count ? entries.count - count : 0
        return Array(entries[start...])
    }

    func count() -> Int {
        return entries.count
    }
}
