import Foundation

struct Options {
    var width: Int = 60
    var align: String = "left"
    var borderStyle: String = "single"
    var themeName: String = "plain"
    var showHelp: Bool = false

    static func defaults() -> Options {
        return Options()
    }
}
