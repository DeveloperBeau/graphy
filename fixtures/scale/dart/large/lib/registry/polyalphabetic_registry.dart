import '../core/cipher_suite.dart';
import '../ciphers/vigenere/vigenere_suite.dart';
import '../ciphers/beaufort/beaufort_suite.dart';
import '../ciphers/variantbeaufort/variantbeaufort_suite.dart';
import '../ciphers/gronsfeld/gronsfeld_suite.dart';
import '../ciphers/autokey/autokey_suite.dart';
import '../ciphers/runningkey/runningkey_suite.dart';
import '../ciphers/porta/porta_suite.dart';

List<CipherSuite> polyalphabeticSuites() => [
  VigenereSuite(),
  BeaufortSuite(),
  VariantBeaufortSuite(),
  GronsfeldSuite(),
  AutokeySuite(),
  RunningKeySuite(),
  PortaSuite(),
];
