import Foundation

enum LogFunctions {
    static func install(_ registry: FunctionRegistry) {
        registry.define("ln") { log($0[0]) }
        registry.define("log10") { log10($0[0]) }
        registry.define("log2") { log2($0[0]) }
        registry.define("exp") { exp($0[0]) }
    }
}
