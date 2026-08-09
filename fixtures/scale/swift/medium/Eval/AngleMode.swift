import Foundation

enum AngleMode {
    case radians
    case degrees
}

enum AngleConvert {
    static func toRadians(_ value: Double, mode: AngleMode) -> Double {
        return mode == .degrees ? value * .pi / 180.0 : value
    }
}
