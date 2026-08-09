package calc.funcs

import calc.config.Settings
import calc.eval.FunctionRegistry

class Trig {
    static void register(FunctionRegistry registry, Settings settings) {
        registry.addUnary("sin") { x -> Math.sin(settings.toRadians(x)) }
        registry.addUnary("cos") { x -> Math.cos(settings.toRadians(x)) }
        registry.addUnary("tan") { x -> Math.tan(settings.toRadians(x)) }
    }
}
