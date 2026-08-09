import Foundation

enum Usage {
    static func text() -> String {
        return [
            "textprint [options] < input.txt",
            "  --width N       wrap width (default 60)",
            "  --align MODE    left | center | right",
            "  --border STYLE  single | double | ascii | none",
            "  --theme NAME    plain | bright | mono",
            "  --help          show this help",
        ].joined(separator: "\n")
    }

    static func print_() {
        print(text())
    }
}
