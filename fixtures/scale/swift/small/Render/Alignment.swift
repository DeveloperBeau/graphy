import Foundation

enum Alignment {
    static func alignLine(_ line: String, width: Int, mode: String) -> String {
        let visible = TextMeasure.visibleLength(line)
        let slack = width - visible
        guard slack > 0 else { return line }
        if mode == "right" {
            return String(repeating: " ", count: slack) + line
        }
        if mode == "center" {
            let left = slack / 2
            return String(repeating: " ", count: left) + line + String(repeating: " ", count: slack - left)
        }
        return line + String(repeating: " ", count: slack)
    }
}
