import '../core/suite_result.dart';
import 'console_sink.dart';

class ProgressReporter {
  final ConsoleSink sink = ConsoleSink();
  int _total = 0;
  int _done = 0;

  void begin(int suiteCount) {
    _total = suiteCount;
    sink.line('running $suiteCount suites');
  }

  void startSuite(String name) {
    sink.transientLine('[${_done + 1}/$_total] $name...');
  }

  void finishSuite(SuiteResult result) {
    _done++;
    final status = result.allPassed() ? 'ok' : 'FAIL';
    sink.line('\r[$_done/$_total] ${result.suiteName} $status');
  }

  void end(String summaryText) {
    sink.line(summaryText);
  }
}
