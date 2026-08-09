import 'dart:math' as math;

import '../eval/function_registry.dart';

void registerRounding(FunctionRegistry registry) {
  registry.addUnary('floor', (x) => x.floorToDouble());
  registry.addUnary('ceil', (x) => x.ceilToDouble());
  registry.addUnary('round', (x) => x.roundToDouble());
  registry.addUnary('trunc', (x) => x.truncateToDouble());
  registry.addUnary('abs', (x) => x.abs());
  registry.addUnary('sign', (x) => x.sign);
}
