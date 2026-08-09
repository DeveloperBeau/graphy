package calc.repl

import calc.history.formatHistory

class CommandHandler(private val session: Session) {

    /** Returns false when the REPL should exit. */
    fun handle(command: String): Boolean {
        when (command.trim()) {
            ":quit", ":q" -> return false
            ":vars" -> session.environment.names().forEach(::println)
            ":history" -> println(formatHistory(session.history))
            ":degrees" -> session.settings.useDegrees()
            ":radians" -> session.settings.useRadians()
            else -> println("unknown command " + command)
        }
        return true
    }
}
