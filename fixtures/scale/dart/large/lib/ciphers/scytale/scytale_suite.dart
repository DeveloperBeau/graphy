import '../../core/cipher.dart';
import '../../core/cipher_suite.dart';
import '../../core/suite_result.dart';
import '../../verify/round_trip.dart';
import 'scytale_cipher.dart';
import 'scytale_key.dart';
import 'scytale_vectors.dart';

class ScytaleSuite implements CipherSuite {
  @override
  String name() => 'scytale';

  @override
  String category() => 'cipher';

  @override
  SuiteResult run() {
    final Cipher cipher = ScytaleCipher(ScytaleKey.defaultKey());
    var passed = 0;
    var failed = 0;
    final start = DateTime.now();
    for (final sample in scytaleSamples()) {
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
