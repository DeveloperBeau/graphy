package calc.ast;

public class VariableExpr implements Expr {
    private final String name;

    public VariableExpr(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }

    @Override
    public String describe() {
        return name;
    }
}
