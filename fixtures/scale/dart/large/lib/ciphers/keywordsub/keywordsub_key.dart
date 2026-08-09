class KeywordSubKey {
  final String keyword;

  KeywordSubKey(this.keyword);

  /// Keyword first (duplicates dropped), then the remaining letters in order.
  String mixedAlphabet() {
    final sb = StringBuffer();
    for (final c in '${keyword.toUpperCase()}ABCDEFGHIJKLMNOPQRSTUVWXYZ'.split('')) {
      if (!sb.toString().contains(c)) sb.write(c);
    }
    return sb.toString();
  }

  factory KeywordSubKey.defaultKey() => KeywordSubKey('OBSIDIAN');
}
