package calc.funcs

import calc.eval.FunctionRegistry

object Exponential {
  def register(registry: FunctionRegistry): Unit = {
    registry.addUnary("exp", math.exp)
    registry.addUnary("expm1", math.expm1)
  }
}
