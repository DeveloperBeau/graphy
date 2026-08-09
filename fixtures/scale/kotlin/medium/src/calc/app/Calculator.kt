package calc.app

import calc.eval.Evaluator
import calc.lexer.Lexer
import calc.parser.Parser
import calc.repl.Session

/** Facade tying the lexer, parser and evaluator together. */
class Calculator(private val session: Session) {

    fun evaluateLine(line: String): Double {
        val tokens = Lexer(line).tokenize()
        val root = Parser(tokens).parseExpression()
        val evaluator = Evaluator(session.environment, session.registry)
        return evaluator.evaluate(root)
    }
}
