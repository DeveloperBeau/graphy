package calc.ast

class AssignExpr implements Expr {
    final String name
    final Expr value

    AssignExpr(String name, Expr value) {
        this.name = name
        this.value = value
    }

    String describe() {
        return name + " = " + value.describe()
    }
}
