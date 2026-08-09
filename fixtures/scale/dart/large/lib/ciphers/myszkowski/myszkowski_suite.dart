import '../../core/cipher.dart';
import '../../core/cipher_suite.dart';
import '../../core/suite_result.dart';
import '../../verify/round_trip.dart';
import 'myszkowski_cipher.dart';
import 'myszkowski_key.dart';
import 'myszkowski_vectors.dart';

class MyszkowskiSuite implements CipherSuite {
  @override
  String name() => 'myszkowski';

  @override
  String category() => 'cipher';

  @override
  SuiteResult run() {
    final Cipher cipher = MyszkowskiCipher(MyszkowskiKey.defaultKey());
    var passed = 0;
    var failed = 0;
    final start = DateTime.now();
    for (final sample in myszkowskiSamples()) {
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
