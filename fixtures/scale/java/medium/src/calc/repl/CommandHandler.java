package calc.repl;

import java.io.PrintStream;

import calc.history.HistoryFormatter;

public class CommandHandler {
    private final Session session;

    public CommandHandler(Session session) {
        this.session = session;
    }

    /** Returns false when the REPL should exit. */
    public boolean handle(String command, PrintStream out) {
        switch (command.trim()) {
            case ":quit":
            case ":q":
                return false;
            case ":vars":
                session.getEnvironment().names().forEach(out::println);
                return true;
            case ":history":
                out.println(HistoryFormatter.format(session.getHistory()));
                return true;
            case ":degrees":
                session.getSettings().useDegrees();
                return true;
            case ":radians":
                session.getSettings().useRadians();
                return true;
            default:
                out.println("unknown command " + command);
                return true;
        }
    }
}
