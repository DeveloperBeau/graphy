// Displayed once at startup, above the first prompt.
//
// Bump this whenever a Functions/ file adds or removes a builtin.
enum Version {
    static let number = "1.4.2"

    static func banner() -> String {
        return "calc " + number + " - type :help for commands"
    }
}
