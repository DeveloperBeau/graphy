struct ResultRecord {
    let family: String
    let suite: String
    let passed: Bool
    let nanoseconds: Int

    func toLine() -> String {
        let flag = passed ? "1" : "0"
        return [family, suite, flag, String(nanoseconds)].joined(separator: "\t")
    }

    static func fromLine(_ line: String) -> ResultRecord {
        let parts = line.components(separatedBy: "\t")
        return ResultRecord(family: parts[0], suite: parts[1], passed: parts[2] == "1",
                             nanoseconds: Int(parts[3]) ?? 0)
    }
}
