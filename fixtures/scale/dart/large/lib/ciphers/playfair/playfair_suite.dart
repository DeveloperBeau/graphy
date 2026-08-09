import '../../core/cipher.dart';
import '../../core/cipher_suite.dart';
import '../../core/suite_result.dart';
import '../../verify/round_trip.dart';
import 'playfair_cipher.dart';
import 'playfair_key.dart';
import 'playfair_vectors.dart';

class PlayfairSuite implements CipherSuite {
  @override
  String name() => 'playfair';

  @override
  String category() => 'cipher';

  @override
  SuiteResult run() {
    final Cipher cipher = PlayfairCipher(PlayfairKey.defaultKey());
    var passed = 0;
    var failed = 0;
    final start = DateTime.now();
    for (final sample in playfairSamples()) {
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
