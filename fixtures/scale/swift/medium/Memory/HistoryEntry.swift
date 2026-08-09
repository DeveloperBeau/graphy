import Foundation

struct HistoryEntry {
    let expression: String
    let value: Double
    let stamp: Date

    func format() -> String {
        return expression + " => " + String(value)
    }
}
