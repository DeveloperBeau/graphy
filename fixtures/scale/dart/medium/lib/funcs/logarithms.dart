import 'dart:math' as math;

import '../errors/eval_exception.dart';
import '../eval/function_registry.dart';

void registerLogarithms(FunctionRegistry registry) {
  registry.addUnary('ln', safeLn);
  registry.addUnary('log10', (x) => safeLn(x) / math.ln10);
  registry.addUnary('log2', (x) => safeLn(x) / math.ln2);
}

double safeLn(double x) {
  if (x <= 0) throw EvalException('ln of non-positive value');
  return math.log(x);
}
