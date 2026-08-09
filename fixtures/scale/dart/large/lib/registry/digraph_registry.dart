import '../core/cipher_suite.dart';
import '../ciphers/playfair/playfair_suite.dart';
import '../ciphers/twosquare/twosquare_suite.dart';
import '../ciphers/foursquare/foursquare_suite.dart';
import '../ciphers/hill/hill_suite.dart';
import '../ciphers/bifid/bifid_suite.dart';
import '../ciphers/adfgvx/adfgvx_suite.dart';

List<CipherSuite> digraphSuites() => [
  PlayfairSuite(),
  TwoSquareSuite(),
  FourSquareSuite(),
  HillSuite(),
  BifidSuite(),
  AdfgvxSuite(),
];
