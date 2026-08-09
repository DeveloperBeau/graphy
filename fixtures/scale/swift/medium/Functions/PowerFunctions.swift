import Foundation

enum PowerFunctions {
    static func install(_ registry: FunctionRegistry) {
        registry.define("sqrt") { sqrt($0[0]) }
        registry.define("cbrt") { cbrt($0[0]) }
        registry.define("pow") { pow($0[0], $0[1]) }
        registry.define("hypot") { hypot($0[0], $0[1]) }
    }
}
