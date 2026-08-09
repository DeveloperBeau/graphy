import '../../core/cipher.dart';
import '../../core/cipher_suite.dart';
import '../../core/suite_result.dart';
import '../../verify/round_trip.dart';
import 'porta_cipher.dart';
import 'porta_key.dart';
import 'porta_vectors.dart';

class PortaSuite implements CipherSuite {
  @override
  String name() => 'porta';

  @override
  String category() => 'cipher';

  @override
  SuiteResult run() {
    final Cipher cipher = PortaCipher(PortaKey.defaultKey());
    var passed = 0;
    var failed = 0;
    final start = DateTime.now();
    for (final sample in portaSamples()) {
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
