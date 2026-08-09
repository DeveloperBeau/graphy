import '../core/cipher_suite.dart';
import '../ciphers/fnv1a/fnv1a_suite.dart';
import '../ciphers/djb2/djb2_suite.dart';
import '../ciphers/sdbm/sdbm_suite.dart';
import '../ciphers/adler32/adler32_suite.dart';
import '../ciphers/crc32/crc32_suite.dart';
import '../ciphers/fletcher/fletcher_suite.dart';
import '../ciphers/pearson/pearson_suite.dart';

List<CipherSuite> hashSuites() => [
  Fnv1aSuite(),
  Djb2Suite(),
  SdbmSuite(),
  Adler32Suite(),
  Crc32Suite(),
  FletcherSuite(),
  PearsonSuite(),
];
