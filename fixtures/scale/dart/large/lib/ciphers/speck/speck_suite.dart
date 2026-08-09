import '../../core/cipher.dart';
import '../../core/cipher_suite.dart';
import '../../core/suite_result.dart';
import '../../verify/round_trip.dart';
import 'speck_cipher.dart';
import 'speck_key.dart';
import 'speck_vectors.dart';

class SpeckSuite implements CipherSuite {
  @override
  String name() => 'speck';

  @override
  String category() => 'cipher';

  @override
  SuiteResult run() {
    final Cipher cipher = SpeckCipher(SpeckKey.defaultKey());
    var passed = 0;
    var failed = 0;
    final start = DateTime.now();
    for (final sample in speckSamples()) {
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
