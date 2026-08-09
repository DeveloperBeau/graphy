import Foundation

enum TrigFunctions {
    static func install(_ registry: FunctionRegistry) {
        registry.define("sin") { sin($0[0]) }
        registry.define("cos") { cos($0[0]) }
        registry.define("tan") { tan($0[0]) }
        registry.define("asin") { asin($0[0]) }
        registry.define("acos") { acos($0[0]) }
        registry.define("atan") { atan($0[0]) }
    }
}
