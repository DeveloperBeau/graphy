import '../../core/cipher.dart';
import '../../core/cipher_suite.dart';
import '../../core/suite_result.dart';
import '../../verify/round_trip.dart';
import 'rc4_cipher.dart';
import 'rc4_key.dart';
import 'rc4_vectors.dart';

class Rc4Suite implements CipherSuite {
  @override
  String name() => 'rc4';

  @override
  String category() => 'cipher';

  @override
  SuiteResult run() {
    final Cipher cipher = Rc4Cipher(Rc4Key.defaultKey());
    var passed = 0;
    var failed = 0;
    final start = DateTime.now();
    for (final sample in rc4Samples()) {
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
