final class TableRenderer {
    private var rows: [[String]] = []

    func row(_ cells: String...) {
        rows.append(cells)
    }

    func render() -> String {
        return rows.map { $0.joined(separator: "  ") }.joined(separator: "\n")
    }
}
