package calc.funcs

import calc.eval.FunctionRegistry

class Rounding {
    static void register(FunctionRegistry registry) {
        registry.addUnary("floor") { x -> Math.floor(x) }
        registry.addUnary("ceil") { x -> Math.ceil(x) }
        registry.addUnary("round") { x -> Math.round(x) as double }
        registry.addUnary("trunc") { x -> (long) x as double }
        registry.addUnary("abs") { x -> Math.abs(x) }
        registry.addUnary("sign") { x -> Math.signum(x) }
    }
}
