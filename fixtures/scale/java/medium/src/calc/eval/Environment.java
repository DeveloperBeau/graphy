package calc.eval;

import java.util.Set;
import java.util.TreeMap;

import calc.errors.EvalException;

public class Environment {
    private final TreeMap<String, Double> variables = new TreeMap<>();

    public void define(String name, double value) {
        variables.put(name, value);
    }

    public double lookup(String name) {
        Double value = variables.get(name);
        if (value == null) {
            throw new EvalException("unknown variable " + name);
        }
        return value;
    }

    public boolean isDefined(String name) {
        return variables.containsKey(name);
    }

    public Set<String> names() {
        return variables.keySet();
    }
}
