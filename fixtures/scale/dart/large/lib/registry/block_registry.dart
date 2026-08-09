import '../core/cipher_suite.dart';
import '../ciphers/feistel/feistel_suite.dart';
import '../ciphers/tea/tea_suite.dart';
import '../ciphers/xtea/xtea_suite.dart';
import '../ciphers/speck/speck_suite.dart';
import '../ciphers/simon/simon_suite.dart';
import '../ciphers/ecb/ecb_suite.dart';
import '../ciphers/cbc/cbc_suite.dart';
import '../ciphers/ctr/ctr_suite.dart';

List<CipherSuite> blockSuites() => [
  FeistelSuite(),
  TeaSuite(),
  XteaSuite(),
  SpeckSuite(),
  SimonSuite(),
  EcbModeSuite(),
  CbcModeSuite(),
  CtrModeSuite(),
];
