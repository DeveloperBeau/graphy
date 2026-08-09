import '../../core/cipher.dart';
import '../../core/cipher_suite.dart';
import '../../core/suite_result.dart';
import '../../verify/round_trip.dart';
import 'columnar_cipher.dart';
import 'columnar_key.dart';
import 'columnar_vectors.dart';

class ColumnarSuite implements CipherSuite {
  @override
  String name() => 'columnar';

  @override
  String category() => 'cipher';

  @override
  SuiteResult run() {
    final Cipher cipher = ColumnarCipher(ColumnarKey.defaultKey());
    var passed = 0;
    var failed = 0;
    final start = DateTime.now();
    for (final sample in columnarSamples()) {
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
