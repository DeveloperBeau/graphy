package calc.funcs

import calc.eval.FunctionRegistry

class Stats {
    static void register(FunctionRegistry registry) {
        registry.addAggregate("min") { args -> args.min() }
        registry.addAggregate("max") { args -> args.max() }
        registry.addAggregate("sum") { args -> args.sum() as double }
        registry.addAggregate("mean") { args -> mean(args) }
        registry.addAggregate("stddev") { args -> stddev(args) }
    }

    static double mean(double[] args) {
        return (args.sum() as double) / args.length
    }

    static double stddev(double[] args) {
        double m = mean(args)
        double sum = args.collect { (it - m) * (it - m) }.sum()
        return Math.sqrt(sum / Math.max(1, args.length - 1))
    }
}
