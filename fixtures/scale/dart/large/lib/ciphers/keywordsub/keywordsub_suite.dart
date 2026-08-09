import '../../core/cipher.dart';
import '../../core/cipher_suite.dart';
import '../../core/suite_result.dart';
import '../../verify/round_trip.dart';
import 'keywordsub_cipher.dart';
import 'keywordsub_key.dart';
import 'keywordsub_vectors.dart';

class KeywordSubSuite implements CipherSuite {
  @override
  String name() => 'keywordsub';

  @override
  String category() => 'cipher';

  @override
  SuiteResult run() {
    final Cipher cipher = KeywordSubCipher(KeywordSubKey.defaultKey());
    var passed = 0;
    var failed = 0;
    final start = DateTime.now();
    for (final sample in keywordsubSamples()) {
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
