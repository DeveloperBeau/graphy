enum ArgParser {
    static func parse(_ args: [String]) -> Config {
        var config = Config.defaults()
        var i = 0
        while i < args.count {
            if args[i] == "--iterations", i + 1 < args.count {
                i += 1
                config.iterations = Int(args[i]) ?? config.iterations
            } else if args[i] == "--suite", i + 1 < args.count {
                i += 1
                config.suiteFilter = args[i]
            } else if args[i] == "--no-persist" {
                config.persist = false
            }
            i += 1
        }
        return config
    }
}
