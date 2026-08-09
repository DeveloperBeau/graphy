package calc.ast

class NumberExpr implements Expr {
    final double value

    NumberExpr(double value) {
        this.value = value
    }

    String describe() {
        return value.toString()
    }
}
