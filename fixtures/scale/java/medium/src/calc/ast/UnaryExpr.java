package calc.ast;

public class UnaryExpr implements Expr {
    private final char operator;
    private final Expr operand;

    public UnaryExpr(char operator, Expr operand) {
        this.operator = operator;
        this.operand = operand;
    }

    public char getOperator() {
        return operator;
    }

    public Expr getOperand() {
        return operand;
    }
}
