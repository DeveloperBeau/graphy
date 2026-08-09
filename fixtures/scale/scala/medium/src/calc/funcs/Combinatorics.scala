package calc.funcs

import calc.errors.EvalException
import calc.eval.FunctionRegistry

object Combinatorics {
  def register(registry: FunctionRegistry): Unit = {
    registry.addUnary("fact", factorial)
    registry.addAggregate("ncr", args => choose(args(0), args(1)))
    registry.addAggregate("npr", args => factorial(args(0)) / factorial(args(0) - args(1)))
  }

  private[funcs] def factorial(n: Double): Double = {
    if (n < 0 || n != math.floor(n))
      throw new EvalException("factorial needs a non-negative integer")
    (2 to n.toInt).foldLeft(1.0)(_ * _)
  }

  private[funcs] def choose(n: Double, k: Double): Double =
    factorial(n) / (factorial(k) * factorial(n - k))
}
