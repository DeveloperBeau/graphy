import Foundation

enum TextMeasure {
    static func visibleLength(_ line: String) -> Int {
        var length = 0
        var inEscape = false
        for ch in line {
            if ch == "\u{1b}" {
                inEscape = true
            } else if inEscape && ch == "m" {
                inEscape = false
            } else if !inEscape {
                length += 1
            }
        }
        return length
    }
}
