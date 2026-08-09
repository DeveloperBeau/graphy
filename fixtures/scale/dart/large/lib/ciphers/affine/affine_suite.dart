import '../../core/cipher.dart';
import '../../core/cipher_suite.dart';
import '../../core/suite_result.dart';
import '../../verify/round_trip.dart';
import 'affine_cipher.dart';
import 'affine_key.dart';
import 'affine_vectors.dart';

class AffineSuite implements CipherSuite {
  @override
  String name() => 'affine';

  @override
  String category() => 'cipher';

  @override
  SuiteResult run() {
    final Cipher cipher = AffineCipher(AffineKey.defaultKey());
    var passed = 0;
    var failed = 0;
    final start = DateTime.now();
    for (final sample in affineSamples()) {
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
