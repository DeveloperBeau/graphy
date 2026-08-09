const symbols = 'ADFGVX';

/// Substitution between grid cells and ADFGVX symbol pairs.
String substituteGrid(String grid, String text) {
  final sb = StringBuffer();
  for (final c in text.split('')) {
    final at = grid.indexOf(c);
    if (at >= 0) {
      sb.write(symbols[at ~/ 6]);
      sb.write(symbols[at % 6]);
    }
  }
  return sb.toString();
}

String unsubstituteGrid(String grid, String encoded) {
  final sb = StringBuffer();
  for (var i = 0; i + 1 < encoded.length; i += 2) {
    final row = symbols.indexOf(encoded[i]);
    final col = symbols.indexOf(encoded[i + 1]);
    if (row >= 0 && col >= 0) sb.write(grid[row * 6 + col]);
  }
  return sb.toString();
}
