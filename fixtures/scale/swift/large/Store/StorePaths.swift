import Foundation

enum StorePaths {
    static func storeDir() -> String {
        return FileManager.default.currentDirectoryPath + "/.cipherlab"
    }

    static func resultsFile() -> String {
        return storeDir() + "/results.jsonl"
    }

    static func ensureDir() {
        try? FileManager.default.createDirectory(atPath: storeDir(), withIntermediateDirectories: true)
    }
}
