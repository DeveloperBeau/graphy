import '../../core/cipher.dart';
import '../../core/cipher_suite.dart';
import '../../core/suite_result.dart';
import '../../verify/round_trip.dart';
import 'caesar_cipher.dart';
import 'caesar_key.dart';
import 'caesar_vectors.dart';

class CaesarSuite implements CipherSuite {
  @override
  String name() => 'caesar';

  @override
  String category() => 'cipher';

  @override
  SuiteResult run() {
    final Cipher cipher = CaesarCipher(CaesarKey.defaultKey());
    var passed = 0;
    var failed = 0;
    final start = DateTime.now();
    for (final sample in caesarSamples()) {
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
