package calc.ast;

public class BinaryExpr implements Expr {
    private final char operator;
    private final Expr left;
    private final Expr right;

    public BinaryExpr(char operator, Expr left, Expr right) {
        this.operator = operator;
        this.left = left;
        this.right = right;
    }

    public char getOperator() {
        return operator;
    }

    public Expr getLeft() {
        return left;
    }

    public Expr getRight() {
        return right;
    }
}
