package calc.funcs

import calc.config.Settings
import calc.eval.FunctionRegistry
import kotlin.math.cos
import kotlin.math.sin
import kotlin.math.tan

fun registerTrig(registry: FunctionRegistry, settings: Settings) {
    registry.addUnary("sin") { sin(settings.toRadians(it)) }
    registry.addUnary("cos") { cos(settings.toRadians(it)) }
    registry.addUnary("tan") { tan(settings.toRadians(it)) }
}
