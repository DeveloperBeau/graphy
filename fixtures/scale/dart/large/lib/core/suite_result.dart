class SuiteResult {
  final String suiteName;
  final int passed;
  final int failed;
  final int elapsedMicros;

  SuiteResult(this.suiteName, this.passed, this.failed, this.elapsedMicros);

  bool allPassed() => failed == 0;

  double elapsedMillis() => elapsedMicros / 1000.0;
}
