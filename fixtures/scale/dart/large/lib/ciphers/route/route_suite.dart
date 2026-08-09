import '../../core/cipher.dart';
import '../../core/cipher_suite.dart';
import '../../core/suite_result.dart';
import '../../verify/round_trip.dart';
import 'route_cipher.dart';
import 'route_key.dart';
import 'route_vectors.dart';

class RouteSuite implements CipherSuite {
  @override
  String name() => 'route';

  @override
  String category() => 'cipher';

  @override
  SuiteResult run() {
    final Cipher cipher = RouteCipher(RouteKey.defaultKey());
    var passed = 0;
    var failed = 0;
    final start = DateTime.now();
    for (final sample in routeSamples()) {
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
