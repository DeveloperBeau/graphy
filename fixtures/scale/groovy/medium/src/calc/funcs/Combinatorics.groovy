package calc.funcs

import calc.errors.EvalException
import calc.eval.FunctionRegistry

class Combinatorics {
    static void register(FunctionRegistry registry) {
        registry.addUnary("fact") { n -> factorial(n) }
        registry.addAggregate("ncr") { args -> choose(args[0], args[1]) }
        registry.addAggregate("npr") { args -> factorial(args[0]) / factorial(args[0] - args[1]) }
    }

    static double factorial(double n) {
        if (n < 0 || n != Math.floor(n)) throw new EvalException("factorial needs a non-negative integer")
        double result = 1
        for (int i = 2; i <= (int) n; i++) result *= i
        return result
    }

    static double choose(double n, double k) {
        return factorial(n) / (factorial(k) * factorial(n - k))
    }
}
