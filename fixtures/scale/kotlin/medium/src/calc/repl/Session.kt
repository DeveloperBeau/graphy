package calc.repl

import calc.app.installBuiltins
import calc.config.Settings
import calc.eval.Environment
import calc.eval.FunctionRegistry
import calc.funcs.seedConstants
import calc.history.History

class Session {
    val environment = Environment()
    val registry = FunctionRegistry()
    val history = History(capacity = 200)
    val settings = Settings()

    init {
        bootstrap()
    }

    private fun bootstrap() {
        installBuiltins(registry, settings)
        seedConstants(environment)
    }
}
