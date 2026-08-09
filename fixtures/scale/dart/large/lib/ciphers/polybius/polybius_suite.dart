import '../../core/cipher.dart';
import '../../core/cipher_suite.dart';
import '../../core/suite_result.dart';
import '../../verify/round_trip.dart';
import 'polybius_cipher.dart';
import 'polybius_key.dart';
import 'polybius_vectors.dart';

class PolybiusSuite implements CipherSuite {
  @override
  String name() => 'polybius';

  @override
  String category() => 'cipher';

  @override
  SuiteResult run() {
    final Cipher cipher = PolybiusCipher(PolybiusKey.defaultKey());
    var passed = 0;
    var failed = 0;
    final start = DateTime.now();
    for (final sample in polybiusSamples()) {
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
