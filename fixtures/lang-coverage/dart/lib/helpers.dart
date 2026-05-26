// feature: class, function, import
import 'dart:core';

class Helpers {
  String formatName(String name) {
    return 'hi, $name';
  }
}

String unrelatedHelper() {
  return 'helper';
}

extension StringExtension on String {
  String shout() => toUpperCase();
}
