package calc.ast

class VariableExpr implements Expr {
    final String name

    VariableExpr(String name) {
        this.name = name
    }

    String describe() {
        return name
    }
}
