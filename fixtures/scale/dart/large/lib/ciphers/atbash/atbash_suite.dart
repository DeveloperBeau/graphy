import '../../core/cipher.dart';
import '../../core/cipher_suite.dart';
import '../../core/suite_result.dart';
import '../../verify/round_trip.dart';
import 'atbash_cipher.dart';
import 'atbash_key.dart';
import 'atbash_vectors.dart';

class AtbashSuite implements CipherSuite {
  @override
  String name() => 'atbash';

  @override
  String category() => 'cipher';

  @override
  SuiteResult run() {
    final Cipher cipher = AtbashCipher(AtbashKey.defaultKey());
    var passed = 0;
    var failed = 0;
    final start = DateTime.now();
    for (final sample in atbashSamples()) {
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
