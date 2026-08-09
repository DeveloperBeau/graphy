package calc.funcs

import calc.errors.EvalException
import calc.eval.FunctionRegistry
import kotlin.math.ln
import kotlin.math.log10
import kotlin.math.log2

fun registerLogarithms(registry: FunctionRegistry) {
    registry.addUnary("ln") { safeLn(it) }
    registry.addUnary("log10") { log10(it) }
    registry.addUnary("log2") { log2(it) }
}

internal fun safeLn(x: Double): Double {
    if (x <= 0) throw EvalException("ln of non-positive value")
    return ln(x)
}
