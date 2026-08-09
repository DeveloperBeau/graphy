package calc.repl

import calc.app.Installer
import calc.config.Settings
import calc.eval.Environment
import calc.eval.FunctionRegistry
import calc.funcs.Constants
import calc.history.History

final class Session {
  val environment = new Environment
  val registry = new FunctionRegistry
  val history = new History(capacity = 200)
  val settings = new Settings

  bootstrap()

  private def bootstrap(): Unit = {
    Installer.installBuiltins(registry, settings)
    Constants.seed(environment)
  }
}
