import '../../core/cipher.dart';
import '../../core/cipher_suite.dart';
import '../../core/suite_result.dart';
import '../../verify/round_trip.dart';
import 'tea_cipher.dart';
import 'tea_key.dart';
import 'tea_vectors.dart';

class TeaSuite implements CipherSuite {
  @override
  String name() => 'tea';

  @override
  String category() => 'cipher';

  @override
  SuiteResult run() {
    final Cipher cipher = TeaCipher(TeaKey.defaultKey());
    var passed = 0;
    var failed = 0;
    final start = DateTime.now();
    for (final sample in teaSamples()) {
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
