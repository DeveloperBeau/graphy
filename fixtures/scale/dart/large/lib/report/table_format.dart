String formatRow(String name, int passed, int failed, double millis) {
  final ms = millis.toStringAsFixed(2);
  return '${name.padRight(18)} ${passed.toString().padLeft(5)} ${failed.toString().padLeft(5)} ${ms.padLeft(9)}ms';
}

String tableHeader() =>
    '${'suite'.padRight(18)} ${'pass'.padLeft(5)} ${'fail'.padLeft(5)} ${'elapsed'.padLeft(11)}';

/// Separator sized to match the header columns.
String tableRule() => '-' * 42;
