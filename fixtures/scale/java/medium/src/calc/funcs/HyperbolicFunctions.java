package calc.funcs;

import calc.eval.FunctionRegistry;

public class HyperbolicFunctions {
    public static void register(FunctionRegistry registry) {
        registry.addUnary("sinh", Math::sinh);
        registry.addUnary("cosh", Math::cosh);
        registry.addUnary("tanh", Math::tanh);
    }
}
