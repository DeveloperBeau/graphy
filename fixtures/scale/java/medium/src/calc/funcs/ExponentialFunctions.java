package calc.funcs;

import calc.eval.FunctionRegistry;

public class ExponentialFunctions {
    public static void register(FunctionRegistry registry) {
        registry.addUnary("exp", Math::exp);
        registry.addUnary("expm1", Math::expm1);
    }
}
