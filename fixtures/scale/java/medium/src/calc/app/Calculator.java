package calc.app;

import calc.ast.Expr;
import calc.eval.Evaluator;
import calc.lexer.Lexer;
import calc.parser.Parser;
import calc.repl.Session;

/** Facade tying the lexer, parser and evaluator together. */
public class Calculator {
    private final Session session;

    public Calculator(Session session) {
        this.session = session;
    }

    public double evaluateLine(String line) {
        Lexer lexer = new Lexer(line);
        Parser parser = new Parser(lexer.tokenize());
        Expr root = parser.parseExpression();
        Evaluator evaluator = new Evaluator(session.getEnvironment(), session.getRegistry());
        return evaluator.evaluate(root);
    }
}
