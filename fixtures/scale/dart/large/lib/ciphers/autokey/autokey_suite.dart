import '../../core/cipher.dart';
import '../../core/cipher_suite.dart';
import '../../core/suite_result.dart';
import '../../verify/round_trip.dart';
import 'autokey_cipher.dart';
import 'autokey_key.dart';
import 'autokey_vectors.dart';

class AutokeySuite implements CipherSuite {
  @override
  String name() => 'autokey';

  @override
  String category() => 'cipher';

  @override
  SuiteResult run() {
    final Cipher cipher = AutokeyCipher(AutokeyKey.defaultKey());
    var passed = 0;
    var failed = 0;
    final start = DateTime.now();
    for (final sample in autokeySamples()) {
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
