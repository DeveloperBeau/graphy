import Foundation

final class ProgressReporter {
    private let total: Int
    private var done = 0

    init(total: Int) {
        self.total = total
    }

    func step(_ family: String, _ passed: Bool) {
        done += 1
        let flag = passed ? "ok " : "BAD"
        FileHandle.standardError.write("\r[\(done)/\(total)] \(flag) \(family)        ".data(using: .utf8)!)
        if done == total {
            FileHandle.standardError.write("\n".data(using: .utf8)!)
        }
    }
}
