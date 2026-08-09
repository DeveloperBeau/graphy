package calc.funcs;

import calc.errors.EvalException;
import calc.eval.FunctionRegistry;

public class LogarithmFunctions {
    public static void register(FunctionRegistry registry) {
        registry.addUnary("ln", LogarithmFunctions::safeLn);
        registry.addUnary("log10", Math::log10);
        registry.addUnary("log2", x -> safeLn(x) / Math.log(2));
    }

    static double safeLn(double x) {
        if (x <= 0) {
            throw new EvalException("ln of non-positive value");
        }
        return Math.log(x);
    }
}
