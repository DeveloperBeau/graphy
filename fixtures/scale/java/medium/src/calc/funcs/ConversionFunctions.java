package calc.funcs;

import calc.eval.FunctionRegistry;

public class ConversionFunctions {
    public static void register(FunctionRegistry registry) {
        registry.addUnary("radToDeg", Math::toDegrees);
        registry.addUnary("degToRad", Math::toRadians);
        registry.addUnary("percent", x -> x / 100.0);
        registry.addAggregate("percentOf", args -> args[0] / 100.0 * args[1]);
    }
}
