import 'dart:math' as math;

import '../eval/function_registry.dart';

double _sinh(double x) => (math.exp(x) - math.exp(-x)) / 2;
double _cosh(double x) => (math.exp(x) + math.exp(-x)) / 2;
double _tanh(double x) => _sinh(x) / _cosh(x);

void registerHyperbolic(FunctionRegistry registry) {
  registry.addUnary('sinh', _sinh);
  registry.addUnary('cosh', _cosh);
  registry.addUnary('tanh', _tanh);
}
