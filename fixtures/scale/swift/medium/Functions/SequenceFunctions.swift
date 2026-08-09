enum SequenceFunctions {
    static func install(_ registry: FunctionRegistry) {
        registry.define("fact") { factorial(Int($0[0])) }
        registry.define("fib") { fibonacci(Int($0[0])) }
    }

    private static func factorial(_ n: Int) -> Double {
        var result = 1.0
        for i in 2...max(n, 2) where i <= n { result *= Double(i) }
        return n < 2 ? 1 : result
    }

    private static func fibonacci(_ n: Int) -> Double {
        var a = 0.0, b = 1.0
        for _ in 0..<n { (a, b) = (b, a + b) }
        return a
    }
}
