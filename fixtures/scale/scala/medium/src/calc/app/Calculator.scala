package calc.app

import calc.eval.Evaluator
import calc.lexer.Lexer
import calc.parser.Parser
import calc.repl.Session

/** Facade tying the lexer, parser and evaluator together. */
final class Calculator(session: Session) {

  def evaluateLine(line: String): Double = {
    val tokens = new Lexer(line).tokenize()
    val root = new Parser(tokens).parseExpression()
    val evaluator = new Evaluator(session.environment, session.registry)
    evaluator.evaluate(root)
  }
}
