import '../../core/cipher.dart';
import '../../core/cipher_suite.dart';
import '../../core/suite_result.dart';
import '../../verify/round_trip.dart';
import 'xorcipher_cipher.dart';
import 'xorcipher_key.dart';
import 'xorcipher_vectors.dart';

class XorCipherSuite implements CipherSuite {
  @override
  String name() => 'xorcipher';

  @override
  String category() => 'cipher';

  @override
  SuiteResult run() {
    final Cipher cipher = XorCipherCipher(XorCipherKey.defaultKey());
    var passed = 0;
    var failed = 0;
    final start = DateTime.now();
    for (final sample in xorcipherSamples()) {
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
