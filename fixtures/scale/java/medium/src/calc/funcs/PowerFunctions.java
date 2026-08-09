package calc.funcs;

import calc.eval.FunctionRegistry;

public class PowerFunctions {
    public static void register(FunctionRegistry registry) {
        registry.addUnary("sqrt", Math::sqrt);
        registry.addUnary("cbrt", Math::cbrt);
        registry.addUnary("square", x -> x * x);
        registry.addAggregate("hypot", args -> Math.hypot(args[0], args[1]));
        registry.addAggregate("pow", args -> Math.pow(args[0], args[1]));
    }
}
