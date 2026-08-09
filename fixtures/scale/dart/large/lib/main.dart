import 'dart:io';

import 'bench/benchmark_runner.dart';
import 'cli/args.dart';
import 'config/settings.dart';
import 'registry/suite_catalog.dart';

void main(List<String> argv) {
  final args = Args.parse(argv);
  final settings = Settings.fromArgs(args);
  final runner = BenchmarkRunner(settings);
  final failures = runner.runAll(allSuites(args.filter));
  exit(failures == 0 ? 0 : 1);
}
