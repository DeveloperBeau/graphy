package calc.eval

import calc.errors.EvalException

class FunctionRegistry {
    private final Map<String, Closure<Double>> unary = [:]
    private final Map<String, Closure<Double>> aggregate = [:]

    void addUnary(String name, Closure<Double> fn) {
        unary[name] = fn
    }

    void addAggregate(String name, Closure<Double> fn) {
        aggregate[name] = fn
    }

    double invoke(String name, double[] args) {
        if (args.length == 1 && unary.containsKey(name)) return unary[name](args[0])
        if (!aggregate.containsKey(name)) throw new EvalException("unknown function " + name + "/" + args.length)
        return aggregate[name](args)
    }

    boolean knows(String name) {
        return unary.containsKey(name) || aggregate.containsKey(name)
    }
}
