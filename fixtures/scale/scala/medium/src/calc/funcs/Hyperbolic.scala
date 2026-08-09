package calc.funcs

import calc.eval.FunctionRegistry

object Hyperbolic {
  def register(registry: FunctionRegistry): Unit = {
    registry.addUnary("sinh", math.sinh)
    registry.addUnary("cosh", math.cosh)
    registry.addUnary("tanh", math.tanh)
  }
}
