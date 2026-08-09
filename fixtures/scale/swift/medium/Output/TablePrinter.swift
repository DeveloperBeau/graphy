final class TablePrinter {
    let headers: [String]
    private var rows: [[String]] = []

    init(headers: [String]) {
        self.headers = headers
    }

    func add(_ cells: [String]) {
        rows.append(cells)
    }

    func render() -> String {
        var lines = [headers.joined(separator: " | ")]
        for row in rows {
            lines.append(row.joined(separator: " | "))
        }
        return lines.joined(separator: "\n")
    }
}
