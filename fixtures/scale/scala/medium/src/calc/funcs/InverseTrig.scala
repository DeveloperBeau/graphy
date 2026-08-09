package calc.funcs

import calc.config.Settings
import calc.eval.FunctionRegistry

object InverseTrig {
  def register(registry: FunctionRegistry, settings: Settings): Unit = {
    registry.addUnary("asin", x => settings.fromRadians(math.asin(x)))
    registry.addUnary("acos", x => settings.fromRadians(math.acos(x)))
    registry.addUnary("atan", x => settings.fromRadians(math.atan(x)))
  }
}
