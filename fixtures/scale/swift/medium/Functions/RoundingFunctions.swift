import Foundation

enum RoundingFunctions {
    static func install(_ registry: FunctionRegistry) {
        registry.define("round") { $0[0].rounded() }
        registry.define("floor") { $0[0].rounded(.down) }
        registry.define("ceil") { $0[0].rounded(.up) }
        registry.define("trunc") { $0[0].rounded(.towardZero) }
    }
}
