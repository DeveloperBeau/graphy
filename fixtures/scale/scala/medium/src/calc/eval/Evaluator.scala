package calc.eval

import calc.ast._
import calc.parser.OperatorTable

final class Evaluator(environment: Environment, registry: FunctionRegistry) {

  def evaluate(expr: Expr): Double = expr match {
    case NumberExpr(value) => value
    case VariableExpr(name) => environment.lookup(name)
    case AssignExpr(name, value) =>
      val result = evaluate(value)
      environment.define(name, result)
      result
    case UnaryExpr(op, operand) =>
      val inner = evaluate(operand)
      if (op == '-') -inner else inner
    case BinaryExpr(op, left, right) =>
      OperatorTable.apply(op, evaluate(left), evaluate(right))
    case CallExpr(function, arguments) =>
      registry.invoke(function, arguments.map(evaluate).toArray)
  }
}
