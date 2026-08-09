package calc.eval

import calc.errors.EvalException

class Environment {
    private final TreeMap<String, Double> variables = new TreeMap<>()

    void define(String name, double value) {
        variables[name] = value
    }

    double lookup(String name) {
        if (!variables.containsKey(name)) throw new EvalException("unknown variable " + name)
        return variables[name]
    }

    boolean isDefined(String name) {
        return variables.containsKey(name)
    }

    Set<String> names() {
        return variables.keySet()
    }
}
