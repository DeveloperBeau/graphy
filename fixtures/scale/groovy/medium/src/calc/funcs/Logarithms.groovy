package calc.funcs

import calc.errors.EvalException
import calc.eval.FunctionRegistry

class Logarithms {
    static void register(FunctionRegistry registry) {
        registry.addUnary("ln") { x -> safeLn(x) }
        registry.addUnary("log10") { x -> Math.log10(x) }
        registry.addUnary("log2") { x -> safeLn(x) / Math.log(2) }
    }

    static double safeLn(double x) {
        if (x <= 0) throw new EvalException("ln of non-positive value")
        return Math.log(x)
    }
}
