import '../../core/cipher.dart';
import '../../core/cipher_suite.dart';
import '../../core/suite_result.dart';
import '../../verify/round_trip.dart';
import 'foursquare_cipher.dart';
import 'foursquare_key.dart';
import 'foursquare_vectors.dart';

class FourSquareSuite implements CipherSuite {
  @override
  String name() => 'foursquare';

  @override
  String category() => 'cipher';

  @override
  SuiteResult run() {
    final Cipher cipher = FourSquareCipher(FourSquareKey.defaultKey());
    var passed = 0;
    var failed = 0;
    final start = DateTime.now();
    for (final sample in foursquareSamples()) {
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
