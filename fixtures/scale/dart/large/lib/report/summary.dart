import '../core/suite_result.dart';
import 'table_format.dart';

class Summary {
  final List<SuiteResult> _results = [];

  void add(SuiteResult result) {
    _results.add(result);
  }

  int totalFailed() => _results.fold(0, (sum, r) => sum + r.failed);

  String render() {
    final sb = StringBuffer();
    sb.writeln(tableHeader());
    sb.writeln(tableRule());
    for (final r in _results) {
      sb.writeln(formatRow(r.suiteName, r.passed, r.failed, r.elapsedMillis()));
    }
    sb.write('${_results.length} suites, ${totalFailed()} failures');
    return sb.toString();
  }
}
