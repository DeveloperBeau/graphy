package calc.funcs

import calc.eval.FunctionRegistry

fun registerConversion(registry: FunctionRegistry) {
    registry.addUnary("radToDeg") { Math.toDegrees(it) }
    registry.addUnary("degToRad") { Math.toRadians(it) }
    registry.addUnary("percent") { it / 100.0 }
    registry.addAggregate("percentOf") { it[0] / 100.0 * it[1] }
}
