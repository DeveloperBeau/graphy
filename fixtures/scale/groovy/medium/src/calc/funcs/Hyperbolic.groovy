package calc.funcs

import calc.eval.FunctionRegistry

class Hyperbolic {
    static void register(FunctionRegistry registry) {
        registry.addUnary("sinh") { x -> Math.sinh(x) }
        registry.addUnary("cosh") { x -> Math.cosh(x) }
        registry.addUnary("tanh") { x -> Math.tanh(x) }
    }
}
