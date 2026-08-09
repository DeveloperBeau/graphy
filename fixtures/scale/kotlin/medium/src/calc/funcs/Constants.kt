package calc.funcs

import calc.eval.Environment
import kotlin.math.PI
import kotlin.math.E
import kotlin.math.sqrt

val PHI = (1 + sqrt(5.0)) / 2
val TAU = 2 * PI

fun seedConstants(environment: Environment) {
    environment.define("pi", PI)
    environment.define("e", E)
    environment.define("phi", PHI)
    environment.define("tau", TAU)
}
