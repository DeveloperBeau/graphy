import '../../core/cipher.dart';
import '../../core/cipher_suite.dart';
import '../../core/suite_result.dart';
import '../../verify/round_trip.dart';
import 'lcg_cipher.dart';
import 'lcg_key.dart';
import 'lcg_vectors.dart';

class LcgSuite implements CipherSuite {
  @override
  String name() => 'lcg';

  @override
  String category() => 'cipher';

  @override
  SuiteResult run() {
    final Cipher cipher = LcgCipher(LcgKey.defaultKey());
    var passed = 0;
    var failed = 0;
    final start = DateTime.now();
    for (final sample in lcgSamples()) {
      if (roundTripCheck(cipher, sample)) {
        passed++;
      } else {
        failed++;
      }
    }
    final elapsed = DateTime.now().difference(start).inMicroseconds;
    return SuiteResult(name(), passed, failed, elapsed);
  }
}
