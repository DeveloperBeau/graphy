import 'dart:math' as math;

import '../config/settings.dart';
import '../eval/function_registry.dart';

void registerInverseTrig(FunctionRegistry registry, Settings settings) {
  registry.addUnary('asin', (x) => settings.fromRadians(math.asin(x)));
  registry.addUnary('acos', (x) => settings.fromRadians(math.acos(x)));
  registry.addUnary('atan', (x) => settings.fromRadians(math.atan(x)));
}
