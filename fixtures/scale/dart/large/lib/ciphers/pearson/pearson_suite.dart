import '../../core/cipher_suite.dart';
import '../../core/hash_function.dart';
import '../../core/suite_result.dart';
import '../../verify/determinism.dart';
import 'pearson_hash.dart';
import 'pearson_vectors.dart';

class PearsonSuite implements CipherSuite {
  @override
  String name() => 'pearson';

  @override
  String category() => 'hash';

  @override
  SuiteResult run() {
    final HashFunction hash = PearsonHash();
    final samples = pearsonSamples();
    var passed = 0;
    var failed = 0;
    final start = DateTime.now();
    for (final sample in samples) {
      if (stableDigest(hash, sample)) passed++; else failed++;
    }
    for (final other in samples) {
      if (distinctDigests(hash, samples[0], other)) passed++; else failed++;
    }
    final elapsed = DateTime.now().difference(start).inMicroseconds;
    return SuiteResult(name(), passed, failed, elapsed);
  }
}
