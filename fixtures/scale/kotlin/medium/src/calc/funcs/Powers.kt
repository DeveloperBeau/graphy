package calc.funcs

import calc.eval.FunctionRegistry
import kotlin.math.cbrt
import kotlin.math.hypot
import kotlin.math.pow
import kotlin.math.sqrt

fun registerPowers(registry: FunctionRegistry) {
    registry.addUnary("sqrt") { sqrt(it) }
    registry.addUnary("cbrt") { cbrt(it) }
    registry.addUnary("square") { it * it }
    registry.addAggregate("hypot") { hypot(it[0], it[1]) }
    registry.addAggregate("pow") { it[0].pow(it[1]) }
}
