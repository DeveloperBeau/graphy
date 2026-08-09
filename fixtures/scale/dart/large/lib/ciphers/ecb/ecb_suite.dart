import '../../core/cipher.dart';
import '../../core/cipher_suite.dart';
import '../../core/suite_result.dart';
import '../../verify/round_trip.dart';
import 'ecb_cipher.dart';
import 'ecb_key.dart';
import 'ecb_vectors.dart';

class EcbModeSuite implements CipherSuite {
  @override
  String name() => 'ecb';

  @override
  String category() => 'cipher';

  @override
  SuiteResult run() {
    final Cipher cipher = EcbModeCipher(EcbModeKey.defaultKey());
    var passed = 0;
    var failed = 0;
    final start = DateTime.now();
    for (final sample in ecbSamples()) {
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
