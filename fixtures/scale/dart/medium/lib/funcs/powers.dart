import 'dart:math' as math;

import '../eval/function_registry.dart';

void registerPowers(FunctionRegistry registry) {
  registry.addUnary('sqrt', math.sqrt);
  registry.addUnary('cbrt', (x) => x < 0 ? -math.pow(-x, 1 / 3).toDouble() : math.pow(x, 1 / 3).toDouble());
  registry.addUnary('square', (x) => x * x);
  registry.addAggregate('hypot', (args) => math.sqrt(args[0] * args[0] + args[1] * args[1]));
  registry.addAggregate('pow', (args) => math.pow(args[0], args[1]).toDouble());
}
