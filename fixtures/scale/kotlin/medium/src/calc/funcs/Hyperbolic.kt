package calc.funcs

import calc.eval.FunctionRegistry
import kotlin.math.cosh
import kotlin.math.sinh
import kotlin.math.tanh

fun registerHyperbolic(registry: FunctionRegistry) {
    registry.addUnary("sinh") { sinh(it) }
    registry.addUnary("cosh") { cosh(it) }
    registry.addUnary("tanh") { tanh(it) }
}
