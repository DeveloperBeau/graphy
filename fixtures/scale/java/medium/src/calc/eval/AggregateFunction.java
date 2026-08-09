package calc.eval;

/** A function over one or more arguments, like max or mean. */
@FunctionalInterface
public interface AggregateFunction {
    double applyAll(double[] arguments);

    default double applySingle(double argument) {
        return applyAll(new double[] { argument });
    }
}
