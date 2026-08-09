package calc.repl;

import java.io.InputStream;
import java.io.PrintStream;

import calc.app.Calculator;
import calc.errors.CalcException;
import calc.io.ResultPrinter;

public class Repl {
    private final Session session;
    private final CommandHandler commands;

    public Repl(Session session) {
        this.session = session;
        this.commands = new CommandHandler(session);
    }

    public int loop(InputStream in, PrintStream out) {
        InputReader reader = new InputReader(in);
        Calculator calculator = new Calculator(session);
        ResultPrinter printer = new ResultPrinter(session.getSettings());
        String line;
        while ((line = reader.nextLine()) != null) {
            if (line.isBlank()) continue;
            if (line.startsWith(":")) {
                if (!commands.handle(line, out)) return 0;
                continue;
            }
            try {
                double value = calculator.evaluateLine(line);
                session.getHistory().record(line, value);
                printer.print(out, value);
            } catch (CalcException e) {
                out.println("error: " + e.getMessage());
            }
        }
        return 0;
    }
}
