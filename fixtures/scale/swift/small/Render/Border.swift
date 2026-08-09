import Foundation

struct Border {
    let horizontal: Character
    let vertical: Character
    let corner: Character = "+"

    init(style: String) {
        horizontal = style == "double" ? "=" : "-"
        vertical = style == "ascii" ? "|" : "\u{2502}"
    }

    func frame(_ lines: [String], width: Int) -> [String] {
        let rule = String(corner) + String(repeating: horizontal, count: width + 2) + String(corner)
        var framed = [rule]
        for line in lines {
            framed.append(String(vertical) + " " + line + " " + String(vertical))
        }
        framed.append(rule)
        return framed
    }
}
