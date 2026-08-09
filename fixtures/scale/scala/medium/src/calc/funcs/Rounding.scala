package calc.funcs

import calc.eval.FunctionRegistry

object Rounding {
  def register(registry: FunctionRegistry): Unit = {
    registry.addUnary("floor", math.floor)
    registry.addUnary("ceil", math.ceil)
    registry.addUnary("round", x => math.round(x).toDouble)
    registry.addUnary("trunc", x => x.toLong.toDouble)
    registry.addUnary("abs", math.abs)
    registry.addUnary("sign", math.signum)
  }
}
