import '../../core/cipher.dart';
import '../../core/cipher_suite.dart';
import '../../core/suite_result.dart';
import '../../verify/round_trip.dart';
import 'ctr_cipher.dart';
import 'ctr_key.dart';
import 'ctr_vectors.dart';

class CtrModeSuite implements CipherSuite {
  @override
  String name() => 'ctr';

  @override
  String category() => 'cipher';

  @override
  SuiteResult run() {
    final Cipher cipher = CtrModeCipher(CtrModeKey.defaultKey());
    var passed = 0;
    var failed = 0;
    final start = DateTime.now();
    for (final sample in ctrSamples()) {
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
