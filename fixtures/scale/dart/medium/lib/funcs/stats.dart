import 'dart:math' as math;

import '../eval/function_registry.dart';

void registerStats(FunctionRegistry registry) {
  registry.addAggregate('min', (args) => args.reduce(math.min));
  registry.addAggregate('max', (args) => args.reduce(math.max));
  registry.addAggregate('sum', (args) => args.fold(0.0, (a, b) => a + b));
  registry.addAggregate('mean', mean);
  registry.addAggregate('stddev', stddev);
}

double mean(List<double> args) => args.fold(0.0, (a, b) => a + b) / args.length;

double stddev(List<double> args) {
  final m = mean(args);
  final sum = args.fold(0.0, (a, b) => a + (b - m) * (b - m));
  return math.sqrt(sum / math.max(1, args.length - 1));
}
