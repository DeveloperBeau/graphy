package calc.eval

import calc.errors.EvalException
import java.util.TreeMap

class Environment {
    private val variables = TreeMap<String, Double>()

    fun define(name: String, value: Double) {
        variables[name] = value
    }

    fun lookup(name: String): Double =
        variables[name] ?: throw EvalException("unknown variable " + name)

    fun isDefined(name: String): Boolean = variables.containsKey(name)

    fun names(): Set<String> = variables.keys
}
