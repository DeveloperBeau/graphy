import '../eval/evaluator.dart';
import '../lexer/lexer.dart';
import '../parser/parser.dart';
import '../repl/session.dart';

/// Facade tying the lexer, parser and evaluator together.
class Calculator {
  final Session session;

  Calculator(this.session);

  double evaluateLine(String line) {
    final tokens = Lexer(line).tokenize();
    final root = Parser(tokens).parseExpression();
    final evaluator = Evaluator(session.environment, session.registry);
    return evaluator.evaluate(root);
  }
}
