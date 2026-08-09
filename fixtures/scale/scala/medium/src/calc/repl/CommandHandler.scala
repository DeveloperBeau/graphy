package calc.repl

import calc.history.HistoryFormatter

final class CommandHandler(session: Session) {

  /** Returns false when the REPL should exit. */
  def handle(command: String): Boolean = command.trim match {
    case ":quit" | ":q" =>
      false
    case ":vars" =>
      session.environment.names.foreach(println)
      true
    case ":history" =>
      println(HistoryFormatter.format(session.history))
      true
    case ":degrees" =>
      session.settings.useDegrees()
      true
    case ":radians" =>
      session.settings.useRadians()
      true
    case other =>
      println("unknown command " + other)
      true
  }
}
