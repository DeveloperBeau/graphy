package calc.app

import calc.config.Settings
import calc.eval.FunctionRegistry
import calc.funcs.registerCombinatorics
import calc.funcs.registerConversion
import calc.funcs.registerExponential
import calc.funcs.registerHyperbolic
import calc.funcs.registerInverseTrig
import calc.funcs.registerLogarithms
import calc.funcs.registerPowers
import calc.funcs.registerRounding
import calc.funcs.registerStats
import calc.funcs.registerTrig

fun installBuiltins(registry: FunctionRegistry, settings: Settings) {
    registerTrig(registry, settings)
    registerInverseTrig(registry, settings)
    registerHyperbolic(registry)
    registerExponential(registry)
    registerLogarithms(registry)
    registerPowers(registry)
    registerRounding(registry)
    registerStats(registry)
    registerCombinatorics(registry)
    registerConversion(registry)
}
