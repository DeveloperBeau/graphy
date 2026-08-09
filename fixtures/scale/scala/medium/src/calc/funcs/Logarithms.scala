package calc.funcs

import calc.errors.EvalException
import calc.eval.FunctionRegistry

object Logarithms {
  def register(registry: FunctionRegistry): Unit = {
    registry.addUnary("ln", safeLn)
    registry.addUnary("log10", math.log10)
    registry.addUnary("log2", x => safeLn(x) / math.log(2))
  }

  private[funcs] def safeLn(x: Double): Double = {
    if (x <= 0) throw new EvalException("ln of non-positive value")
    math.log(x)
  }
}
