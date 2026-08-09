import '../../core/cipher.dart';
import '../../core/cipher_suite.dart';
import '../../core/suite_result.dart';
import '../../verify/round_trip.dart';
import 'xorshift_cipher.dart';
import 'xorshift_key.dart';
import 'xorshift_vectors.dart';

class XorShiftSuite implements CipherSuite {
  @override
  String name() => 'xorshift';

  @override
  String category() => 'cipher';

  @override
  SuiteResult run() {
    final Cipher cipher = XorShiftCipher(XorShiftKey.defaultKey());
    var passed = 0;
    var failed = 0;
    final start = DateTime.now();
    for (final sample in xorshiftSamples()) {
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
