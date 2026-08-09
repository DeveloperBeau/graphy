package calc.app

import calc.eval.Evaluator
import calc.lexer.Lexer
import calc.parser.Parser
import calc.repl.Session

/** Facade tying the lexer, parser and evaluator together. */
class Calculator {
    private final Session session

    Calculator(Session session) {
        this.session = session
    }

    double evaluateLine(String line) {
        def tokens = new Lexer(line).tokenize()
        def root = new Parser(tokens).parseExpression()
        def evaluator = new Evaluator(session.environment, session.registry)
        return evaluator.evaluate(root)
    }
}
