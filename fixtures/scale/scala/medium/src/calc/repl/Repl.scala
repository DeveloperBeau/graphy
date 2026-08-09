package calc.repl

import scala.io.StdIn

import calc.app.Calculator
import calc.errors.CalcException
import calc.io.ResultPrinter

final class Repl(session: Session) {
  private val commands = new CommandHandler(session)

  def loop(): Int = {
    val calculator = new Calculator(session)
    val printer = new ResultPrinter(session.settings)
    var running = true
    while (running) {
      val line = Option(StdIn.readLine())
      line match {
        case None => running = false
        case Some(text) if text.trim.isEmpty => ()
        case Some(text) if text.startsWith(":") =>
          running = commands.handle(text)
        case Some(text) =>
          try {
            val value = calculator.evaluateLine(text)
            session.history.record(text, value)
            printer.print(value)
          } catch {
            case e: CalcException => println("error: " + e.getMessage)
          }
      }
    }
    0
  }
}
