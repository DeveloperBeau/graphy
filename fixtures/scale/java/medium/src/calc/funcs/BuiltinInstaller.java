package calc.funcs;

import calc.config.Settings;
import calc.eval.FunctionRegistry;

public class BuiltinInstaller {
    public static void install(FunctionRegistry registry, Settings settings) {
        TrigFunctions.register(registry, settings);
        InverseTrigFunctions.register(registry, settings);
        HyperbolicFunctions.register(registry);
        ExponentialFunctions.register(registry);
        LogarithmFunctions.register(registry);
        PowerFunctions.register(registry);
        RoundingFunctions.register(registry);
        StatFunctions.register(registry);
        CombinatoricsFunctions.register(registry);
        ConversionFunctions.register(registry);
    }
}
