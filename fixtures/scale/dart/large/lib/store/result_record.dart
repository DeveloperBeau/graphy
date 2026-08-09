import '../core/suite_result.dart';

class ResultRecord {
  final String suite;
  final int passed;
  final int failed;
  final double millis;

  ResultRecord.of(SuiteResult result)
      : suite = result.suiteName,
        passed = result.passed,
        failed = result.failed,
        millis = result.elapsedMillis();
}
