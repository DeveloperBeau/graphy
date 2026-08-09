import Foundation

enum StatsFunctions {
    static func install(_ registry: FunctionRegistry) {
        registry.define("min") { $0.min() ?? 0 }
        registry.define("max") { $0.max() ?? 0 }
        registry.define("sum") { $0.reduce(0, +) }
        registry.define("mean") { $0.reduce(0, +) / Double($0.count) }
        registry.define("range") { ($0.max() ?? 0) - ($0.min() ?? 0) }
    }
}
