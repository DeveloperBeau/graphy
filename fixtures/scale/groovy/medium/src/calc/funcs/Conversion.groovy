package calc.funcs

import calc.eval.FunctionRegistry

class Conversion {
    static void register(FunctionRegistry registry) {
        registry.addUnary("radToDeg") { x -> Math.toDegrees(x) }
        registry.addUnary("degToRad") { x -> Math.toRadians(x) }
        registry.addUnary("percent") { x -> x / 100.0 }
        registry.addAggregate("percentOf") { args -> args[0] / 100.0 * args[1] }
    }
}
