package calc.ast

class UnaryExpr implements Expr {
    final char operator
    final Expr operand

    UnaryExpr(char operator, Expr operand) {
        this.operator = operator
        this.operand = operand
    }

    String describe() {
        return operator + operand.describe()
    }

    boolean isNegation() {
        return operator == ('-' as char)
    }
}
