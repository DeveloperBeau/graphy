package calc.funcs

import calc.config.Settings
import calc.eval.FunctionRegistry
import kotlin.math.acos
import kotlin.math.asin
import kotlin.math.atan

fun registerInverseTrig(registry: FunctionRegistry, settings: Settings) {
    registry.addUnary("asin") { settings.fromRadians(asin(it)) }
    registry.addUnary("acos") { settings.fromRadians(acos(it)) }
    registry.addUnary("atan") { settings.fromRadians(atan(it)) }
}
