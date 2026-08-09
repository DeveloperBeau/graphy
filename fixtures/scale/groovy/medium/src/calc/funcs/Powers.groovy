package calc.funcs

import calc.eval.FunctionRegistry

class Powers {
    static void register(FunctionRegistry registry) {
        registry.addUnary("sqrt") { x -> Math.sqrt(x) }
        registry.addUnary("cbrt") { x -> Math.cbrt(x) }
        registry.addUnary("square") { x -> x * x }
        registry.addAggregate("hypot") { args -> Math.hypot(args[0], args[1]) }
        registry.addAggregate("pow") { args -> Math.pow(args[0], args[1]) }
    }
}
