package calc.funcs;

import calc.config.Settings;
import calc.eval.FunctionRegistry;

public class InverseTrigFunctions {
    public static void register(FunctionRegistry registry, Settings settings) {
        registry.addUnary("asin", x -> settings.fromRadians(Math.asin(x)));
        registry.addUnary("acos", x -> settings.fromRadians(Math.acos(x)));
        registry.addUnary("atan", x -> settings.fromRadians(Math.atan(x)));
    }
}
