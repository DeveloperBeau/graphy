package calc.eval;

import java.util.HashMap;
import java.util.Map;
import java.util.function.DoubleUnaryOperator;

import calc.errors.EvalException;

public class FunctionRegistry {
    private final Map<String, DoubleUnaryOperator> unary = new HashMap<>();
    private final Map<String, AggregateFunction> aggregate = new HashMap<>();

    public void addUnary(String name, DoubleUnaryOperator fn) {
        unary.put(name, fn);
    }

    public void addAggregate(String name, AggregateFunction fn) {
        aggregate.put(name, fn);
    }

    public double invoke(String name, double[] args) {
        if (args.length == 1 && unary.containsKey(name)) {
            return unary.get(name).applyAsDouble(args[0]);
        }
        AggregateFunction fn = aggregate.get(name);
        if (fn == null) {
            throw new EvalException("unknown function " + name + "/" + args.length);
        }
        return fn.applyAll(args);
    }

    public boolean knows(String name) {
        return unary.containsKey(name) || aggregate.containsKey(name);
    }
}
