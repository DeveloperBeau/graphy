import '../../core/cipher.dart';
import '../../core/cipher_suite.dart';
import '../../core/suite_result.dart';
import '../../verify/round_trip.dart';
import 'railfence_cipher.dart';
import 'railfence_key.dart';
import 'railfence_vectors.dart';

class RailFenceSuite implements CipherSuite {
  @override
  String name() => 'railfence';

  @override
  String category() => 'cipher';

  @override
  SuiteResult run() {
    final Cipher cipher = RailFenceCipher(RailFenceKey.defaultKey());
    var passed = 0;
    var failed = 0;
    final start = DateTime.now();
    for (final sample in railfenceSamples()) {
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
