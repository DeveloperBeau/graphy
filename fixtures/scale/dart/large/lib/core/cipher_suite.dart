import 'suite_result.dart';

/// A named group of checks for one cipher or hash family.
abstract class CipherSuite {
  String name();

  SuiteResult run();

  String category();
}
