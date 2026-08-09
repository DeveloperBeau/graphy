package calc.repl

import calc.history.HistoryFormatter

class CommandHandler {
    private final Session session

    CommandHandler(Session session) {
        this.session = session
    }

    /** Returns false when the REPL should exit. */
    boolean handle(String command) {
        switch (command.trim()) {
            case ":quit":
            case ":q":
                return false
            case ":vars":
                session.environment.names().each { println it }
                return true
            case ":history":
                println HistoryFormatter.format(session.history)
                return true
            case ":degrees":
                session.settings.useDegrees()
                return true
            default:
                println "unknown command " + command
                return true
        }
    }
}
