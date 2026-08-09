package calc.eval

import calc.errors.EvalException

class FunctionRegistry {
    private val unary = mutableMapOf<String, (Double) -> Double>()
    private val aggregate = mutableMapOf<String, (DoubleArray) -> Double>()

    fun addUnary(name: String, fn: (Double) -> Double) {
        unary[name] = fn
    }

    fun addAggregate(name: String, fn: (DoubleArray) -> Double) {
        aggregate[name] = fn
    }

    fun invoke(name: String, args: DoubleArray): Double {
        if (args.size == 1) unary[name]?.let { return it(args[0]) }
        val fn = aggregate[name] ?: throw EvalException("unknown function " + name + "/" + args.size)
        return fn(args)
    }

    fun knows(name: String): Boolean = name in unary || name in aggregate
}
