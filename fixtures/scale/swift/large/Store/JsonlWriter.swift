import Foundation

struct JsonlWriter {
    let path: String

    func append(_ records: [ResultRecord]) {
        StorePaths.ensureDir()
        let lines = records.map { $0.toLine() }.joined(separator: "\n") + "\n"
        if let handle = FileHandle(forWritingAtPath: path) {
            handle.seekToEndOfFile()
            handle.write(lines.data(using: .utf8)!)
            handle.closeFile()
        } else {
            try? lines.write(toFile: path, atomically: true, encoding: .utf8)
        }
    }
}
