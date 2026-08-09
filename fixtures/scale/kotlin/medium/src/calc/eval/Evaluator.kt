package calc.eval

import calc.ast.AssignExpr
import calc.ast.BinaryExpr
import calc.ast.CallExpr
import calc.ast.Expr
import calc.ast.NumberExpr
import calc.ast.UnaryExpr
import calc.ast.VariableExpr
import calc.parser.applyOperator

class Evaluator(
    private val environment: Environment,
    private val registry: FunctionRegistry,
) {
    fun evaluate(expr: Expr): Double = when (expr) {
        is NumberExpr -> expr.value
        is VariableExpr -> environment.lookup(expr.name)
        is AssignExpr -> evaluate(expr.value).also { environment.define(expr.name, it) }
        is UnaryExpr -> if (expr.operator == '-') -evaluate(expr.operand) else evaluate(expr.operand)
        is BinaryExpr -> applyOperator(expr.operator, evaluate(expr.left), evaluate(expr.right))
        is CallExpr -> registry.invoke(expr.function, expr.arguments.map { evaluate(it) }.toDoubleArray())
    }
}
