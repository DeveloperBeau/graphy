package calc.eval

import calc.ast.AssignExpr
import calc.ast.BinaryExpr
import calc.ast.CallExpr
import calc.ast.Expr
import calc.ast.NumberExpr
import calc.ast.UnaryExpr
import calc.ast.VariableExpr
import calc.parser.OperatorTable

class Evaluator {
    private final Environment environment
    private final FunctionRegistry registry

    Evaluator(Environment environment, FunctionRegistry registry) {
        this.environment = environment
        this.registry = registry
    }

    double evaluate(Expr expr) {
        if (expr instanceof NumberExpr) return expr.value
        if (expr instanceof VariableExpr) return environment.lookup(expr.name)
        if (expr instanceof AssignExpr) {
            double value = evaluate(expr.value)
            environment.define(expr.name, value)
            return value
        }
        if (expr instanceof UnaryExpr) {
            double inner = evaluate(expr.operand)
            return expr.operator == ('-' as char) ? -inner : inner
        }
        if (expr instanceof BinaryExpr) return OperatorTable.apply(expr.operator, evaluate(expr.left), evaluate(expr.right))
        if (expr instanceof CallExpr) return registry.invoke(expr.function, expr.arguments.collect { evaluate(it) } as double[])
        throw new IllegalStateException("cannot evaluate " + expr.describe())
    }
}
