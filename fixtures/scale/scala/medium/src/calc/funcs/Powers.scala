package calc.funcs

import calc.eval.FunctionRegistry

object Powers {
  def register(registry: FunctionRegistry): Unit = {
    registry.addUnary("sqrt", math.sqrt)
    registry.addUnary("cbrt", math.cbrt)
    registry.addUnary("square", x => x * x)
    registry.addAggregate("hypot", args => math.hypot(args(0), args(1)))
    registry.addAggregate("pow", args => math.pow(args(0), args(1)))
  }
}
