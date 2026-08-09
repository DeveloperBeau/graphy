import 'dart:math' as math;

import '../eval/function_registry.dart';

void registerConversion(FunctionRegistry registry) {
  registry.addUnary('radToDeg', (x) => x * 180 / math.pi);
  registry.addUnary('degToRad', (x) => x * math.pi / 180);
  registry.addUnary('percent', (x) => x / 100.0);
  registry.addAggregate('percentOf', (args) => args[0] / 100.0 * args[1]);
}
