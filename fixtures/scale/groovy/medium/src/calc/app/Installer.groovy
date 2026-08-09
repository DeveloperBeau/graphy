package calc.app

import calc.config.Settings
import calc.eval.FunctionRegistry
import calc.funcs.Combinatorics
import calc.funcs.Conversion
import calc.funcs.Exponential
import calc.funcs.Hyperbolic
import calc.funcs.InverseTrig
import calc.funcs.Logarithms
import calc.funcs.Powers
import calc.funcs.Rounding
import calc.funcs.Stats
import calc.funcs.Trig

class Installer {
    static void installBuiltins(FunctionRegistry registry, Settings settings) {
        Trig.register(registry, settings)
        InverseTrig.register(registry, settings)
        Hyperbolic.register(registry)
        Exponential.register(registry)
        Logarithms.register(registry)
        Powers.register(registry)
        Rounding.register(registry)
        Stats.register(registry)
        Combinatorics.register(registry)
        Conversion.register(registry)
    }
}
