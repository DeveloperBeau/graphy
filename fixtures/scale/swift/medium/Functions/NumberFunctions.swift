import Foundation

// Small scalar helpers that don't belong to any other function group.
enum NumberFunctions {
    static func install(_ registry: FunctionRegistry) {
        registry.define("abs") { abs($0[0]) }
        registry.define("sign") { Double($0[0].sign == .minus ? -1 : 1) }
        registry.define("clamp") { min(max($0[0], $0[1]), $0[2]) }
    }
}
