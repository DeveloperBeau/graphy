package calc.parser

import calc.errors.EvalException
import calc.util.DoubleCompare

object OperatorTable {
  def apply(op: Char, left: Double, right: Double): Double = op match {
    case '+' => left + right
    case '-' => left - right
    case '*' => left * right
    case '/' =>
      if (DoubleCompare.nearlyZero(right)) throw new EvalException("division by zero")
      else left / right
    case '%' => left % right
    case '^' => math.pow(left, right)
    case _   => throw new EvalException("unknown operator " + op)
  }
}
