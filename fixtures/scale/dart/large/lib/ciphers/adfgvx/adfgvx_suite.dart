import '../../core/cipher.dart';
import '../../core/cipher_suite.dart';
import '../../core/suite_result.dart';
import '../../verify/round_trip.dart';
import 'adfgvx_cipher.dart';
import 'adfgvx_key.dart';
import 'adfgvx_vectors.dart';

class AdfgvxSuite implements CipherSuite {
  @override
  String name() => 'adfgvx';

  @override
  String category() => 'cipher';

  @override
  SuiteResult run() {
    final Cipher cipher = AdfgvxCipher(AdfgvxKey.defaultKey());
    var passed = 0;
    var failed = 0;
    final start = DateTime.now();
    for (final sample in adfgvxSamples()) {
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
