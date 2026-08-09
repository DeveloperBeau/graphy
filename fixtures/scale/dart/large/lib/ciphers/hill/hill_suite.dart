import '../../core/cipher.dart';
import '../../core/cipher_suite.dart';
import '../../core/suite_result.dart';
import '../../verify/round_trip.dart';
import 'hill_cipher.dart';
import 'hill_key.dart';
import 'hill_vectors.dart';

class HillSuite implements CipherSuite {
  @override
  String name() => 'hill';

  @override
  String category() => 'cipher';

  @override
  SuiteResult run() {
    final Cipher cipher = HillCipher(HillKey.defaultKey());
    var passed = 0;
    var failed = 0;
    final start = DateTime.now();
    for (final sample in hillSamples()) {
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
