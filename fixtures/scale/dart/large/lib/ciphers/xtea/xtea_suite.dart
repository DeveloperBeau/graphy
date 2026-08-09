import '../../core/cipher.dart';
import '../../core/cipher_suite.dart';
import '../../core/suite_result.dart';
import '../../verify/round_trip.dart';
import 'xtea_cipher.dart';
import 'xtea_key.dart';
import 'xtea_vectors.dart';

class XteaSuite implements CipherSuite {
  @override
  String name() => 'xtea';

  @override
  String category() => 'cipher';

  @override
  SuiteResult run() {
    final Cipher cipher = XteaCipher(XteaKey.defaultKey());
    var passed = 0;
    var failed = 0;
    final start = DateTime.now();
    for (final sample in xteaSamples()) {
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
