import Foundation

enum NumberFormat {
    static func format(_ value: Double, _ precision: Int) -> String {
        if value.isNaN || value.isInfinite {
            return String(value)
        }
        return String(format: "%.\(precision)f", value)
    }
}
