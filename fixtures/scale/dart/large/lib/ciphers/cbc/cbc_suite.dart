import '../../core/cipher.dart';
import '../../core/cipher_suite.dart';
import '../../core/suite_result.dart';
import '../../verify/round_trip.dart';
import 'cbc_cipher.dart';
import 'cbc_key.dart';
import 'cbc_vectors.dart';

class CbcModeSuite implements CipherSuite {
  @override
  String name() => 'cbc';

  @override
  String category() => 'cipher';

  @override
  SuiteResult run() {
    final Cipher cipher = CbcModeCipher(CbcModeKey.defaultKey());
    var passed = 0;
    var failed = 0;
    final start = DateTime.now();
    for (final sample in cbcSamples()) {
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
