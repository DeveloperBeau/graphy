package calc.repl

import calc.app.Calculator
import calc.errors.CalcException
import calc.io.ResultPrinter

class Repl(private val session: Session) {
    private val commands = CommandHandler(session)

    fun loop(): Int {
        val calculator = Calculator(session)
        val printer = ResultPrinter(session.settings)
        while (true) {
            val line = readlnOrNull() ?: return 0
            if (line.isBlank()) continue
            if (line.startsWith(":")) {
                if (!commands.handle(line)) return 0
                continue
            }
            try {
                val value = calculator.evaluateLine(line)
                session.history.record(line, value)
                printer.print(value)
            } catch (e: CalcException) {
                println("error: " + e.message)
            }
        }
    }
}
