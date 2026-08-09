import '../../core/cipher.dart';
import '../../core/cipher_suite.dart';
import '../../core/suite_result.dart';
import '../../verify/round_trip.dart';
import 'simon_cipher.dart';
import 'simon_key.dart';
import 'simon_vectors.dart';

class SimonSuite implements CipherSuite {
  @override
  String name() => 'simon';

  @override
  String category() => 'cipher';

  @override
  SuiteResult run() {
    final Cipher cipher = SimonCipher(SimonKey.defaultKey());
    var passed = 0;
    var failed = 0;
    final start = DateTime.now();
    for (final sample in simonSamples()) {
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
