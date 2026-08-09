import '../../core/cipher.dart';
import '../../core/cipher_suite.dart';
import '../../core/suite_result.dart';
import '../../verify/round_trip.dart';
import 'variantbeaufort_cipher.dart';
import 'variantbeaufort_key.dart';
import 'variantbeaufort_vectors.dart';

class VariantBeaufortSuite implements CipherSuite {
  @override
  String name() => 'variantbeaufort';

  @override
  String category() => 'cipher';

  @override
  SuiteResult run() {
    final Cipher cipher = VariantBeaufortCipher(VariantBeaufortKey.defaultKey());
    var passed = 0;
    var failed = 0;
    final start = DateTime.now();
    for (final sample in variantbeaufortSamples()) {
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
