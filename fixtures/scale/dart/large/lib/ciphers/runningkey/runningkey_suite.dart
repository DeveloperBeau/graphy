import '../../core/cipher.dart';
import '../../core/cipher_suite.dart';
import '../../core/suite_result.dart';
import '../../verify/round_trip.dart';
import 'runningkey_cipher.dart';
import 'runningkey_key.dart';
import 'runningkey_vectors.dart';

class RunningKeySuite implements CipherSuite {
  @override
  String name() => 'runningkey';

  @override
  String category() => 'cipher';

  @override
  SuiteResult run() {
    final Cipher cipher = RunningKeyCipher(RunningKeyKey.defaultKey());
    var passed = 0;
    var failed = 0;
    final start = DateTime.now();
    for (final sample in runningkeySamples()) {
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
