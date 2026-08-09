package calc.funcs;

import java.util.Arrays;

import calc.eval.FunctionRegistry;

public class StatFunctions {
    public static void register(FunctionRegistry registry) {
        registry.addAggregate("min", args -> Arrays.stream(args).min().orElse(Double.NaN));
        registry.addAggregate("max", args -> Arrays.stream(args).max().orElse(Double.NaN));
        registry.addAggregate("sum", args -> Arrays.stream(args).sum());
        registry.addAggregate("mean", StatFunctions::mean);
        registry.addAggregate("stddev", StatFunctions::stddev);
    }

    static double mean(double[] args) {
        return Arrays.stream(args).average().orElse(Double.NaN);
    }

    static double stddev(double[] args) {
        double m = mean(args);
        double sum = Arrays.stream(args).map(x -> (x - m) * (x - m)).sum();
        return Math.sqrt(sum / Math.max(1, args.length - 1));
    }
}
