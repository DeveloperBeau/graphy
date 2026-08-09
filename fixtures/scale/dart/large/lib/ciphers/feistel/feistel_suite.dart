import '../../core/cipher.dart';
import '../../core/cipher_suite.dart';
import '../../core/suite_result.dart';
import '../../verify/round_trip.dart';
import 'feistel_cipher.dart';
import 'feistel_key.dart';
import 'feistel_vectors.dart';

class FeistelSuite implements CipherSuite {
  @override
  String name() => 'feistel';

  @override
  String category() => 'cipher';

  @override
  SuiteResult run() {
    final Cipher cipher = FeistelCipher(FeistelKey.defaultKey());
    var passed = 0;
    var failed = 0;
    final start = DateTime.now();
    for (final sample in feistelSamples()) {
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
