import Foundation

struct JsonlReader {
    let path: String

    func readAll() -> [ResultRecord] {
        guard let text = try? String(contentsOfFile: path, encoding: .utf8) else {
            return []
        }
        return text.split(separator: "\n").map { ResultRecord.fromLine(String($0)) }
    }
}
