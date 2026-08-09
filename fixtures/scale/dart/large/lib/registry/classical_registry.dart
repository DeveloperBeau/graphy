import '../core/cipher_suite.dart';
import '../ciphers/caesar/caesar_suite.dart';
import '../ciphers/rot13/rot13_suite.dart';
import '../ciphers/atbash/atbash_suite.dart';
import '../ciphers/affine/affine_suite.dart';
import '../ciphers/keywordsub/keywordsub_suite.dart';
import '../ciphers/polybius/polybius_suite.dart';

List<CipherSuite> classicalSuites() => [
  CaesarSuite(),
  Rot13Suite(),
  AtbashSuite(),
  AffineSuite(),
  KeywordSubSuite(),
  PolybiusSuite(),
];
