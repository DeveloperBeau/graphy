package calc.repl

import calc.app.Calculator
import calc.errors.CalcException
import calc.io.ResultPrinter

class Repl {
    private final Session session
    private final CommandHandler commands

    Repl(Session session) {
        this.session = session
        this.commands = new CommandHandler(session)
    }

    int loop() {
        Calculator calculator = new Calculator(session)
        ResultPrinter printer = new ResultPrinter(session.settings)
        def reader = System.in.newReader()
        String line
        while ((line = reader.readLine()) != null) {
            if (line.trim().isEmpty()) continue
            if (line.startsWith(":")) {
                if (!commands.handle(line)) return 0
                continue
            }
            try {
                double value = calculator.evaluateLine(line)
                session.history.record(line, value)
                printer.print(value)
            } catch (CalcException e) {
                println "error: " + e.message
            }
        }
        return 0
    }
}
