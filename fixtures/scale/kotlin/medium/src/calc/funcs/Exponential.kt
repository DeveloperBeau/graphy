package calc.funcs

import calc.eval.FunctionRegistry
import kotlin.math.exp
import kotlin.math.expm1

fun registerExponential(registry: FunctionRegistry) {
    registry.addUnary("exp") { exp(it) }
    registry.addUnary("expm1") { expm1(it) }
}
