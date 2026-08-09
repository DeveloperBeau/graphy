package calc.funcs

import calc.errors.EvalException
import calc.eval.FunctionRegistry
import kotlin.math.floor

fun registerCombinatorics(registry: FunctionRegistry) {
    registry.addUnary("fact") { factorial(it) }
    registry.addAggregate("ncr") { choose(it[0], it[1]) }
    registry.addAggregate("npr") { factorial(it[0]) / factorial(it[0] - it[1]) }
}

internal fun factorial(n: Double): Double {
    if (n < 0 || n != floor(n)) throw EvalException("factorial needs a non-negative integer")
    var result = 1.0
    for (i in 2..n.toInt()) result *= i
    return result
}

internal fun choose(n: Double, k: Double): Double =
    factorial(n) / (factorial(k) * factorial(n - k))
