import '../../core/cipher_suite.dart';
import '../../core/hash_function.dart';
import '../../core/suite_result.dart';
import '../../verify/determinism.dart';
import 'crc32_hash.dart';
import 'crc32_vectors.dart';

class Crc32Suite implements CipherSuite {
  @override
  String name() => 'crc32';

  @override
  String category() => 'hash';

  @override
  SuiteResult run() {
    final HashFunction hash = Crc32Hash();
    final samples = crc32Samples();
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
