import '../../core/cipher.dart';
import '../../core/cipher_suite.dart';
import '../../core/suite_result.dart';
import '../../verify/round_trip.dart';
import 'gronsfeld_cipher.dart';
import 'gronsfeld_key.dart';
import 'gronsfeld_vectors.dart';

class GronsfeldSuite implements CipherSuite {
  @override
  String name() => 'gronsfeld';

  @override
  String category() => 'cipher';

  @override
  SuiteResult run() {
    final Cipher cipher = GronsfeldCipher(GronsfeldKey.defaultKey());
    var passed = 0;
    var failed = 0;
    final start = DateTime.now();
    for (final sample in gronsfeldSamples()) {
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
