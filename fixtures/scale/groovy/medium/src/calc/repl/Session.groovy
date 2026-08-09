package calc.repl

import calc.app.Installer
import calc.config.Settings
import calc.eval.Environment
import calc.eval.FunctionRegistry
import calc.funcs.Constants
import calc.history.History

class Session {
    final Environment environment = new Environment()
    final FunctionRegistry registry = new FunctionRegistry()
    final History history = new History(200)
    final Settings settings = new Settings()

    Session() {
        bootstrap()
    }

    private void bootstrap() {
        Installer.installBuiltins(registry, settings)
        Constants.seed(environment)
    }
}
