package calc.funcs

import calc.eval.FunctionRegistry
import kotlin.math.abs
import kotlin.math.ceil
import kotlin.math.floor
import kotlin.math.round
import kotlin.math.sign

fun registerRounding(registry: FunctionRegistry) {
    registry.addUnary("floor") { floor(it) }
    registry.addUnary("ceil") { ceil(it) }
    registry.addUnary("round") { round(it) }
    registry.addUnary("trunc") { it.toLong().toDouble() }
    registry.addUnary("abs") { abs(it) }
    registry.addUnary("sign") { sign(it) }
}
