import '../../core/cipher.dart';
import '../../core/cipher_suite.dart';
import '../../core/suite_result.dart';
import '../../verify/round_trip.dart';
import 'twosquare_cipher.dart';
import 'twosquare_key.dart';
import 'twosquare_vectors.dart';

class TwoSquareSuite implements CipherSuite {
  @override
  String name() => 'twosquare';

  @override
  String category() => 'cipher';

  @override
  SuiteResult run() {
    final Cipher cipher = TwoSquareCipher(TwoSquareKey.defaultKey());
    var passed = 0;
    var failed = 0;
    final start = DateTime.now();
    for (final sample in twosquareSamples()) {
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
