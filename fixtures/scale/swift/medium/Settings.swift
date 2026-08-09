// Session-wide REPL settings, mutated by the :precision and :angle
// commands and read by the formatter and trig functions.
struct Settings {
    var precision: Int = 6
    var angle: AngleMode = .radians
    var running: Bool = true

    static func interactive() -> Settings {
        return Settings()
    }
}
