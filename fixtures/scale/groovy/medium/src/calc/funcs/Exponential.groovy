package calc.funcs

import calc.eval.FunctionRegistry

class Exponential {
    static void register(FunctionRegistry registry) {
        registry.addUnary("exp") { x -> Math.exp(x) }
        registry.addUnary("expm1") { x -> Math.expm1(x) }
    }
}
