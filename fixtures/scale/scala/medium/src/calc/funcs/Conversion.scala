package calc.funcs

import calc.eval.FunctionRegistry

object Conversion {
  def register(registry: FunctionRegistry): Unit = {
    registry.addUnary("radToDeg", math.toDegrees)
    registry.addUnary("degToRad", math.toRadians)
    registry.addUnary("percent", _ / 100.0)
    registry.addAggregate("percentOf", args => args(0) / 100.0 * args(1))
  }
}
