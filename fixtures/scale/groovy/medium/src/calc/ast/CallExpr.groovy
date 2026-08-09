package calc.ast

class CallExpr implements Expr {
    final String function
    final List<Expr> arguments

    CallExpr(String function, List<Expr> arguments) {
        this.function = function
        this.arguments = arguments
    }

    String describe() {
        return function + "/" + arguments.size()
    }
}
