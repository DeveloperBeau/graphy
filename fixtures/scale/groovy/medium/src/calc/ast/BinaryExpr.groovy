package calc.ast

class BinaryExpr implements Expr {
    final char operator
    final Expr left
    final Expr right

    BinaryExpr(char operator, Expr left, Expr right) {
        this.operator = operator
        this.left = left
        this.right = right
    }

    String describe() {
        return "(" + left.describe() + " " + operator + " " + right.describe() + ")"
    }
}
