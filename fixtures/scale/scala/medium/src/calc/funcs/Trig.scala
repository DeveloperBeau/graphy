package calc.funcs

import calc.config.Settings
import calc.eval.FunctionRegistry

object Trig {
  def register(registry: FunctionRegistry, settings: Settings): Unit = {
    registry.addUnary("sin", x => math.sin(settings.toRadians(x)))
    registry.addUnary("cos", x => math.cos(settings.toRadians(x)))
    registry.addUnary("tan", x => math.tan(settings.toRadians(x)))
  }
}
