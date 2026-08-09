import '../../core/cipher.dart';
import '../../core/cipher_suite.dart';
import '../../core/suite_result.dart';
import '../../verify/round_trip.dart';
import 'bifid_cipher.dart';
import 'bifid_key.dart';
import 'bifid_vectors.dart';

class BifidSuite implements CipherSuite {
  @override
  String name() => 'bifid';

  @override
  String category() => 'cipher';

  @override
  SuiteResult run() {
    final Cipher cipher = BifidCipher(BifidKey.defaultKey());
    var passed = 0;
    var failed = 0;
    final start = DateTime.now();
    for (final sample in bifidSamples()) {
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
