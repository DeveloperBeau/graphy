import '../core/cipher_suite.dart';
import '../ciphers/xorcipher/xorcipher_suite.dart';
import '../ciphers/rc4/rc4_suite.dart';
import '../ciphers/xorshift/xorshift_suite.dart';
import '../ciphers/lcg/lcg_suite.dart';

List<CipherSuite> streamSuites() => [
  XorCipherSuite(),
  Rc4Suite(),
  XorShiftSuite(),
  LcgSuite(),
];
