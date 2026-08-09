package calc.ast;

public class NumberExpr implements Expr {
    private final double value;

    public NumberExpr(double value) {
        this.value = value;
    }

    public double getValue() {
        return value;
    }

    @Override
    public String describe() {
        return Double.toString(value);
    }
}
