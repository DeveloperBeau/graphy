import Foundation

// Hyperbolic trig, registered alongside the ordinary trig functions.
enum HyperbolicFunctions {
    static func install(_ registry: FunctionRegistry) {
        registry.define("sinh") { sinh($0[0]) }
        registry.define("cosh") { cosh($0[0]) }
        registry.define("tanh") { tanh($0[0]) }
    }
}
