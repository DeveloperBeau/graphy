package calc.funcs

import calc.eval.FunctionRegistry
import kotlin.math.sqrt

fun registerStats(registry: FunctionRegistry) {
    registry.addAggregate("min") { it.min() }
    registry.addAggregate("max") { it.max() }
    registry.addAggregate("sum") { it.sum() }
    registry.addAggregate("mean") { mean(it) }
    registry.addAggregate("stddev") { stddev(it) }
}

internal fun mean(args: DoubleArray): Double = args.average()

internal fun stddev(args: DoubleArray): Double {
    val m = mean(args)
    val sum = args.sumOf { (it - m) * (it - m) }
    return sqrt(sum / (args.size - 1).coerceAtLeast(1))
}
