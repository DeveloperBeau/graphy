import '../errors/eval_exception.dart';
import '../eval/function_registry.dart';

void registerCombinatorics(FunctionRegistry registry) {
  registry.addUnary('fact', factorial);
  registry.addAggregate('ncr', (args) => choose(args[0], args[1]));
  registry.addAggregate('npr', (args) => factorial(args[0]) / factorial(args[0] - args[1]));
}

double factorial(double n) {
  if (n < 0 || n != n.floorToDouble()) {
    throw EvalException('factorial needs a non-negative integer');
  }
  var result = 1.0;
  for (var i = 2; i <= n.toInt(); i++) {
    result *= i;
  }
  return result;
}

double choose(double n, double k) => factorial(n) / (factorial(k) * factorial(n - k));
