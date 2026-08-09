import 'dart:math' as math;

import '../eval/function_registry.dart';

void registerExponential(FunctionRegistry registry) {
  registry.addUnary('exp', math.exp);
  registry.addUnary('expm1', (x) => math.exp(x) - 1);
}
