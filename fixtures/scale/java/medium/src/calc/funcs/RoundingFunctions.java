package calc.funcs;

import calc.eval.FunctionRegistry;

public class RoundingFunctions {
    public static void register(FunctionRegistry registry) {
        registry.addUnary("floor", Math::floor);
        registry.addUnary("ceil", Math::ceil);
        registry.addUnary("round", x -> (double) Math.round(x));
        registry.addUnary("trunc", x -> (double) (long) x);
        registry.addUnary("abs", Math::abs);
        registry.addUnary("sign", Math::signum);
    }
}
