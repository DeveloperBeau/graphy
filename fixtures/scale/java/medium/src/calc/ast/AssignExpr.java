package calc.ast;

public class AssignExpr implements Expr {
    private final String name;
    private final Expr value;

    public AssignExpr(String name, Expr value) {
        this.name = name;
        this.value = value;
    }

    public String getName() {
        return name;
    }

    public Expr getValue() {
        return value;
    }
}
