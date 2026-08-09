import '../../core/cipher.dart';
import '../../core/cipher_suite.dart';
import '../../core/suite_result.dart';
import '../../verify/round_trip.dart';
import 'beaufort_cipher.dart';
import 'beaufort_key.dart';
import 'beaufort_vectors.dart';

class BeaufortSuite implements CipherSuite {
  @override
  String name() => 'beaufort';

  @override
  String category() => 'cipher';

  @override
  SuiteResult run() {
    final Cipher cipher = BeaufortCipher(BeaufortKey.defaultKey());
    var passed = 0;
    var failed = 0;
    final start = DateTime.now();
    for (final sample in beaufortSamples()) {
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
