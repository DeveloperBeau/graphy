import '../core/cipher_suite.dart';
import '../ciphers/railfence/railfence_suite.dart';
import '../ciphers/columnar/columnar_suite.dart';
import '../ciphers/scytale/scytale_suite.dart';
import '../ciphers/route/route_suite.dart';
import '../ciphers/myszkowski/myszkowski_suite.dart';

List<CipherSuite> transpositionSuites() => [
  RailFenceSuite(),
  ColumnarSuite(),
  ScytaleSuite(),
  RouteSuite(),
  MyszkowskiSuite(),
];
