import '../../core/cipher.dart';
import '../../core/cipher_suite.dart';
import '../../core/suite_result.dart';
import '../../verify/round_trip.dart';
import 'rot13_cipher.dart';
import 'rot13_key.dart';
import 'rot13_vectors.dart';

class Rot13Suite implements CipherSuite {
  @override
  String name() => 'rot13';

  @override
  String category() => 'cipher';

  @override
  SuiteResult run() {
    final Cipher cipher = Rot13Cipher(Rot13Key.defaultKey());
    var passed = 0;
    var failed = 0;
    final start = DateTime.now();
    for (final sample in rot13Samples()) {
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
