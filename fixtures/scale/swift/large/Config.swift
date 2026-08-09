// Run-level settings parsed from the command line by Cli/ArgParser.
struct Config {
    var iterations: Int = 2000
    var suiteFilter: String = "all"
    var persist: Bool = true

    static func defaults() -> Config {
        return Config()
    }
}
