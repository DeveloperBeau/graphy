import 'dart:math' as math;

import '../config/settings.dart';
import '../eval/function_registry.dart';

void registerTrig(FunctionRegistry registry, Settings settings) {
  registry.addUnary('sin', (x) => math.sin(settings.toRadians(x)));
  registry.addUnary('cos', (x) => math.cos(settings.toRadians(x)));
  registry.addUnary('tan', (x) => math.tan(settings.toRadians(x)));
}
