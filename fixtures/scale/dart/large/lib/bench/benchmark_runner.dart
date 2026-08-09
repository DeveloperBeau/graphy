import '../config/settings.dart';
import '../core/cipher_suite.dart';
import '../live/progress_reporter.dart';
import '../report/summary.dart';
import '../store/result_store.dart';

class BenchmarkRunner {
  final Settings settings;
  final ProgressReporter reporter = ProgressReporter();

  BenchmarkRunner(this.settings);

  int runAll(List<CipherSuite> suites) {
    final store = ResultStore.openAt(settings.outputDir);
    final summary = Summary();
    reporter.begin(suites.length);
    for (final suite in suites) {
      reporter.startSuite(suite.name());
      final result = suite.run();
      store.append(result);
      summary.add(result);
      reporter.finishSuite(result);
    }
    store.close();
    reporter.end(summary.render());
    return summary.totalFailed();
  }
}
